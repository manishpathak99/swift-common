/*
 * NAME ToastConstant.swift - constant for toast
 *
 * V.1.0.0.0_201510081322490800
 */

import Foundation
import UIKit


public final class ToastConstant {
	/* duration of view on screen */
	public static let ToastDuration = NSTimeInterval(3)


	/* view appearance */
	public static let ToastMaxWidth = CGFloat(0.8)
	public static let ToastMaxHeight = CGFloat(0.8)
	public static let ToastHorizontalPadding = CGFloat(8.0)
	public static let ToastVerticalPadding = CGFloat(8.0)
	public static let ToastCornerRadius = CGFloat(10.0)
	public static let ToastOpacity = CGFloat(0.8)
	public static let ToastFontSize = CGFloat(17.0)
	public static let ToastFadeDuration = NSTimeInterval(0.3)

	public static let ToastMaxTitleLines = 0
	public static let ToastMaxMessageLines = 0

	public static let ToastBottomMarginDFT = CGFloat(44.0)


	/* alpha -- value between 0.0 and 1.0 */
	public static let ToastViewAlpha = CGFloat(0.0)


	/* shadow appearance */
	public static let ToastDisplayShadow = true
	public static let ToastShadowOpacity = Float(0.8)
	public static let ToastShadowRadius = CGFloat(5.0)
	public static var ToastShadowOffset: CGSize
		= CGSize(width: 3.0, height: 3.0)


	/* change visibility of view */
	public static let ToastHidesOnTap = true


	/* image view size */
	public static let ToastImageViewWidth = CGFloat(80.0)
	public static let ToastImageViewHeight = CGFloat(80.0)


	/* activity */
	public static let ToastActivityWidth = CGFloat(100.0)
	public static let ToastActivityHeight = CGFloat(100.0)
	public static let ToastActivityDefaultPosition
		= ToastPosition.ToastPositionCenter
}
