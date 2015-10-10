import Foundation


public class LogUtil {
	public static func trace (
		let name: String = __FILE__,
		let line: Int = __LINE__,
		let funcName: String = __FUNCTION__) {

#if 	ENABLE_LOG
		if (LogUtil.T >= LogUtil.logLevel) {
			let t: String = name + " +\(line) " + funcName

			LogUtil.log(tag: LogUtil.TAG_T, items: t)
		}
#endif

	}


	public static func v (
		let name: String = __FILE__,
		let line: Int = __LINE__,
		let funcName: String = __FUNCTION__,
		tag t: String?, items: Any ...) {

#if 	ENABLE_LOG
		if (LogUtil.V >= LogUtil.logLevel) {
			let trace: String = name + " +\(line) " + funcName

			var msg: String = LogUtil.TAG_V
			if let tt = t {
				msg += " " + tt
			}

			for i in items {
				msg += " \(i)"
			}
			msg += " ." + trace

			LogUtil.log(msg)
		}
#endif

	}


	public static func t (
		let name: String = __FILE__,
		let line: Int = __LINE__,
		let funcName: String = __FUNCTION__,
		tag t: String?, items: Any ...) {

#if 	ENABLE_LOG
		if (LogUtil.T >= LogUtil.logLevel) {
			let trace: String = name + " +\(line) " + funcName

			var msg: String = LogUtil.TAG_T
			if let tt = t {
				msg += " " + tt
			}

			for i in items {
				msg += " \(i)"
			}
			msg += " ." + trace

			LogUtil.log(msg)
		}
#endif

	}


	public static func i (
		let name: String = __FILE__,
		let line: Int = __LINE__,
		let funcName: String = __FUNCTION__,
		tag t: String?, items: Any ...) {

#if 	ENABLE_LOG
		if (LogUtil.I >= LogUtil.logLevel) {
			let trace: String = name + " +\(line) " + funcName

			var msg: String = LogUtil.TAG_I
			if let tt = t {
				msg += " " + tt
			}

			for i in items {
				msg += " \(i)"
			}
			msg += " ." + trace

			LogUtil.log(msg)
		}
#endif

	}


	public static func w (
		let name: String = __FILE__,
		let line: Int = __LINE__,
		let funcName: String = __FUNCTION__,
		tag t: String?, items: Any ...) {

#if 	ENABLE_LOG
		if (LogUtil.I >= LogUtil.logLevel) {
			let trace: String = name + " +\(line) " + funcName

			var msg: String = LogUtil.TAG_W
			if let tt = t {
				msg += " " + tt
			}

			for i in items {
				msg += " \(i)"
			}
			msg += " ." + trace

			LogUtil.log(msg)
		}
#endif

	}


	public static func e (
		let name: String = __FILE__,
		let line: Int = __LINE__,
		let funcName: String = __FUNCTION__,
		tag t: String?, items: Any ...) {

#if 	ENABLE_LOG
		if (LogUtil.I >= LogUtil.logLevel) {
			let trace: String = name + " +\(line) " + funcName

			var msg: String = LogUtil.TAG_E
			if let tt = t {
				msg += " " + tt
			}

			for i in items {
				msg += " \(i)"
			}
			msg += " ." + trace

			LogUtil.log(msg)
		}
#endif

	}


	public static func log (level l: Int, tag: String?, items: Any ...) {

#if 	ENABLE_LOG
		if (l >= LogUtil.logLevel) {
			let ts = TimeUtil.timestampstring()

			var msg = ts

			if let t = tag {
				msg += " " + t
			}

			for i in items {
				msg += " \(i)"
			}

			print(msg)
		}
#endif

	}


	public static func log (tag t: String?, items: Any ...) {

#if 	ENABLE_LOG
		let ts = TimeUtil.timestampstring()

		var msg = ts

		if let tt = t {
			msg += " " + tt
		}

		for i in items {
			msg += " \(i)"
		}

		print(msg)
#endif

	}


	public static func log (items: Any ...) {

#if 	ENABLE_LOG
		let ts = TimeUtil.timestampstring()

		var msg = ts

		for i in items {
			msg += " \(i)"
		}

		print(msg)
#endif

	}


	public static func purePrint (items: Any ...) {

#if 	ENABLE_LOG
		print(items)
#endif

	}


	public static let V: Int = 8
	public static let D: Int = 9
	public static let T: Int = 16
	public static let I: Int = 24
	public static let W: Int = 32
	public static let E: Int = 40
	public static let F: Int = 48
	public static let TAG_V: String = "lvVERBOSE"
	public static let TAG_D: String = "lvDEBUG"
	public static let TAG_T: String = "lvTRACE"
	public static let TAG_I: String = "lvINFO"
	public static let TAG_W: String = "lvWARN"
	public static let TAG_E: String = "lvERROR"
	public static let TAG_F: String = "lvFATAL"
	public static var logLevel: Int = LogUtil.V
}
