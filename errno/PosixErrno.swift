/*
 * NAME PosixErrno.swift
 *
 * C 15/9/30 +0800
 *
 * DESC
 *  - Xcode 7.0.1 / Swift 2.0.1 supported (Created)
 *
 * V1.0.0.0_
 */


import Foundation

/*
 * NAME PosixErrno - class PosixErrno
 */
class PosixErrno {
	static func errno2string (posixErrno _en: Int32) -> String {
		var en: Int32 = 0

		if (_en < 0) {
			en = -_en;
		} else {
			en = _en;
		}

		let cs = strerror(en)
		let ret = StringUtil.toString(fromCstring: cs,
			encoding: NSUTF8StringEncoding)

		if (nil != ret) {
			return ret!
		} else {
			return "Unresolved \(en)"
		}
	}
}
