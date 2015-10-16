import Foundation

#if os(iOS)
import UIKit
#else
import AppKit
#endif


public final class ActionSheet {

	/* show forCancelOnCntxtVC */
	public static func show (forCancelOnCntxtVC vc: UIViewController,
		title ttl: String, msg: String,
		cancelTitle cbt: String,
		async: Bool = true,
		onCancel handler: ((UIAlertAction) -> Void)? = nil,
		onDidShow completion: (() -> Void)? = nil) {

		let alertController = UIAlertController(title: ttl,
			message: msg,
			preferredStyle: UIAlertControllerStyle.ActionSheet)

		let cancelAction = UIAlertAction(title: cbt,
			style: UIAlertActionStyle.Cancel, handler: handler)
		alertController.addAction(cancelAction)

		if (async) {
			dispatch_async(dispatch_get_main_queue()) {
				vc.presentViewController(alertController, animated: true,
					completion: completion)
			}
		} else {
			dispatch_sync(dispatch_get_main_queue()) {
				vc.presentViewController(alertController, animated: true,
					completion: completion)
			}
		}

	}


	/* show forOKOnCntxtVC */
	public static func show (forOKOnCntxtVC vc: UIViewController,
		title ttl: String, msg: String,
		okTitle obt: String,
		async: Bool = true,
		onOK handler: ((UIAlertAction) -> Void)? = nil,
		onDidShow completion: (() -> Void)? = nil) {

		let alertController = UIAlertController(title: ttl,
			message: msg,
			preferredStyle: UIAlertControllerStyle.ActionSheet)

		let okAction = UIAlertAction(title: obt,
			style: UIAlertActionStyle.Default, handler: handler)
		alertController.addAction(okAction)

		if (async) {
			dispatch_async(dispatch_get_main_queue()) {
				vc.presentViewController(alertController, animated: true,
					completion: completion)
			}
		} else {
			dispatch_sync(dispatch_get_main_queue()) {
				vc.presentViewController(alertController, animated: true,
					completion: completion)
			}
		}

	}


	/* show forDestructiveOnCntxtVC */
	public static func show (forDestructiveOnCntxtVC vc: UIViewController,
		title ttl: String, msg: String,
		destructiveTitle dbt: String,
		async: Bool = true,
		onDestructive handler: ((UIAlertAction) -> Void)? = nil,
		onDidShow completion: (() -> Void)? = nil) {

		let alertController = UIAlertController(title: ttl,
			message: msg,
			preferredStyle: UIAlertControllerStyle.ActionSheet)

		let destructiveAction = UIAlertAction(title: dbt,
			style: UIAlertActionStyle.Destructive, handler: handler)
		alertController.addAction(destructiveAction)

		if (async) {
			dispatch_async(dispatch_get_main_queue()) {
				vc.presentViewController(alertController, animated: true,
					completion: completion)
			}
		} else {
			dispatch_sync(dispatch_get_main_queue()) {
				vc.presentViewController(alertController, animated: true,
					completion: completion)
			}
		}

	}


	/* show forACOOnCntxtVC */
	public static func show (forACOOnCntxtVC vc: UIViewController,
		title ttl: String, msg: String,
		cancelTitle cbt: String,
		okTitle obt: String,
		onCancel ch: ((UIAlertAction) -> Void)? = nil,
		onOK oh: ((UIAlertAction) -> Void)? = nil,
		onDidShow completion: (() -> Void)? = nil) {

		let alertController = UIAlertController(title: ttl,
			message: msg,
			preferredStyle: UIAlertControllerStyle.ActionSheet)

		let cancelAction = UIAlertAction(title: cbt,
			style: UIAlertActionStyle.Cancel, handler: ch)
		alertController.addAction(cancelAction)

		let okAction = UIAlertAction(title: obt,
			style: UIAlertActionStyle.Default, handler: oh)
		alertController.addAction(okAction)

		dispatch_async(dispatch_get_main_queue()) {
			vc.presentViewController(alertController, animated: true,
				completion: completion)
		}

	}


