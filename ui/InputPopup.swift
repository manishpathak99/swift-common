import Foundation

#if os(iOS)
import UIKit
#else
import AppKit
#endif


public final class InputPopup {

	/* show forAInOneOnCntxtVC */
	public static func show (forAInOneOnCntxtVC vc: UIViewController,
		title ttl: String,
		msg: String,
		hint: String,
		btnTitles: (cancelTitle: String, doneTitle: String),
		onCancel ch: ((UIAlertAction) -> Void)? = nil,
		onDone dh: ((UIAlertAction) -> Void)? = nil,
		onDidShow completion: (() -> Void)? = nil) -> UIAlertController {

		let alertController = UIAlertController(title: ttl,
			message: msg,
			preferredStyle: UIAlertControllerStyle.Alert)

		alertController.addTextFieldWithConfigurationHandler {
			(textField: UITextField!) -> Void in
			textField.placeholder = hint
		}

		let cancelAction = UIAlertAction(title: btnTitles.cancelTitle,
			style: UIAlertActionStyle.Cancel, handler: ch)
		alertController.addAction(cancelAction)

		let doneAction = UIAlertAction(title: btnTitles.doneTitle,
			style: UIAlertActionStyle.Default, handler: dh)
		alertController.addAction(doneAction)

		dispatch_async(dispatch_get_main_queue()) {
			vc.presentViewController(alertController, animated: true,
				completion: completion)
		}

		return alertController

	}


	/* show forSInOneOnCntxtVC */
	public static func show (forSInOneOnCntxtVC vc: UIViewController,
		title ttl: String,
		msg: String,
		hint: String,
		btnTitles: (cancelTitle: String, doneTitle: String),
		onCancel ch: ((UIAlertAction) -> Void)? = nil,
		onDone dh: ((UIAlertAction) -> Void)? = nil,
		onDidShow completion: (() -> Void)? = nil) -> UIAlertController {

		let alertController = UIAlertController(title: ttl,
			message: msg,
			preferredStyle: UIAlertControllerStyle.Alert)

		alertController.addTextFieldWithConfigurationHandler {
			(textField: UITextField!) -> Void in
			textField.placeholder = hint
		}

		let cancelAction = UIAlertAction(title: btnTitles.cancelTitle,
			style: UIAlertActionStyle.Cancel, handler: ch)
		alertController.addAction(cancelAction)

		let doneAction = UIAlertAction(title: btnTitles.doneTitle,
			style: UIAlertActionStyle.Default, handler: dh)
		alertController.addAction(doneAction)

		dispatch_sync(dispatch_get_main_queue()) {
			vc.presentViewController(alertController, animated: true,
				completion: completion)
		}

		return alertController

	}


	/* show forAInOneOnCntxtVC2 */
	public static func show (forAInOneOnCntxtVC2 vc: UIViewController,
		title ttl: String,
		msg: String,
		btnTitles: (cancelTitle: String, doneTitle: String),
		doCustomTextField dc: ((UITextField) -> Void)?,
		onCancel ch: ((UIAlertAction) -> Void)? = nil,
		onDone dh: ((UIAlertAction) -> Void)? = nil,
		onDidShow completion: (() -> Void)? = nil) -> UIAlertController {

		let alertController = UIAlertController(title: ttl,
			message: msg,
			preferredStyle: UIAlertControllerStyle.Alert)

		alertController.addTextFieldWithConfigurationHandler(dc)

		let cancelAction = UIAlertAction(title: btnTitles.cancelTitle,
			style: UIAlertActionStyle.Cancel, handler: ch)
		alertController.addAction(cancelAction)

		let doneAction = UIAlertAction(title: btnTitles.doneTitle,
			style: UIAlertActionStyle.Default, handler: dh)
		alertController.addAction(doneAction)

		dispatch_async(dispatch_get_main_queue()) {
			vc.presentViewController(alertController, animated: true,
				completion: completion)
		}

		return alertController

	}

}