/*
 * NAME ToastUIViewX.swift - UIView X for toast
 */

import UIKit
import QuartzCore


private var timer: NSTimer!
private var activityView: UIView!


extension UIView {
	public func makeToast (msg m: String) {
		self.makeToast(msg: m, duration: ToastConstant.ToastDuration,
		position: nil)
	}


	public func makeToast (msg m: String, duration: NSTimeInterval,
		position: AnyObject?) {
		let toastView = self.toastView(msg: m, title: "",  image: nil)
		self.showToast(toastView, duration: duration, position: position)
	}


	public func makeToast (msg m: String, duration: NSTimeInterval,
		position: AnyObject?, title: String) {
		let toastView = self.toastView(msg: m, title: title, image: nil)
		self.showToast(toastView, duration: duration, position: position)
	}


	public func makeToast (msg m: String, duration: NSTimeInterval,
		position: AnyObject?, image: UIImage!) {
		let toastView = self.toastView(msg: m, title: "", image: image)
		self.showToast(toastView, duration: duration, position: position)
	}


	public func makeToast (msg m: String, duration: NSTimeInterval,
		position: AnyObject?, title: String, image: UIImage!) {
		let toastView = self.toastView(msg: m, title: title, image: image)
		self.showToast(toastView, duration: duration, position: position)
	}


	/* toast view main methods */
	public func showToast (toastView: UIView!) {
		self.showToast(toastView, duration: ToastConstant.ToastDuration,
			position: nil)
	}


	public func showToast (toastView: UIView!, duration: NSTimeInterval!,
		position: AnyObject?) {
		self.createAndShowToast(toastView, duration: duration,
			position: position)
	}


	private func createAndShowToast (toastView: UIView!,
		duration: NSTimeInterval!, position: AnyObject?) {
		toastView.center = centerPointForPosition(position,
			toastView: toastView)
		toastView.alpha = ToastConstant.ToastViewAlpha

		if ToastConstant.ToastHidesOnTap {
			let tapRecognizer: UITapGestureRecognizer!
				= UITapGestureRecognizer(target: toastView,
				action: "handleToastTapped:")

			toastView.addGestureRecognizer(tapRecognizer)
			toastView.userInteractionEnabled = true
			toastView.exclusiveTouch = true
		}

		timer = NSTimer.scheduledTimerWithTimeInterval(duration, target: self,
			selector: "toastTimerDidFinish:", userInfo: toastView,
			repeats: false)

		self.addSubview(toastView)

		toastView.alpha = 0.8

		UIView.animateWithDuration(ToastConstant.ToastDuration, delay: 0.0,
			options: UIViewAnimationOptions(
				rawValue: UIViewAnimationOptions.CurveEaseInOut.rawValue
				| UIViewAnimationOptions.AllowUserInteraction.rawValue),
				animations: {
				() -> Void in
				toastView.alpha = 1.0
			}
		) {
			(Bool) -> Void in
		}
	}


	private func hideToast (toastView: UIView!) {
		UIView.animateWithDuration(ToastConstant.ToastFadeDuration,
			delay: 0.0,
			options: UIViewAnimationOptions(
				rawValue: UIViewAnimationOptions.CurveEaseIn.rawValue
				| UIViewAnimationOptions.BeginFromCurrentState.rawValue),
			animations: { () -> Void in
			toastView.alpha = 0.0
			}
		) {
			(Bool) -> Void in
			toastView.removeFromSuperview()
		}
	}