	/* show forSCOOnCntxtVC */
	public static func show (forSCOOnCntxtVC vc: UIViewController,
		title ttl: String, msg: String,
		cancelTitle cbt: String,
		okTitle obt: String,
		onCancel ch: ((UIAlertAction) -> Void)? = nil,
		onOK oh: ((UIAlertAction) -> Void)? = nil,
		onDidShow completion: (() -> Void)? = nil) {

		let alertController = UIAlertController(title: ttl,
			message: msg,
			preferredStyle: UIAlertControllerStyle.ActionSheet)

		let cancelAction = UIAlertAction(title: cbt,
			style: UIAlertActionStyle.Cancel, handler: ch)
		alertController.addAction(cancelAction)

		let okAction = UIAlertAction(title: obt,
			style: UIAlertActionStyle.Default, handler: oh)
		alertController.addAction(okAction)

		dispatch_sync(dispatch_get_main_queue()) {
			vc.presentViewController(alertController, animated: true,
				completion: completion)
		}

	}


	/* show forANYOnCntxtVC */
	public static func show (forANYOnCntxtVC vc: UIViewController,
		title ttl: String, msg: String,
		noTitle nbt: String,
		yesTitle ybt: String,
		onNo nh: ((UIAlertAction) -> Void)? = nil,
		onYes yh: ((UIAlertAction) -> Void)? = nil,
		onDidShow completion: (() -> Void)? = nil) {

		let alertController = UIAlertController(title: ttl,
			message: msg,
			preferredStyle: UIAlertControllerStyle.ActionSheet)

		let noAction = UIAlertAction(title: nbt,
			style: UIAlertActionStyle.Destructive, handler: nh)
		alertController.addAction(noAction)

		let yesAction = UIAlertAction(title: ybt,
			style: UIAlertActionStyle.Default, handler: yh)
		alertController.addAction(yesAction)

		dispatch_async(dispatch_get_main_queue()) {
			vc.presentViewController(alertController, animated: true,
				completion: completion)
		}

	}


	/* show forSNYOnCntxtVC */
	public static func show (forSNYOnCntxtVC vc: UIViewController,
		title ttl: String, msg: String,
		noTitle nbt: String,
		yesTitle ybt: String,
		onNo nh: ((UIAlertAction) -> Void)? = nil,
		onYes yh: ((UIAlertAction) -> Void)? = nil,
		onDidShow completion: (() -> Void)? = nil) {

		let alertController = UIAlertController(title: ttl,
			message: msg,
			preferredStyle: UIAlertControllerStyle.ActionSheet)

		let noAction = UIAlertAction(title: nbt,
			style: UIAlertActionStyle.Destructive, handler: nh)
		alertController.addAction(noAction)

		let yesAction = UIAlertAction(title: ybt,
			style: UIAlertActionStyle.Default, handler: yh)
		alertController.addAction(yesAction)

		dispatch_sync(dispatch_get_main_queue()) {
			vc.presentViewController(alertController, animated: true,
				completion: completion)
		}

	}


	/* show forANYCOnCntxtVC */
	public static func show (forANYCOnCntxtVC vc: UIViewController,
		title ttl: String, msg: String,
		noTitle nbt: String,
		yesTitle ybt: String,
		cancelTitle cbt: String,
		onNo nh: ((UIAlertAction) -> Void)? = nil,
		onYes yh: ((UIAlertAction) -> Void)? = nil,
		cancelNo ch: ((UIAlertAction) -> Void)? = nil,
		onDidShow completion: (() -> Void)? = nil) {

		let alertController = UIAlertController(title: ttl,
			message: msg,
			preferredStyle: UIAlertControllerStyle.ActionSheet)

		let noAction = UIAlertAction(title: nbt,
			style: UIAlertActionStyle.Destructive, handler: nh)
		alertController.addAction(noAction)

		let yesAction = UIAlertAction(title: ybt,
			style: UIAlertActionStyle.Default, handler: yh)
		alertController.addAction(yesAction)

		let cancelAction = UIAlertAction(title: cbt,
			style: UIAlertActionStyle.Cancel, handler: ch)
		alertController.addAction(cancelAction)

		dispatch_async(dispatch_get_main_queue()) {
			vc.presentViewController(alertController, animated: true,
				completion: completion)
		}

	}

}
