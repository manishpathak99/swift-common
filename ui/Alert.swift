import Foundation

#if os(iOS)
import UIKit
#else
import AppKit
#endif


public final class Alert {
	/* show alert */
	public static func show (alertOnContextVC vc: UIViewController,
		title ttl: String, msg: String,
		cancelTitle cbt: String,
		onCancelPressed handler: ((UIAlertAction) -> Void)? = nil,
		onDidShow completion: (() -> Void)? = nil) {

		dispatch_async(dispatch_get_main_queue()) {
			let alertController = UIAlertController(title: ttl,
				message: msg,
				preferredStyle: UIAlertControllerStyle.Alert)

			let cancelAction = UIAlertAction(title: cbt,
				style: UIAlertActionStyle.Cancel, handler: handler)
			alertController.addAction(cancelAction)

			vc.presentViewController(alertController, animated: true,
				completion: completion)
		}

	}


#if	os (OSX)
	/* show alert byOldWay */
	public static func show (byOldWayTitle ttl: String, msg: String,
		onViewContr vc: UIViewController,
		cancelButtonTitle cbt: String) {

		dispatch_async(dispatch_get_main_queue()) {
#if			os (iOS)
			/* FIXME: warning issue */
			let alert = UIAlertView(title: ttl, message: msg,
				delegate: nil, cancelButtonTitle: cbt)
			alert.show()
#else
			let alert = NSAlert()
			alert.addButtonWithTitle(cbt)
			alert.messageText = msg
			alert.informativeText = msg
			alert.alertStyle = NSAlertStyle.WarningAlertStyle
			alert.runModal()
#endif
		}

	}
#endif

}