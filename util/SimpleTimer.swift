import Foundation


private final class SimpleTimerData {
	private var timerID: UInt32 = SimpleTimer.TIMER_ID_INVALID
	private var afterMsec: UInt32 = 0
	private var onTimerExit: ((UInt32) -> Int32)!
	private var timerThread: Pthread!
	private var start: Bool = false
	private var stop: Bool = true
}


private final class SimpleTimerManager {

	private static func getTimerData (byTimerID id: UInt32)
		-> SimpleTimerData? {

		SimpleTimerManager.LOCK()

		let ret = SimpleTimerManager.__timerMap[id]

		SimpleTimerManager.UNLOCK()

		return ret

	}


	private static func setTimerData (byTimerID id: UInt32,
		to: SimpleTimerData)
		-> Bool {

		SimpleTimerManager.LOCK()

		let ret: Bool?
		let _ret = SimpleTimerManager.__timerMap[id]

		if (nil == _ret) {
			ret = false
		} else {
			SimpleTimerManager.__timerMap[id] = to
			ret = true
		}

		SimpleTimerManager.UNLOCK()

		return ret!

	}


	private static func markTimerStop (byTimerID id: UInt32)
		-> Bool {

		SimpleTimerManager.LOCK()

		var succ: Bool?

		if let td = SimpleTimerManager.__timerMap[id] {
			td.stop = true
			succ = true
		} else {
			succ = false
		}

		SimpleTimerManager.UNLOCK()

		return succ!

	}


	private static func threadCreated (withPair pair:
		(timerID: UInt32, data: SimpleTimerData)) {

		SimpleTimerManager.LOCK()

		/* just .. no U64.max threads */
		++SimpleTimerManager.__nthreads

		/*and id and data */
		pair.data.timerID = pair.timerID
		SimpleTimerManager.__timerMap[pair.timerID] = pair.data

		SimpleTimerManager.UNLOCK()

	}


	private static func theadFinished (timerID tiid: UInt32) -> Bool {

		SimpleTimerManager.LOCK()

		let ret: Bool?

		if (UInt64.min != SimpleTimerManager.__nthreads) {
			/* remove in map */
			SimpleTimerManager.__timerMap.removeValueForKey(tiid)
			/* -- count */
			--SimpleTimerManager.__nthreads
			ret = true
		} else {
			ret = false
		}

		SimpleTimerManager.UNLOCK()

		return ret!

	}


	/* just for show */
	private static func getNThreads () -> UInt64 {

		SimpleTimerManager.LOCK()

		let ret = SimpleTimerManager.__nthreads

		SimpleTimerManager.UNLOCK()

		return ret

	}


	private static let NTHREADS_INVALID: UInt64 = 0

	private static var __timerMap: Dictionary<UInt32, SimpleTimerData>
		= [UInt32: SimpleTimerData]()
	static private var __nthreads: UInt64
		= SimpleTimerManager.NTHREADS_INVALID

	/*
	 * NAME LOCK - lock
	 */
	private static func LOCK () {
		while (self.LOCKED) {
			usleep(BasisConfigRO.COMMON_LOCK_SLICE)
		}

		self.LOCKED = true
	}


	/*
	 * NAME UNLOCK - unlock
	 */
	private static func UNLOCK () {
		self.LOCKED = false
	}

	/*
	 * NAME LOCKED - var locked
	 */
	private static var LOCKED: Bool = false

}


private func __timerRoutine (timerID: UInt32) -> Int32 {

	let nts = SimpleTimerManager.getNThreads()
	let s = String(format: "%u", arguments: [timerID])
	Log.i(tag: SimpleTimer.TAG, items: "timerID:", s, "nts", nts)

	let sdo: SimpleTimerData? = SimpleTimerManager.getTimerData(byTimerID:
		timerID)

	if (nil == sdo) {
		Log.w(tag: SimpleTimer.TAG, items: "no SimpleTimerData: exit")
		SimpleTimerManager.theadFinished(timerID: timerID)
		return 0
	}

	let sd: SimpleTimerData = sdo!

	/* wait start */
	var start = false
	repeat {
		start = sd.start

		if (start) {
			usleep(1000)
		}
	} while (!start)

	let onTimerExit = sd.onTimerExit!
	let per: UInt32 = 10
	let am = sd.afterMsec
	var nc: Int64 = Int64(am) / Int64(per)

	var stop: Bool = true
	while (nc-- > 0) {
		stop = sd.stop
		if (stop) {
			SimpleTimerManager.theadFinished(timerID: timerID)
			Log.i(tag: SimpleTimer.TAG, items: "stop: callback: exit")
			onTimerExit(UInt32(nc + 1) * per)
			return 0
		}

		usleep(per * 1000)
	}

	SimpleTimerManager.theadFinished(timerID: timerID)
	Log.i(tag: SimpleTimer.TAG, items: "timeup: callback exit")
	onTimerExit(0)

	Log.i(tag: SimpleTimer.TAG, items: "exit")
	return 0
}


public class SimpleTimerHelper {

	public static func startSimpleTimer (
		afterMsec: UInt32,
		onTimerExit: ((UInt32) -> Int32))
		-> (code: Int32, timerID: UInt32) {

		/* check */
		if (afterMsec < SimpleTimer.TIMER_MIN) {
			return (-EINVAL, SimpleTimer.TIMER_ID_INVALID)
		}

		let st = SimpleTimer()
		let t = Pthread()

		let u64id = TimeUtil.makeid()
		let ids = "\(u64id)"
		let idsdata = StringUtil.toData(fromString: ids)
		let crc32 = CRC.crc32(idsdata!)
		let ret = t.start(routineu32: __timerRoutine, argument: crc32)

		if (0 == ret) {
			/* success */
			let td = SimpleTimerData()

			td.timerThread = t
			td.afterMsec = afterMsec
			td.onTimerExit = onTimerExit
			st.timerData = td

			SimpleTimerManager.threadCreated(withPair: (crc32, td))

			td.stop = false
			td.start = true

			return (0, td.timerID)
		} else {
			/* fail */
			return (-ret, SimpleTimer.TIMER_ID_INVALID)
		}

	}


	public static func stopSimpleTimerReady (byTimerID id: UInt32) -> Bool {

		/* false when no such timer */
		return SimpleTimerManager.markTimerStop(byTimerID: id)

	}

}


public class SimpleTimer {

	public static let TIMER_MIN: UInt32 = 5 /* msec */

	public static let TIMER_ID_INVALID: UInt32 = 0

	public var timerID: UInt32 {
		return self.timerData!.timerID
	}

	private static let TAG = "SimpleTimer"

	private var timerData: SimpleTimerData!

}
