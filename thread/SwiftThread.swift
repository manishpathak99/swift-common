import Foundation


public class SwiftThread: NSObject {
	public static func toString () -> String {
		return "SwiftUtil"
	}


	public init (target tar: AnyObject,
		selector: Selector,
		argument: AnyObject?) {
		super.init()

		self.tid = TimeUtil.makeid()
		self.thread = NSThread(target: tar, selector: selector,
			object: argument)
	}


	public init (startRoutine run: ((argKey: NSObjectString?)
		-> (Int32, String)?),
		argKey: String?) {
		super.init()

		self.tid = TimeUtil.makeid()
		self.__startRoutine = run
		self.__argKey = argKey
		self.teminate = true
		self.thread = NSThread(target: self, selector: "__run:",
			object: argKey)
	}


	public func start () -> Int32 {
		if (nil != self.thread) {
			self.started = true
			self.teminate = false
			self.thread!.start()
			return 0
		} else {
			return -ENOENT
		}
	}


	public func setIsRunning () {
		self.running = true
	}


	public func setStopped () {
		self.running = false
	}


	@IBAction private func __run (argKey ak: NSObjectString?) {
		if (!self.teminate) {
			self.setIsRunning()
			LogUtil.t(tag: TAG, items: "tid: \(tid) begin")

			let ret = self.__startRoutine?(argKey: ak)

			if (nil != ret) {
				LogUtil.v(tag: TAG, items: "tid: \(tid): run exited: \(ret!)")
			} else {
				LogUtil.v(tag: TAG, items: "tid: \(tid): run exited: nil")
			}
		}

		self.setStopped()
		LogUtil.t(tag: TAG, items: "tid: \(tid) end")
	}


	public var started: Bool = false
	public var running: Bool = false
	public var teminate: Bool = true
	public var tid: UInt64?

	private let TAG: String = SwiftThread.toString()

	private var __startRoutine: ((argKey: NSObjectString?) -> (Int32, String)?)?
	private var __argKey: String?
	private var thread: NSThread?
}