import Foundation

public class BasicTypeUtil {
	public static func __darwin_suseconds_t2double
		(from s: __darwin_suseconds_t) 
		-> Double {
		return Double(s)
	}


	public static func __darwin_time_t2double (from t: __darwin_time_t)
		-> Double {
		return Double(t)
	}


	public static func double2uint64 (from d: Double)
		-> UInt64 {
		return UInt64(d)
	}


	public static func int2double (from i: Int)
		-> Double {
		return Double(i)
	}


	public static func int322double (from i32: Int32)
		-> Double {
		return Double(i32)
	}
}


public class TypeUtil {

	public static func int8x2data (int8x arr: [Int8],
		start: Int = 0, count: size_t? = nil) -> [UInt8]? {

		let cc = ArrayChecker.check(array: arr, start: start, count: count)

		if (cc < 0) {
			return nil
		}

		if (0 == cc) {
			/* empty */
			return [UInt8]()
		} else {
			let nsdata = NSData(bytes: arr, length: cc)
			var buf = [UInt8](count: cc, repeatedValue: 0x0)

			nsdata.getBytes(&buf, range: NSRange(start..<(start + cc)))

			return buf
		}

	}


	public static func int8x2data (allInt8x arr: [Int8]) -> [UInt8] {

		if (0 == arr.count) {
			/* empty */
			return [UInt8]()
		} else {
			let c = arr.count

			let nsdata = NSData(bytes: arr, length: c)
			var buf = [UInt8](count: c, repeatedValue: 0x0)

			nsdata.getBytes(&buf, length: c)

			return buf
		}

	}


	public static func data2int8x (data arr: [UInt8],
		start: Int = 0, count: size_t? = nil) -> [Int8]? {

		let cc = ArrayChecker.check(array: arr, start: start, count: count)

		if (cc < 0) {
			return nil
		}

		if (0 == cc) {
			/* empty */
			return [Int8]()
		} else {
			let nsdata = NSData(bytes: arr, length: cc)
			var buf = [Int8](count: cc, repeatedValue: 0x0)

			nsdata.getBytes(&buf, range: NSRange(start..<(start + cc)))

			return buf
		}

	}


	public static func data2int8x (allData arr: [UInt8]) -> [Int8] {

		if (0 == arr.count) {
			/* empty */
			return [Int8]()
		} else {
			let c = arr.count

			let nsdata = NSData(bytes: arr, length: c)
			var buf = [Int8](count: c, repeatedValue: 0x0)

			nsdata.getBytes(&buf, length: c)

			return buf
		}

	}

}