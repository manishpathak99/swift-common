import Foundation


public class Log {
	public static func trace (
		let name: String = __FILE__,
		let line: Int = __LINE__,
		let funcName: String = __FUNCTION__) {

#if 	ENABLE_LOG
		if (Log.T >= Log.logLevel) {
			let t: String = name + " +\(line) " + funcName

			Log.log(tag: Log.TAG_T, items: t)
		}
#endif

	}


	public static func v (
		tag t: String?, items: Any ...,
		let name: String = __FILE__,
		let line: Int = __LINE__,
		let funcName: String = __FUNCTION__) {

#if 	ENABLE_LOG
		if (Log.V >= Log.logLevel) {
			let trace: String = name + " +\(line) " + funcName

			var msg: String = Log.TAG_V
			if let tt = t {
				msg += " " + tt
			}

			for i in items {
				msg += " \(i)"
			}
			msg += " ." + trace

			Log.log(msg)
		}
#endif

	}


	public static func t (
		tag t: String?, items: Any ...,
		let name: String = __FILE__,
		let line: Int = __LINE__,
		let funcName: String = __FUNCTION__) {

#if 	ENABLE_LOG
		if (Log.T >= Log.logLevel) {
			let trace: String = name + " +\(line) " + funcName

			var msg: String = Log.TAG_T
			if let tt = t {
				msg += " " + tt
			}

			for i in items {
				msg += " \(i)"
			}
			msg += " ." + trace

			Log.log(msg)
		}
#endif

	}


	public static func i (
		tag t: String?, items: Any ...,
		let name: String = __FILE__,
		let line: Int = __LINE__,
		let funcName: String = __FUNCTION__) {

#if 	ENABLE_LOG
		if (Log.I >= Log.logLevel) {
			let trace: String = name + " +\(line) " + funcName

			var msg: String = Log.TAG_I
			if let tt = t {
				msg += " " + tt
			}

			for i in items {
				msg += " \(i)"
			}
			msg += " ." + trace

			Log.log(msg)
		}
#endif

	}


	public static func w (
		tag t: String?, items: Any ...,
		let name: String = __FILE__,
		let line: Int = __LINE__,
		let funcName: String = __FUNCTION__) {

#if 	ENABLE_LOG
		if (Log.I >= Log.logLevel) {
			let trace: String = name + " +\(line) " + funcName

			var msg: String = Log.TAG_W
			if let tt = t {
				msg += " " + tt
			}

			for i in items {
				msg += " \(i)"
			}
			msg += " ." + trace

			Log.log(msg)
		}
#endif

	}


	public static func e (
		tag t: String?, items: Any ...,
		let name: String = __FILE__,
		let line: Int = __LINE__,
		let funcName: String = __FUNCTION__) {

#if 	ENABLE_LOG
		if (Log.I >= Log.logLevel) {
			let trace: String = name + " +\(line) " + funcName

			var msg: String = Log.TAG_E
			if let tt = t {
				msg += " " + tt
			}

			for i in items {
				msg += " \(i)"
			}
			msg += " ." + trace

			Log.log(msg)
		}
#endif

	}


	public static func log (level l: Int, tag: String?, items: Any ...) {

#if 	ENABLE_LOG
		if (l >= Log.logLevel) {
			let ts = TimeUtil.timestampstring()

			var msg = ts

			if let t = tag {
				msg += " " + t
			}

			for i in items {
				msg += " \(i)"
			}

			print(msg)
			Log.readyFile()
			let ap = StringUtil.tocstringArray(fromString: msg,
				encoding: NSUTF8StringEncoding)
			ap!.data!.append(10)
			FileIO.append(int8_data: ap!, toFile: Log.logFile!)
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
		Log.readyFile()
		let ap = StringUtil.tocstringArray(fromString: msg,
			encoding: NSUTF8StringEncoding)
		ap!.data!.append(10)
		FileIO.append(int8_data: ap!, toFile: Log.logFile!)
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
		Log.readyFile()
		let ap = StringUtil.tocstringArray(fromString: msg,
			encoding: NSUTF8StringEncoding)
		ap!.data!.append(10)
		FileIO.append(int8_data: ap!, toFile: Log.logFile!)
#endif

	}


	public static func purePrint (items: Any ...) {

#if 	ENABLE_LOG
		print(items)
#endif

	}


	public static func readyFile () {
#if 	ENABLE_LOG
		let td = TimeUtil.todayName()

		if ( ((nil != Log.fileLogDate) && (td > Log.fileLogDate!))
			|| (nil == Log.fileLogDate)) {
			Log.fileLogDate = td
			let dp = AppUtil.getAppDocPath()

			Log.fileLog = dp! + "/log/" + td + ".log"
			FileUtil.Mkdir(dir: dp! + "/log", parent: false)

			if (nil == Log.logFile) {
				Log.logFile = FileAppend(withToPath: Log.fileLog!,
					oflag: O_WRONLY | O_APPEND | O_CREAT,
					createMode:
					mode_t(StringUtil.toInt(fromOctString: "664")))
				if (nil == Log.logFile) {
					print("ERROR")
				}
			} else {
				Log.logFile!.reinit(withToPath: Log.fileLog!,
					oflag: O_WRONLY | O_APPEND | O_CREAT,
					createMode:
					mode_t(StringUtil.toInt(fromOctString: "664")))
			}
		}
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
	public static var logLevel: Int = Log.V

	private static var logFile: FileAppend?
	private static var fileLog: String?
	private static var fileLogDate: String?
}
