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
 * @name struct Random - random util struct
 * @desc org.yuiwong.Random.*
 */
public struct Random {
	/**
	 * @name sgetU64 - get a UInt64 random
	 * @desc org.yuiwong.Random.getU64
	 * @return [0, UInt64.max]
	 */
	static public func getU64(
		start: UInt64 = UInt64.min,
		poorSz: UInt64 = UInt64.max) -> UInt64 {
		var poorSize = poorSz
		if ((poorSize <= 1) || (UInt64.max == start)) {
			return start
		}
		/* E.x. max 10. [1, 15]: 1, 15 => 10 */
		if ((UInt64.max - start) < poorSize) {
			poorSize = (UInt64.max - start) + 1
		}
		var r: UInt64 = 0
		arc4random_buf(&r, MemoryLayout<UInt64>.size)
		if (UInt64.max == poorSize) {
			poorSize -= 1
		}
		/* 0 ~ (poorSize - 1) */
		r = r % poorSize
		r = r + start
		return r
	}
	/**
	 * @name getDouble - get a double random
	 * @desc org.yuiwong.Random.getDouble
	 * @return [0.0, 1.0]
	 */
	static public func getDouble() -> Double {
		srand48(time(nil))
		return drand48()
	}
}
}

public struct OrgYuiwongUnsignedRandom<T> {
	/**
	 * @name get - get a unsigned T random
	 * @desc OrgYuiwongUnsignedRandom.get
	 * @return [T.min, T.max]
	 */
	static public func get(initVal: T) -> T {
		var r: T = initVal
		arc4random_buf(&r, MemoryLayout<T>.size)
		return r
	}
}
