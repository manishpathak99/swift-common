/*
 * NAME StringUtil - string util
 *
 * DESC
 *  - Current for iOS 9
 *  - See diffs: (2015-10-04 17:43:24 +0800)
 *  https://developer.apple.com/library/prerelease/ios/releasenotes/General/iOS90APIDiffs/Swift/Swift.html
 *
 * V. See below
 */


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
 *   - 1.0.0.3_20151009175522800
 */
public class StringUtil {
	public static func toString () -> String {
		return "StringUtilv1.0.0.3_20151009175522800"
	}


	/*
	 * NAME toString - from String Array
	 *
	 * ARGS
	 *  - struct Array<T>
	 *  - struct String
	 *
	 * DESC
	 *  - E.X. ["1", "2", "3"] -> "123"
	 */
	public static func toString (let fromStringArray sa: [String]) -> String {

		var ret = ""

		for s in sa {
			ret += s
		}

		return ret
	}


	/*
	 * NAME toString - from String Array and insert separator
	 *
	 * ARGS
	 *  - struct Array<T>
	 *  - struct String
	 *  - ht if true always append sep to last
	 */
	public static func toString (let fromStringArray sa: [String],
		insSeparator sep: String, hasTail ht: Bool) -> String {

		var ret = ""

		let c = sa.count

		for i in 0..<c {
			ret += sa[i] + sep
		}

		if let l = sa.last {
			ret += l
		}

		if (ht) {
			ret += sep
		}

		return ret
	}


	public static func toString (fromCstring s: UnsafeMutablePointer<Int8>,
		encoding: NSStringEncoding)
		-> String? {
		/* e.x. NSUTF8StringEncoding */
		return String(CString: s, encoding: encoding)
	}


	public static func toString (fromCstring2 s: [Int8],
		encoding: NSStringEncoding)
		-> String? {
		/* e.x. NSUTF8StringEncoding */
		return String(CString: s, encoding: encoding)
	}


	/*
	 * NAME tocstring - from String
	 *
	 * DESC
	 *   - String to "char *" use "encoding"
	 */
	public static func tocstring (let fromString s: String,
		let encoding enc: NSStringEncoding)
		-> [Int8]? {
		return s.cStringUsingEncoding(enc)
	}


	public static func tocstring_2 (let fromString s: String,
		encoding: NSStringEncoding)
		-> [Int8]? {
		/* e.x. NSUTF8StringEncoding */
		let data = s.dataUsingEncoding(encoding, allowLossyConversion: false)

		if (nil == data) {
			return nil
		}

		let l = data!.length
		var buf: [Int8] = [Int8](count: l, repeatedValue: 0x0)

		Log.v(tag: TAG, items: "len: \(l)")

		data!.getBytes(&buf, length: l)

		return buf
	}


	/**
	* NAME toHexDataStr - fromData<br>
	*   E.x. { '0', '9', 0xa } => { 30, 39, 10 }<br>
	*   => { '3', '0',  '3', '9',  '1', '0' }<br>
	*   => final result "303910"<br>
	*
	* NOTE
	*   All lower case
	*/
	public static func toHexDataStr (let fromData d: [UInt8], start: Int,
		count: Int) -> String? {
		if ((start < 0) || (count < 0)
			|| (d.count < (start + count))) {
			return nil;
		}

		var ret = "";

		for i in 0..<count {
			let b = d[i + start]

			let h = (b >> 4) & 0xf
			if (h > 9) {
				switch (h) {
				case 0xa:
					ret += "a"
					break

				case 0xb:
					ret += "b"
					break

				case 0xc:
					ret += "c"
					break

				case 0xd:
					ret += "d"
					break

				case 0xe:
					ret += "e"
					break

				case 0xf:
					ret += "f"
					break

				default:
					break
				}
			} else {
				ret += "\(h)"
			}

			let l = b & 0xf
			if (l > 9) {
				switch (l) {
				case 0xa:
					ret += "a"
					break

				case 0xb:
					ret += "b"
					break

				case 0xc:
					ret += "c"
					break

				case 0xd:
					ret += "d"
					break

				case 0xe:
					ret += "e"
					break

				case 0xf:
					ret += "f"
					break

				default:
					break
				}
			} else {
				ret += "\(l)"
			}
		}

		return ret;
	}


	public static func toInt (fromBinString s: String) -> Int64 {
		if let ret = Int64(s, radix: 2) {
			return ret
		} else {
			return 0
		}
	}


	public static func toInt (fromOctString s: String) -> Int64 {
		if let ret = Int64(s, radix: 8) {
			return ret
		} else {
			return 0
		}
	}


	public static func toInt (fromDecString s: String) -> Int64 {
		if let ret = Int64(s, radix: 10) {
			return ret
		} else {
			return 0
		}
	}


	public static func toInt (fromHexString s: String) -> Int64 {
		if let ret = Int64(s, radix: 16) {
			return ret
		} else {
			return 0
		}
	}


	public static func toInt (fromString s: String, radix r: Int) -> Int64 {
		if let ret = Int64(s, radix: r) {
			return ret
		} else {
			return 0
		}
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
		if let cs = StringUtil.tocstring(fromString: s, encoding: encoding) {
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
	 *
	 * DESC
	 *   - from start Char index to end(no end)
	 */
	public static func substring (let ofString s: String, fromCharIndex ib: Int,
		to ie: Int) -> String? {
		let c = s.characters.count

		if ((ib < 0) || (ie > c) || (ie < (ib + 1))) {
			return nil
		} else {
			let start = s.startIndex.advancedBy(ib)
			let end = s.startIndex.advancedBy(ie - 1)

			return s[start...end]
		}
	}


	/*
	 * NAME substring - sub string of string (by character)
	 *
	 * DESC
	 *   - from start Char index and count Chars
	 */
	public static func substring (let ofString s: String,
		fromCharIndex ib: Int,
		count c: Int) -> String? {
		let ec = s.characters.count

		if ((ib < 0) || (c <= 0) || ((c + ib) > ec)) {
			return nil
		} else {
			let start = s.startIndex.advancedBy(ib)
			let end = s.startIndex.advancedBy(ib + c - 1)

			return s[start...end]
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


	/*
	 * NAME remove - remove:inString:fromCharIndex:to
	 *
	 * DESC
	 *   - String copy .. -- but if not !!
	 *   - And acceptable: to get a new string and keep origin!!
	 *   - indclude "to" index (remove)
	 */
	public static func remove (let inString _s: String, fromCharIndex f: Int,
		to t: Int) -> String {

		let c = _s.characters.count

		if ((f < 0) || (t < 0) || (c <= 0) || (f > t) || (t >= c)) {
			return _s
		}

		let start = _s.startIndex.advancedBy(f)
		let end = _s.startIndex.advancedBy(t)

		var s = _s

		s.removeRange(start...end)

		return s
	}


	/*
	 * NAME remove - remove:inString:fromCharIndex:count
	 */
	public static func remove (let inString _s: String, fromCharIndex f: Int,
		count c: Int) -> String {

		let ec = _s.characters.count

		if ((f < 0) || (c <= 0) || ((c + f) > ec)) {
			return _s
		}

		let start = _s.startIndex.advancedBy(f)
		let end = _s.startIndex.advancedBy(f + c - 1)

		var s = _s

		s.removeRange(start...end)

		return s
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
