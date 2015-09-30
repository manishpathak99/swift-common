import Foundation


class StringUtil {
	static func cstring2string (cstring s: [Int8], encoding: NSStringEncoding)
		-> String? {
		/* e.x. NSUTF8StringEncoding */
		return String(CString: s, encoding: encoding)
	}


	static func cstring2string (cstring s: UnsafeMutablePointer<Int8>,
		encoding: NSStringEncoding)
		-> String? {
		/* e.x. NSUTF8StringEncoding */
		return String(CString: s, encoding: encoding)
	}


	static func string2cstring (string s: String, encoding: NSStringEncoding)
		-> [Int8]? {
		/* e.x. NSUTF8StringEncoding */
		let data = s.dataUsingEncoding(encoding)

		if (nil == data) {
			return nil
		}

		var buf: [Int8] = [Int8](count: data!.length, repeatedValue: 0x0)

		data!.getBytes(&buf, length: data!.length)

		return buf
	}
}


func string2double (s: String) -> Double {
	return NSNumberFormatter().numberFromString(s)!.doubleValue
}


func string2uint8 (s: String) -> UInt8 {
	return UInt8(NSNumberFormatter().numberFromString(s)!.unsignedShortValue)
}


/*
 * NAME numeric2string - to string
 */
func numeric2string (d: Double) -> String {
	/* Double to String no .0 suffix */
	let s: String = "\(d)"

	if (s.hasSuffix(".0")) {
		let n = s.characters.count
		return String(s.characters.prefix(n - 2))
	} else {
		return s
	}
}


func numeric2string (i: Int) -> String {
	/* Int to String */
	let s: String = "\(i)"

	return s
}


func numeric2string (i: Int32) -> String {
	/* Int32 to String */
	let s: String = "\(i)"

	return s
}


func numeric2string (u: UInt32) -> String {
	/* UInt32 to String */
	let s: String = "\(u)"

	return s
}


/*
 * NAME append2string - this is for <Integer>.<Frac>
 *
 * DESCRIPTION
 *   E.x. "1.1", 3, 1 => "1.13"
 *   "1.012", 3, 5 => "1.012003"
 */
func append2string (final s: String, frac: UInt8, n: UInt32) -> String {
	var res = s

	print(s, frac, n)

	if (res.characters.contains(".")) {
		let ss = res.characters.split(".")
		let l = ss[1].count
		let le = n - UInt32(l)

		for (var i: UInt32 = 0; i < le; ++i) {
			res += "0"
		}

		res += numeric2string(UInt32(frac))
	} else {
		res += "."
		for (var i: UInt32 = 0; i < n; ++i) {
			res += "0"
		}
		res += numeric2string(UInt32(frac))
	}

	return res
}
