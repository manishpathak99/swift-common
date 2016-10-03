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
}
}
