/*
 * NAME ColorUtil.swift
 *
 * C 15/9/28 +0800
 *
 * DESC
 *  - Xcode 7.0 / Swift 2.0 supported
 *  - Xcode 7.0.1 / Swift 2.0.1 supported (now)
 *
 * V1.0.0.0_201509291745260800
 */


import UIKit


/*
 * NAME ColorUtil - class ColorUtil
 */
class ColorUtil {
	static func rgba2color (rgba: UInt32) -> UIColor {
		let r = CGFloat((rgba >> 24) & 0xff) / 255.0
		let g = CGFloat((rgba >> 16) & 0xff) / 255.0
		let b = CGFloat((rgba >> 8) & 0xff) / 255.0
		let a = CGFloat((rgba >> 0) & 0xff) / 255.0

		return UIColor(red: r, green: g, blue: b, alpha: a)
	}
}
