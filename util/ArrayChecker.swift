import Foundation

public class ArrayChecker<T> {

	/* check and get count >= 0 or error < 0 */
	public static func check (array arr: [T], start: Int = 0,
		count: size_t? = nil) -> Int {

		let ac = arr.count

		/* check */
		if ((start < 0) || (start >= ac)) {
			return Int(-EINVAL)
		}

		/* check */
		if let c = count {
			if ((c < 0) || ((c + start) > ac)) {
				return Int(-EINVAL)
			} else {
				return c
			}
		} else {
			return ac - start
		}

	}
}
