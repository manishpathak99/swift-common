import Foundation

#if os(iOS)
import UIKit
#else
import AppKit
#endif


public final class Alert {
	/* show alert */
	public static func show (title ttl: String, msg: String,
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

}