	private func toastView (msg m: String, title: String,
		image: UIImage?) -> UIView? {
		/* check parameters */
		if m.isEmpty && title.isEmpty && image == nil {
			return nil
		}

		/* ui elements of toast */
		var messageLabel: UILabel!
		var titleLabel: UILabel!
		var imageView: UIImageView!

		let toastView: UIView! = UIView()
		toastView.autoresizingMask =
			UIViewAutoresizing(rawValue:
			UIViewAutoresizing.FlexibleLeftMargin.rawValue
			| UIViewAutoresizing.FlexibleRightMargin.rawValue
			| UIViewAutoresizing.FlexibleTopMargin.rawValue
			| UIViewAutoresizing.FlexibleBottomMargin.rawValue
		)
		toastView.layer.cornerRadius = ToastConstant.ToastCornerRadius

		/* check if shadow needed */
		if ToastConstant.ToastDisplayShadow == true {
			toastView.layer.shadowColor = UIColor.blackColor().CGColor
			toastView.layer.shadowOpacity = ToastConstant.ToastShadowOpacity
			toastView.layer.shadowRadius = ToastConstant.ToastShadowRadius
			toastView.layer.shadowOffset = ToastConstant.ToastShadowOffset
		}

		/* set toastView background color */
		toastView.backgroundColor = UIColor.blackColor()
			.colorWithAlphaComponent(ToastConstant.ToastOpacity)

		/* check image */
		if(image != nil) {
			imageView = UIImageView(image: image)
			imageView.contentMode = UIViewContentMode.ScaleAspectFit
			imageView.frame = CGRectMake(ToastConstant.ToastHorizontalPadding,
				ToastConstant.ToastVerticalPadding,
				ToastConstant.ToastImageViewWidth,
				ToastConstant.ToastImageViewHeight)
		}

		var imageWidth, imageHeight, imageLeft: CGFloat!

		/*
		 * the imageView frame values will be used to
		 * size & position the other views
		 */
		if(imageView != nil) {
			imageWidth = imageView.bounds.size.width;
			imageHeight = imageView.bounds.size.height;
			imageLeft = ToastConstant.ToastHorizontalPadding
		} else {
			imageWidth = 0.0
			imageHeight = 0.0
			imageLeft = 0.0
		}

		/* check title if not empty create title label */
		if !title.isEmpty {
			titleLabel = UILabel()
			titleLabel.numberOfLines = ToastConstant.ToastMaxTitleLines
			titleLabel.font
				= UIFont.boldSystemFontOfSize(ToastConstant.ToastFontSize)
			titleLabel.textAlignment = NSTextAlignment.Center
			titleLabel.textColor = UIColor.whiteColor()
			titleLabel.backgroundColor = UIColor.clearColor()
			titleLabel.alpha = 1.0
			titleLabel.text = title

			/*
			 * set size the title label according to the lenth of title text
			 */
			let maxSizeTitle = CGSizeMake(
				(self.bounds.size.width * ToastConstant.ToastMaxWidth)
				- imageWidth,
				self.bounds.size.height * ToastConstant.ToastMaxHeight)
			let expectedSizeTitle: CGSize! = sizeForString(title,
				font: titleLabel.font, constrainedSize: maxSizeTitle,
				lineBreakMode: titleLabel.lineBreakMode)
			titleLabel.frame = CGRectMake(0.0, 0.0, expectedSizeTitle.width,
				expectedSizeTitle.height)
		}

		/* check message string if not empty create message label */
		if !m.isEmpty {
			messageLabel = UILabel()
			messageLabel.numberOfLines = ToastConstant.ToastMaxMessageLines
			messageLabel.font = UIFont.systemFontOfSize(
				ToastConstant.ToastFontSize)
			messageLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
			messageLabel.textColor = UIColor.whiteColor()
			messageLabel.backgroundColor = UIColor.clearColor()
			messageLabel.alpha = 1.0
			messageLabel.text = m

			/*
			 * set size the message label according to the lenth of
			 * message text
			 */
			let maxSizeMessage = CGSizeMake(
				(self.bounds.size.width * ToastConstant.ToastMaxWidth)
				- imageWidth,
				self.bounds.size.height
				* ToastConstant.ToastMaxHeight)
			let expectedSizeMessage: CGSize! = sizeForString(m,
				font: messageLabel.font,
				constrainedSize: maxSizeMessage,
				lineBreakMode: messageLabel.lineBreakMode)
			messageLabel.frame = CGRectMake(0.0, 0.0,
				expectedSizeMessage.width, expectedSizeMessage.height)
		}

		/* title label frame values */
		var titleWidth, titleHeight, titleTop, titleLeft: CGFloat!

		if titleLabel != nil {
			titleWidth = titleLabel.bounds.size.width
			titleHeight = titleLabel.bounds.size.height
			titleTop = ToastConstant.ToastVerticalPadding
			titleLeft = imageLeft + imageWidth
				+ ToastConstant.ToastHorizontalPadding
		} else {
			titleWidth = 0.0
			titleHeight = 0.0
			titleTop = 0.0
			titleLeft = 0.0
		}

		/* message label frame values */
		var messageWidth, messageHeight, messageLeft, messageTop: CGFloat!

		if messageLabel != nil {
			messageWidth = messageLabel.bounds.size.width
			messageHeight = messageLabel.bounds.size.height
			messageLeft = imageLeft + imageWidth
				+ ToastConstant.ToastHorizontalPadding
			messageTop = titleTop + titleHeight
				+ ToastConstant.ToastVerticalPadding
		} else {
			messageWidth = 0.0
			messageHeight = 0.0
			messageLeft = 0.0
			messageTop = 0.0
		}

		let longerWidth = max(titleWidth, messageWidth)
		let longerLeft = max(titleLeft, messageLeft)

		/* toastView frames */
		let toastViewWidth = max(imageWidth
			+ (ToastConstant.ToastHorizontalPadding * 2),
			(longerLeft + longerWidth + ToastConstant.ToastHorizontalPadding))
		let toastViewHeight = max(messageTop + messageHeight
			+ ToastConstant.ToastVerticalPadding,
			(imageHeight + (ToastConstant.ToastVerticalPadding * 2)))

		toastView.frame = CGRectMake(0.0, 0.0, toastViewWidth,
			toastViewHeight)

		if titleLabel != nil {
			titleLabel.frame = CGRectMake(titleLeft, titleTop, titleWidth,
				titleHeight)
			toastView.addSubview(titleLabel)
		}

		if messageLabel != nil {
			messageLabel.frame = CGRectMake(messageLeft, messageTop,
				messageWidth, messageHeight)
			toastView.addSubview(messageLabel)
		}

		if imageView != nil {
			toastView.addSubview(imageView)
		}

		return toastView
	}


