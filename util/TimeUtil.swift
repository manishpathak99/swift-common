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
}