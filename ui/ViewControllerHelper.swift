import Foundation
import UIKit


public class ViewControllerHelper {

	public static func dismissTopViewController
		(forVC vc: UIViewController,
		onCompletion c: (() -> Void)? = nil) {

		vc.dismissViewControllerAnimated(true, completion: c)

	}

	private static let TAG: String = "ViewControllerHelper"

}