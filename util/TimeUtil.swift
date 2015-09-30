/*
 * NAME TimeUtil.swift - util for time
 *
 * C xcode 7.0.1 and swift 2.1 2015-09-29 +0800
 */
import Foundation


class TimeUtil {
	static func timestampStr () -> String {
		let now = NSDate()

		let formatter: NSDateFormatter = NSDateFormatter()
		formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

		let s = formatter.stringFromDate(now)

		return s
	}


	static func timestampstring () -> String {
		let _nowUs = TimeUtil.now()
		let us = _nowUs.tv_usec
		let now = NSDate()

		let formatter: NSDateFormatter = NSDateFormatter()
		formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

		var s = formatter.stringFromDate(now)
		s += ".\(us)"

		return s
	}


	static func now () -> (timeval) {
		var tv = timeval(tv_sec: 0, tv_usec: 0)

		gettimeofday(&tv, nil)

		/* print(__LINE__, "s: \(tv.tv_sec) us: \(tv.tv_usec)") */

		return tv
	}
}