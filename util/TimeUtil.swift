/*
 * NAME TimeUtil.swift - util for time
 *
 * C xcode 7.0.1 and swift 2.1 2015-09-29 +0800
 */
import Foundation


public class TimeUtil {
	public static func toString () -> String {
		return "TimeUtil"
	}


	public static func timestampStr () -> String {
		let now = NSDate()

		let formatter: NSDateFormatter = NSDateFormatter()
		formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

		let s = formatter.stringFromDate(now)

		return s
	}


	public static func timestampName () -> String {
		let now = NSDate()

		let formatter: NSDateFormatter = NSDateFormatter()
		formatter.dateFormat = "yyyyMMddHHmmss"

		let s = formatter.stringFromDate(now)

		return s
	}


	public static func todayName () -> String {
		let now = NSDate()

		let formatter: NSDateFormatter = NSDateFormatter()
		formatter.dateFormat = "yyyyMMdd"

		let s = formatter.stringFromDate(now)

		return s
	}


	public static func timestampstring () -> String {
		let _nowUs = TimeUtil.now()
		let us = _nowUs.tv_usec
		let now = NSDate()

		let formatter: NSDateFormatter = NSDateFormatter()
		formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

		var s = formatter.stringFromDate(now)
		s += ".\(us)"

		return s
	}


	public static func now () -> timeval {
		var tv = timeval(tv_sec: 0, tv_usec: 0)

		gettimeofday(&tv, nil)

		/* print(__LINE__, "s: \(tv.tv_sec) us: \(tv.tv_usec)") */

		return tv
	}


	public static func makeid () -> UInt64 {
		var tv = timeval(tv_sec: 0, tv_usec: 0)

		gettimeofday(&tv, nil)

		let _ret = (BasicTypeUtil.__darwin_time_t2double(from: tv.tv_sec)
			* 1e6) + BasicTypeUtil.__darwin_suseconds_t2double(from: tv.tv_usec)

		let ret = BasicTypeUtil.double2uint64(from: _ret)

		Log.v(tag: TAG, items: "id: \(ret)")

		return ret
	}


	public static func currentMicrosecond () -> UInt64 {
		return TimeUtil.makeid()
	}

	private static let TAG: String = TimeUtil.toString()
}