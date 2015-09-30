import Foundation


public class LogUtil {
	public static func trace (
		let name: String = __FILE__,
		let line: Int = __LINE__,
		let funcName: String = __FUNCTION__) {

#if 	ENABLE_LOG
		if (LogUtil.logLevel <= T) {
			let t: String = name + " +\(line) " + funcName
			LogUtil.log(tag: LogUtil.TAG_T, items: t)
		}
#endif

	}


	public static func v (tag t: String?, items: Any ...) {

#if 	ENABLE_LOG
		if (LogUtil.logLevel <= LogUtil.V) {
			LogUtil.log(tag: t, items: LogUtil.TAG_V, items)
		}
#endif

	}


	public static func t (
		let name: String = __FILE__,
		let line: Int = __LINE__,
		let funcName: String = __FUNCTION__,
		tag t: String?, items: Any ...) {

#if 	ENABLE_LOG
		if (LogUtil.logLevel <= T) {
			let trace: String = name + " +\(line) " + funcName

			LogUtil.log(tag: t, items: LogUtil.TAG_T, trace, items)
		}
#endif

	}


	public static func log (level l: Int, tag: String?, items: Any ...) {

#if 	ENABLE_LOG
		if (LogUtil.logLevel <= l) {
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


	public static let V: Int = 2
	public static let T: Int = 3
	public static let TAG_V: String = "VERBOSE"
	public static let TAG_T: String = "TRACE"
	public static var logLevel: Int = LogUtil.V
}
