//
//  ViewController.swift
//  AlertDEMO
//
//  Created by 黄锐 on 15/10/16.
//  Copyright © 2015年 yuiwong. All rights reserved.
//

import UIKit


let ROW_INDEX_CANCEL = 0
let ROW_INDEX_OK = 1
let ROW_INDEX_DESTRUCTIVE = 2
let ROW_INDEX_CO = 3
let ROW_INDEX_NY = 4
let ROW_INDEX_CNY = 5


public class ViewController: UITableViewController {

	public override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

	public override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


	/*
	* NAME tableView - override item select
	*/
	public override func tableView (tableView: UITableView,
		didSelectRowAtIndexPath indexPath: NSIndexPath) {
			tableView.deselectRowAtIndexPath(indexPath, animated: true)
			
			let s = indexPath.section
			let r = indexPath.row

			Log.v(tag: "AlertDEMO", items: "section: \(s) row: \(r)")

			let title = self.tableView.cellForRowAtIndexPath(indexPath)?
				.textLabel?.text
			var msg = "\(TimeUtil.currentTimezoneName())"
			msg += " \(TimeUtil.currentTimezone())"
			msg += " \(TimeUtil.currentMicrosecond())"

			switch (s) {
			case 0:
				switch (r) {
				case ROW_INDEX_CANCEL:
					Alert.show(forCancelOnCntxtVC: self, title: title!,
						msg: msg,
						cancelTitle: "Cancel")
					break

				case ROW_INDEX_OK:
					Alert.show(forOKOnCntxtVC: self, title: title!,
						msg: msg,
						okTitle: "OK")
					break

				case ROW_INDEX_DESTRUCTIVE:
					Alert.show(forDestructiveOnCntxtVC: self, title: title!,
						msg: msg, destructiveTitle: "No")
					break

				case ROW_INDEX_CO:
					Alert.show(forACOOnCntxtVC: self, title: title!,
						msg: msg, cancelTitle: "Cancel", okTitle: "OK")
					break

				case ROW_INDEX_NY:
					Alert.show(forANYOnCntxtVC: self, title: title!,
						msg: msg, noTitle: "No", yesTitle: "Yes")
					break

				case ROW_INDEX_CNY:
					Alert.show(forANYCOnCntxtVC: self, title: title!,
						msg: msg, noTitle: "No", yesTitle: "Yes",
						cancelTitle: "Cancel")
					break

				default:
					Log.w(tag: "AlertDEMO", items: "defualt")
					break
				}
				break

			case 1:
				switch (r) {
				case ROW_INDEX_CANCEL:
					ActionSheet.show(forCancelOnCntxtVC: self, title: title!,
						msg: msg,
						cancelTitle: "Cancel")
					break

				case ROW_INDEX_OK:
					ActionSheet.show(forOKOnCntxtVC: self, title: title!,
						msg: msg,
						okTitle: "OK")
					break

				case ROW_INDEX_DESTRUCTIVE:
					ActionSheet.show(forDestructiveOnCntxtVC: self, title: title!,
						msg: msg, destructiveTitle: "No")
					break

				case ROW_INDEX_CO:
					ActionSheet.show(forACOOnCntxtVC: self, title: title!,
						msg: msg, cancelTitle: "Cancel", okTitle: "OK")
					break

				case ROW_INDEX_NY:
					ActionSheet.show(forANYOnCntxtVC: self, title: title!,
						msg: msg, noTitle: "No", yesTitle: "Yes")
					break

				case ROW_INDEX_CNY:
					ActionSheet.show(forANYCOnCntxtVC: self, title: title!,
						msg: msg, noTitle: "No", yesTitle: "Yes",
						cancelTitle: "Cancel")
					break

				default:
					Log.w(tag: "AlertDEMO", items: "defualt")
					break
				}
				break

			case 2:
				self.savedAlertController
					= InputPopup.show(forAInOneOnCntxtVC: self,
					title: title!, msg: msg, hint: "Enter here",
					btnTitles: ("Cancel", "Done"),
					onCancel: onCancel,
					onDone: onDone)

				let ret = SimpleTimerHelper.startSimpleTimer(10 * 1000,
					onTimerExit: { (msec: UInt32) -> Int32 in
						Log.i(tag: "InputPopup", items: "exit")

						if (nil != self.savedAlertController) {
							ViewControllerHelper.dismissTopViewController(
								forVC: self)
						}

						return 0
				})
				self.timerID = ret.timerID
				break

			default:
				Log.w(tag: "AlertDEMO", items: "default")
				break
			}
	}


	private func onCancel (aa: UIAlertAction) {

		self.cancelled = true

		Log.v(tag: "InputPopup cancel")
		self.savedAlertController = nil

		SimpleTimerHelper.stopSimpleTimerReady(byTimerID: self.timerID)

	}


	private func onDone (aa: UIAlertAction) {

		self.cancelled = true

		Log.v(tag: "InputPopup done",
			items: self.savedAlertController?.textFields?.first?.text)
		self.savedAlertController = nil

		SimpleTimerHelper.stopSimpleTimerReady(byTimerID: self.timerID)

	}

	private var savedAlertController: UIAlertController?
	private var cancelled = false
	private var timerID: UInt32 = SimpleTimer.TIMER_ID_INVALID

}

