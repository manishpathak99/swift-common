import Foundation


/*
 * NAME NSObjectString - class NSObjectString
 *
 * V
 *  - 1.0.0.0_2015100800
 */
public class NSObjectString: NSObject {
	public var s: String?
}


/*
 * NAME StringUtil - class StringUtil
 *
 * V
 *   - 1.0.0.1_2015100020800
 */
public class StringUtil {
	public static func toString () -> String {
		return "StringUtilv1.0.0.0_2015100800"
	}


	/*
	 * NAME split - split string by ONE Character to strings
	 */
	public static func split (string s: String,
		byCharacter separator: Character) -> [String] {
		return s.componentsSeparatedByString(String(separator))
	}


	/*
	 * NAME split - split string by characters to strings
	 */
	public static func split (let string s: String,
		let byString separator: String) -> [String] {
		return s.componentsSeparatedByString(separator)
	}


	/*
	 * NAME charsCount - string characters count
	 */
	public static func charsCount (let ofString s: String) -> Int {
		return s.characters.count
	}


	/*
	 * NAME cstringCount - c string count whenEncoding is encoding
	 */
	public static func cstringCount (let ofString s: String,
		whenEncoding encoding: NSStringEncoding) -> Int {
		if let cs = StringUtil.string2cstring(string: s, encoding: encoding) {
			return cs.count
		} else {
			return -1
		}
	}


	/*
	 * NAME dataCount - c string count whenEncoding is encoding
	 */
	public static func dataCount (let ofString s: String,
		whenEncoding encoding: NSStringEncoding) -> Int {
		return StringUtil.cstringCount(ofString: s, whenEncoding: encoding)
	}


	/*
	 * NAME substring - sub string of string (by character)
	 */
	public static func substring (let ofString s: String, from ib: Int,
		to ie: Int) -> String? {
		let c = s.characters.count

		if ((ib < 0) || (ie > c) || (ie < (ib + 1))) {
			/* LogUtil.trace() */
			return nil
		} else {
			/* LogUtil.trace() */
			var dump = s

			var r = ib
			while (r-- > 0) {
				dump.removeAtIndex(dump.startIndex)
			}

			var _ret = BufferUtil.getBuffer(char_count: 0)
			r = ie - ib
			while (r-- > 0) {
				_ret.append(dump.removeAtIndex(dump.startIndex))
			}

			return String(_ret)
		}
	}


	/*
	 * NAME reverse - reverse string to reversed string
	 */
	public static func reverse (let tostring ori: String) -> String {
		return String(ori.characters.reverse())
	}


	/*
	 * NAME reverse - reverse string to reversed CS
	 */
	public static func reverse (let tocs ori: String) -> [Character] {
		return ori.characters.reverse()
	}


	public static func cstring2string (cstring s: [Int8],
		encoding: NSStringEncoding)
		-> String? {
		/* e.x. NSUTF8StringEncoding */
		return String(CString: s, encoding: encoding)
	}


	public static func cstring2string (cstring s: UnsafeMutablePointer<Int8>,
		encoding: NSStringEncoding)
		-> String? {
		/* e.x. NSUTF8StringEncoding */
		return String(CString: s, encoding: encoding)
	}


	public static func string2cstring (string s: String,
		encoding: NSStringEncoding)
		-> [Int8]? {
		/* e.x. NSUTF8StringEncoding */
		let data = s.dataUsingEncoding(encoding, allowLossyConversion: false)

		if (nil == data) {
			return nil
		}

		let l = data!.length
		var buf: [Int8] = [Int8](count: l, repeatedValue: 0x0)

		LogUtil.v(tag: TAG, items: "len: \(l)")

		data!.getBytes(&buf, length: l)

		return buf
	}


	private static let TAG: String = StringUtil.toString()
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
