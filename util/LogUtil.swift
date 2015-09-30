import Foundation


class LogUtil {
	static func trace (file name: String = __FILE__,
		line: Int = __LINE__,
		funcName: String = __FUNCTION__) {

#if 	ENABLE_LOG
		if (LogUtil.logLevel <= T) {
			let t: String = name + " +\(line) " + funcName
			LogUtil.log(msg: t)
		}
#endif

	}


	static func log (msg s: String? = nil) {

#if 	ENABLE_LOG
		var lm: String = TimeUtil.timestampstring()

		if (nil != s) {
			lm += " " + s!
		}

		print(lm)
#endif

	}

	static let V: Int = 2
	static let T: Int = 3
	static var logLevel: Int = LogUtil.V
}
