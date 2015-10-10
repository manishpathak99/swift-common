import Foundation


public class array <T> {
	public init () {
		LOCK()

		self.data = [T]()

		UNLOCK()
	}


	public init (count c: UInt, repeatedValue rv: T) {
		LOCK()

		if (c <= 0) {
			self.data = [T]()
		} else {
			self.data = [T](count: Int(c), repeatedValue: rv)
		}

		UNLOCK()
	}


	public func finish () {
		LOCK()

		self.data = nil

		UNLOCK()
	}


	public func bvalue (value v: T) -> Bool {
		var ret: Bool?

		LOCK()

		if (nil == self.data) {
			ret = false
		} else {
			let c = self.data!.count

			for i in 0..<c {
				self.data![i] = v
			}

			ret = true
		}

		UNLOCK()

		return ret!
	}


	public func getData (fromStart s: UInt64, bytes: UInt64) -> [T]? {
		var ret: [T]?

		LOCK()

		if ((nil == self.data) || (bytes <= 0)) {
			ret = nil
		} else {
			let c = self.data!.count

			if ((s + bytes) > UInt64(c)) {
				ret = nil
			} else {
				let rv = self.data![0]
				ret = [T](count: Int(c), repeatedValue: rv)

				for i in s..<(s + bytes) {
					ret![Int(i - s)] = self.data![Int(i)]
				}
			}
		}

		UNLOCK()

		return ret!
	}


	/*
	* NAME LOCK - lock
	*/
	private final func LOCK () {
		while (self.LOCKED) {
			usleep(self.LOCK_SLICE)
		}

		self.LOCKED = true
	}


	/*
	* NAME UNLOCK - unlock
	*/
	private final func UNLOCK () {
		self.LOCKED = false
	}


	public var data: [T]?

	/*
	 * NAME LOCKED - var locked
	 */
	private final var LOCKED: Bool = false


	private final let LOCK_SLICE: UInt32 = UInt32(5 * 1e3)
}
