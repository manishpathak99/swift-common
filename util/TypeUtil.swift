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
	public static func cstring2uint8x (fromCstring cs: [Int8],
		size: size_t) -> array<UInt8>? {

		if ((size < 0) || (size > cs.count)) {
			return nil
		}

		let ret = array<UInt8>(count: UInt(size), repeatedValue: 0x0)

		for i in 0..<size {
			ret.data![i] = UInt8(cs[i])
		}

		return ret

	}


	public static func cdata2uint8x (from data: UnsafePointer<Void>,
		size: size_t) -> array<UInt8>? {

		if ((nil == data) || (size < 0)) {
			return nil
		}

		let ret = array<UInt8>(count: UInt(size), repeatedValue: 0x0)

		for i in 0..<size {
			ret.data![i] = UInt8(data[i])
		}

		return ret

	}
}