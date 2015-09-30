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