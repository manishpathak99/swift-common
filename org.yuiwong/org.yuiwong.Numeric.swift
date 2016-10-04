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
/**
 * @name struct Numeric - numeric util struct
 * @desc org.yuiwong.Numeric.*
 */
public struct Numeric {
	/**
	 * @name toUInt64 - fromDouble
	 * @fail if double to large
	 */
	public static func toUInt64(fromDouble d: Double) -> UInt64? {
		if (d > Double(UInt64.max)) {
			return nil
		}
		return UInt64(d)
	}

	/**
	 * @name isGreaterThanUInt64Max - ofDouble - if double > UInt64.max
	 * @note @d should not NaN
	 */
	public static func isGreaterThanUInt64Max(ofDouble d: Double) -> Bool {
		return ((Double.infinity == d) || (d > Double(UInt64.max)))
	}

	/**
	 * @name isLEInt64Max - ofDouble - if double <= Int64.max
	 * @note @d should not NaN
	 */
	public static func isLEInt64Max(ofDouble d: Double) -> Bool {
		return (d <= Double(Int64.max))
	}

	/**
	 * @name isGEInt64Min - ofDouble - if double >= Int64.min
	 * @note @d should not NaN
	 */
	public static func isGEInt64Min(ofDouble d: Double) -> Bool {
		return (d >= Double(Int64.min))
	}

	/**
	 * @name canCastToInt64 - chk double if valid
	 */
	public static func canCastToInt64(ofDouble d: Double) -> Bool {
		if (d.isNaN) {
			return false
		}
		if ((Double.infinity == d) || (-Double.infinity == d)) {
			return false
		}
		return ((d >= Double(Int64.min)) && (d <= Double(Int64.max)))
	}
}
}
