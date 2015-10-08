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

			LogUtil.log(tag: t, items: LogUtil.TAG_V, items, trace)
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

			LogUtil.log(tag: t, items: LogUtil.TAG_I, items, trace)
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

			LogUtil.log(tag: t, items: LogUtil.TAG_T, trace, items)
		}
#endif

	}


	public static func log (level l: Int, tag: String?, items: Any ...) {

#if 	ENABLE_LOG
		if (l >= LogUtil.logLevel) {
			let ts = TimeUtil.timestampstring()

			if (nil != tag) {
				print(ts, tag!, items)
			} else {
				print(ts, items)
			}
		}
#endif

	}


	public static func log (tag t: String?, items: Any ...) {

#if 	ENABLE_LOG
		let ts = TimeUtil.timestampstring()

		if (nil != t) {
			print(ts, t!, items)
		} else {
			print(ts, items)
		}
#endif

	}


	public static func log (items: Any ...) {

#if 	ENABLE_LOG
		let ts = TimeUtil.timestampstring()

		print(ts, items)
#endif

	}


	public static func purePrint (items: Any ...) {

#if 	ENABLE_LOG
		print(items)
#endif

	}


	public static let V: Int = 8
	public static let T: Int = 16
	public static let I: Int = 24
	public static let TAG_V: String = "VERBOSE"
	public static let TAG_T: String = "TRACE"
	public static let TAG_I: String = "INFO"
	public static var logLevel: Int = LogUtil.V
}
