/*
 * NAME AppUtil.swift - app util
 *
 * SEE
 *   - https://github.com/mozilla/firefox-ios/blob/master/Utils/AppInfo.swift
 *
 * C. 15/10/11.
 *
 * V.
 *   - 1.0.0.0 - TODO
 */


import Foundation


#if os(iOS)
import UIKit
#else
import AppKit
#endif


public final class AppUtil {
	public static func getAppGourpPath (group g: String) -> String? {

		/* get path to shared group folder */
		let fm = NSFileManager.defaultManager()

		if let url = fm.containerURLForSecurityApplicationGroupIdentifier(g) {
			return url.path
		} else {
			return nil
		}
	}


	/* get app int value */
	public static func getAppIntValue (byKey key: String) -> Int {
		let ud = NSUserDefaults.standardUserDefaults()
		let v = ud.integerForKey(key)

		return v
	}


	/* set app int value */
	public static func setAppIntValue (value v: Int, forKey fk: String) {
		let ud = NSUserDefaults.standardUserDefaults()
		ud.setInteger(v, forKey: fk)
		ud.synchronize()
	}


	/* get app string value */
	public static func getAppStringValue (byKey key: String) -> String? {
		let ud = NSUserDefaults.standardUserDefaults()
		let v = ud.stringForKey(key)

		return v
	}


	/* set app string value */
	public static func setAppStringValue (value v: AnyObject?,
		forKey fk: String) {
		let ud = NSUserDefaults.standardUserDefaults()
		ud.setObject(v, forKey: fk)
		ud.synchronize()
	}


	/* remove by key */
	public static func removeAppObject (byKey k: String) {
		let ud = NSUserDefaults.standardUserDefaults()

		ud.removeObjectForKey(k)
		ud.synchronize()
	}


#if os (iOS)
	/* get app's document path */
	public static var appDocPath: String? {
		get {
			let docPath = NSSearchPathForDirectoriesInDomains(
				.DocumentDirectory,
				.UserDomainMask, true).first

			return docPath
		}
	}
#endif

	/* get app's res path */
	public static var appResPath: String? {
		get {
			let resPath = NSBundle.mainBundle().resourcePath

			return resPath
		}
	}


	/* get app version */
	public static var appVersion: String? {
		return NSBundle
			.mainBundle()
			.objectForInfoDictionaryKey("CFBundleShortVersionString")
			as? String
	}
}