	/* toast view events */
	func toastTimerDidFinish (timer: NSTimer) {
		self.hideToast(timer.userInfo as? UIView!)
	}

	func handleToastTapped (recognizer: UITapGestureRecognizer) {
		timer.invalidate()
		hideToast(recognizer.view)
	}


	/* toast activity methods */
	func makeToastActivity () {
		makeToastActivity(ToastConstant.ToastActivityDefaultPosition.rawValue)
	}


	private func makeToastActivity (position: AnyObject) {
		activityView = UIView(frame: CGRectMake(0.0, 0.0,
			ToastConstant.ToastActivityWidth,
			ToastConstant.ToastActivityHeight))
		activityView.center = centerPointForPosition(position,
			toastView: activityView)
		activityView.backgroundColor
			= UIColor.blackColor().colorWithAlphaComponent(
			ToastConstant.ToastOpacity)
		activityView.alpha = ToastConstant.ToastViewAlpha
		activityView.autoresizingMask =
			UIViewAutoresizing(rawValue:
			UIViewAutoresizing.FlexibleLeftMargin.rawValue
			| UIViewAutoresizing.FlexibleRightMargin.rawValue
			| UIViewAutoresizing.FlexibleTopMargin.rawValue
			| UIViewAutoresizing.FlexibleBottomMargin.rawValue)
		activityView.layer.cornerRadius = ToastConstant.ToastCornerRadius

		if ToastConstant.ToastDisplayShadow {
			activityView.layer.shadowColor = UIColor.blackColor().CGColor
			activityView.layer.shadowOpacity
				= ToastConstant.ToastShadowOpacity
			activityView.layer.shadowRadius = ToastConstant.ToastShadowRadius
			activityView.layer.shadowOffset = ToastConstant.ToastShadowOffset
		}

		let activityIndicatorView: UIActivityIndicatorView!
			= UIActivityIndicatorView(activityIndicatorStyle:
			UIActivityIndicatorViewStyle.WhiteLarge)
		activityIndicatorView.center = CGPointMake(
			activityView.bounds.size.width / 2,
			activityView.bounds.size.height / 2)
		activityView.addSubview(activityIndicatorView)
		activityIndicatorView.startAnimating()

		self.addSubview(activityView)

		UIView.animateWithDuration(ToastConstant.ToastDuration,
			delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut,
			animations: {
				() -> Void in
				activityView.alpha = 1.0
			},
			completion: nil
		)
	}


	func hideToastActivity () {
		if activityView != nil {
			UIView.animateWithDuration(ToastConstant.ToastFadeDuration,
				delay: 0.0,
				options:
					UIViewAnimationOptions(rawValue:
					UIViewAnimationOptions.CurveEaseIn.rawValue
					| UIViewAnimationOptions.BeginFromCurrentState.rawValue),
				animations: {
					() -> Void in
					activityView.alpha = 0.0
				},
				completion: {
					(Bool) -> Void in
					activityView.removeFromSuperview()
				}
			)
		}
	}


	/* helpers */
	private func centerPointForPosition (point: AnyObject?,
		toastView: UIView!) -> CGPoint {

		if point != nil {
			if point!.isKindOfClass(NSString) {
				if point!.caseInsensitiveCompare(
					ToastPosition.ToastPositionTop.rawValue)
					== NSComparisonResult.OrderedSame {
					return CGPointMake(self.bounds.size.width / 2,
					(toastView.frame.size.height / 2)
					+ ToastConstant.ToastVerticalPadding)
				} else if point!.caseInsensitiveCompare(
					ToastPosition.ToastPositionCenter.rawValue)
					== NSComparisonResult.OrderedSame {
					return CGPointMake(self.bounds.size.width / 2,
					self.bounds.size.height / 2)
				}
			} else if point!.isKindOfClass(NSValue) {
				return point!.CGPointValue
			}
		}

		/* default bottom option */
		var b: CGFloat = (self.bounds.size.height
			- (toastView.frame.size.height / 2))
			- ToastConstant.ToastVerticalPadding;
		if (nil == point) {
			b -= ToastConstant.ToastBottomMarginDFT /* margin bottom */
		}
		return CGPointMake(self.bounds.size.width / 2, b)
	}


	private func sizeForString (text: NSString, font: UIFont,
		constrainedSize: CGSize, lineBreakMode: NSLineBreakMode) -> CGSize {
		if text.respondsToSelector(
			"boundingRectWithSize:options:attributes:context:") {
			let paragraphStyle: NSMutableParagraphStyle!
				= NSMutableParagraphStyle()
			paragraphStyle.lineBreakMode = lineBreakMode
			let attributes: Dictionary = [NSFontAttributeName: font,
				NSParagraphStyleAttributeName: paragraphStyle]
			let boundingRect: CGRect!
				= text.boundingRectWithSize(constrainedSize,
				options: NSStringDrawingOptions.UsesLineFragmentOrigin,
				attributes: attributes, context: nil)
			return CGSizeMake(boundingRect.size.width,
				boundingRect.size.height)
		}

		return CGSizeMake(0.0, 0.0)
	}

}
