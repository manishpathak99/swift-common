// AppUtil.swift
// 15/10/11.

import Foundation


#if os(iOS)
import UIKit
#else
import AppKit
#endif


public final class AppUtil {
	/* get app's document path */
	public static func getAppDocPath () -> String? {
		let docPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,
			.UserDomainMask, true).first
		
		return docPath
	}
	
	
	/* get app's res path */
	public static func getAppResPath () -> String? {
		let resPath = NSBundle.mainBundle().resourcePath
		
		return resPath
	}
	
	
	/* get launch count value */
	public static func getAppLaunchCount () -> Int {
		let ud = NSUserDefaults.standardUserDefaults()
		let launchCount = ud.integerForKey("LaunchCount")
		
		return launchCount
	}
	
	
	/* get launch count value */
	public static func setAppLaunchCount (count c: Int) {
		let ud = NSUserDefaults.standardUserDefaults()
		ud.setInteger(c, forKey: "LaunchCount")
		ud.synchronize()
	}
}