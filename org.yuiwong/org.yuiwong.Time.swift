/* ========================================================================
 * This library is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published
 * by the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 * ======================================================================== */

import Foundation

extension org.yuiwong {
public class Time {
	/**
	 * @name utcSecond
	 */
	public static func utcSecond() -> Int64 {
		let utcSec = time(nil);
		if (time_t(-1) == utcSec) {
			return -1
		} else {
			return Int64(utcSec)
		}
	}

	/**
	 * @name localISO8601MicroTzTimestamp
	 * @desc YYYY-MM-DDThh:mm:ss.ssssss+xx
	 */
	public static func localISO8601MicroTzTimestamp() -> String {
		var utcSec = time(nil);
		if (time_t(-1) == utcSec) {
			return "0000-00-00T00:00:00.000000+00"
		}
		var tv = timeval(tv_sec: 0, tv_usec: 0)
		gettimeofday(&tv, nil)
		var localTm = tm()
		localtime_r(&utcSec, &localTm)
		var ret = String(format: "%.04d", localTm.tm_year + 1900)
		ret += "-"
		ret += String(format: "%.02d", localTm.tm_mon + 1)
		ret += "-"
		ret += String(format: "%.02d", localTm.tm_mday)
		ret += "T"
		ret += String(format: "%.02d", localTm.tm_hour)
		ret += ":"
		ret += String(format: "%.02d", localTm.tm_min)
		ret += ":"
		ret += String(format: "%.02d", localTm.tm_sec)
		ret += "."
		ret += String(format: "%.06d", tv.tv_usec)
		let tz = localTm.tm_gmtoff / 3600
		if (tz >= 0) {
			ret += "+"
		} else {
			ret += "-"
		}
		ret += String(format: "%.02d", tz)
		return ret
	}

	/**
	 * @name localYearDay
	 */
	public static func localYearDay() -> Int32 {
		var utcSec = time(nil);
		if (time_t(-1) == utcSec) {
			return 0
		}
		var localTm = tm()
		localtime_r(&utcSec, &localTm)
		return localTm.tm_yday
	}

	/**
	 * @name heavenlyStems
	 * @desc the ten Heavenly Stems
	 */
	public static var heavenlyStems: Array<String> {
		get {
			return [ "甲", "乙", "丙", "丁", "戊", "己", "庚", "辛", "壬", "癸" ]
		}
	}

	/**
	 * @name earthlyBranches
	 */
	public static var earthlyBranches: Array<String> {
		get {
			return [ "子", "丑", "寅", "卯", "辰", "巳", "午", "未", "申", "酉", "戌", "亥" ]
		}
	}

	/**
	 * @name sixtyYears
	 */
	private static var _sixtyYears: Array<String>? = nil
	public static var sixtyYears: Array<String> {
		get {
			if (nil == _sixtyYears) {
				let hs = heavenlyStems
				let eb = earthlyBranches
				_sixtyYears = [String]()
				for i in 0..<60 {
					_sixtyYears!.append(hs[i % 10] + eb[i % 12])
				}
			}
			return _sixtyYears!
		}
	}

	/**
	 * @name chineseTimestamp (local)
	 * @desc 甲子年正月初一子时
	 */
	public static func chineseTimestamp() -> String {
		let now = Date()
		let chineseCalendar
			= NSCalendar.init(identifier: NSCalendar.Identifier.chinese)
		let thisChineseYear = chineseCalendar?.components(
			NSCalendar.Unit.year,
			from: now)
		let year = thisChineseYear?.year
		if (nil == year) {
			return "甲子年正月初一子时"
		}
		let sy = sixtyYears
		var ret = "\(sy[year! - 1])年"
		let thisChineseMonth = chineseCalendar?.components(
			NSCalendar.Unit.month,
			from: now)
		let month = thisChineseMonth?.month
		if (nil == month) {
			return ret + "正月初一子时"
		}
		let leapMonth = (thisChineseMonth?.isLeapMonth)! ? "闰" : ""
		ret += leapMonth
		switch ((month! - 1) % 12) {
		case 0: ret += "正"
		case 1: ret += "二"
		case 2: ret += "三"
		case 3: ret += "四"
		case 4: ret += "五"
		case 5: ret += "六"
		case 6: ret += "七"
		case 7: ret += "八"
		case 8: ret += "九"
		case 9: ret += "十"
		case 10: ret += "冬"
		case 11: ret += "腊"
		default: ret += "正"
		}
		ret += "月"
		let day = chineseCalendar?.components(
			NSCalendar.Unit.day,
			from: now).day
		if (nil == day) {
			return ret + "初一子时"
		}
		switch ((day! - 1) % 31) {
		case 0: ret += "初一"
		case 1: ret += "初二"
		case 2: ret += "初三"
		case 3: ret += "初四"
		case 4: ret += "初五"
		case 5: ret += "初六"
		case 6: ret += "初七"
		case 7: ret += "初八"
		case 8: ret += "初九"
		case 9: ret += "初十"
		case 10: ret += "十一"
		case 11: ret += "十二"
		case 12: ret += "十三"
		case 13: ret += "十四"
		case 14: ret += "十五"
		case 15: ret += "十六"
		case 16: ret += "十七"
		case 17: ret += "十八"
		case 18: ret += "十九"
		case 19: ret += "二十"
		case 20: ret += "廿一"
		case 21: ret += "廿二"
		case 22: ret += "廿三"
		case 23: ret += "廿四"
		case 24: ret += "廿五"
		case 25: ret += "廿六"
		case 26: ret += "廿七"
		case 27: ret += "廿八"
		case 28: ret += "廿九"
		case 29: ret += "三十"
		default: ret += "初一"
		}
		let hour = chineseCalendar?.components(
			NSCalendar.Unit.hour,
			from: now).hour
		if (nil == hour) {
			return ret + "子时"
		}
		let chineseHour = earthlyBranches[((hour! + 1) % 24) / 2] + "时"
		ret += chineseHour
		let minute = chineseCalendar?.components(
			NSCalendar.Unit.minute,
			from: now).minute
		if ((hour! % 2) != 0) {
			let min = Int(Double(minute!) / 14.4)
			switch (min) {
			case 0: ret += ""
			case 1: ret += "一刻"
			case 2: ret += "二刻"
			case 3: ret += "三刻"
			case 4: ret += "四刻"
			default: ret += ""
			}
		} else {
			let min = Int(Double(minute! + 60) / 14.4)
			switch (min) {
			case 4: ret += "四刻"
			case 5: ret += "五刻"
			case 6: ret += "六刻"
			case 7: ret += "七刻"
			case 8: ret += "八刻"
			default: ret += "四刻"
			}
		}
		return ret
	}
}
}
