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
public class StringUtil {
	/**
	 * @name subString - sub string of String (by character)
	 * @ desc from @startCharIndex and max @count chars
	 */
	public static func subString (
		ofString s: String,
		fromCharIndex bi: UInt64,
		maxCount mc: UInt64) -> String? {
		let ec = s.characters.count
		if ((0 == mc) || (bi >= (UInt64(ec)))) {
			return nil
		}
		var maxC: UInt64
		if ((UInt64(ec) - bi) < mc) {
			maxC = UInt64(ec) - bi
		} else {
			maxC = mc
		}
		let start = s.index(s.startIndex, offsetBy: Int(bi))
		var endoff = bi + maxC
		endoff -= 1
		let end = s.index(s.startIndex, offsetBy: Int(endoff))
		return s[start...end]
	}

	/**
	 * @name length - ofCharactersOfString
	 */
	public static func length(ofCharactersOfString s: String) -> UInt64 {
		return UInt64(s.characters.count)
	}

	/**
	 * @name endWith - is end with parren - the provided String
	 */
	public static func endWith(
		pattern sp: String,
		theString s: String) -> Bool {
		return s.hasSuffix(sp)
	}

	/**
	 * @name formDouble - Double to String
	 */
	public static func fromDouble(
		_ d: Double, keepSuffix ks: Bool = false) -> String {
		/* Double to String no .0 suffix */
		let s: String = "\(d)"
		if ((!ks) && s.hasSuffix(".0")) {
			let n = s.characters.count
			return String(s.characters.prefix(n - 2))
		} else {
			return s
		}
	}
}
}
