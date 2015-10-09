import Foundation


private class CycleQ {
	func reinit () {
		self.count = 0
		self.front = 0
		self.rear = 0
	}


	var count: Int = 0
	var front: Int = 0;
	var rear:Int = 0;
}


public class CycleQueue<T>: Queue<T> {

	init () {
		super.init(noAlloc: true)
		self.cycleq.reinit()
	}


	override public func isEmpty () -> Int {
		var ret: Int?

		self.LOCK()

		let e = super.isEmpty()

		if (0 == e) {
			if (self.cycleq.count <= 0) {
				ret = 1
			} else {
				ret = 0
			}
		} else {
			ret = e
		}

		self.UNLOCK()

		return ret!
	}


	public func remaining () -> Int {
		var ret: Int?

		self.LOCK()

		let e = super.isEmpty()

		if (-1 == e) {
			ret = -1
		} else {
			let cap = super.currentQueueSize()
			let c = self.cycleq.count

			if (c >= cap) {
				ret = 0
			} else {
				ret = cap - c
			}
		}

		self.UNLOCK()

		return ret!
	}


	/*
	 * NAME enqueue - append and after-old-tail (be-the-latest-one)
	 */
	override public func enqueue (v: T) -> Bool {
		var ret: Bool?

		self.LOCK()

		let cap = super.currentQueueSize()
		if (cap <= 0) {
			/* no q */
			ret = false
		} else if (cap <= self.cycleq.count) {
			/* full */
			ret = false
		} else {
			super.set(index: self.cycleq.rear, v: v)
			self.cycleq.rear = (self.cycleq.rear + 1) % cap
			self.cycleq.count = self.cycleq.count + 1
			ret = true
		}

		self.UNLOCK()

		return ret!
	}


	/*
	 * NAME enqueue - append and after-old-tail (be-the-latest)
	 */
	public func enqueue (all vs: [T]) -> Bool {
		var ret: Bool?

		self.LOCK()

		let cap = super.currentQueueSize()
		let c = self.cycleq.count
		if (cap <= 0) {
			/* no q */
			ret = false
		} else if (cap <= c) {
			/* full */
			ret = false
		} else if (cap <= (vs.count + c)) {
			/* no enough */
			ret = false
		} else {
			for v in vs {
				super.set(index: self.cycleq.rear, v: v)
				self.cycleq.rear = (self.cycleq.rear + 1) % cap
				self.cycleq.count = self.cycleq.count + 1
			}
			ret = true
		}

		self.UNLOCK()

		return ret!
	}


	/*
	 * NAME dequeue - remove and get head (first is the dequeue head)
	 */
	override public func dequeue () -> T? {
		var ret: T?

		self.LOCK()

		let cap = super.currentQueueSize()
		if (cap <= 0) {
			/* no q */
			ret = nil
		} else {
			let c = self.cycleq.count
			if (c <= 0) {
				/* empty q */
				ret = nil
			} else {
				ret = super.get(index: self.cycleq.front)
				self.cycleq.front = (self.cycleq.front + 1) % cap
				self.cycleq.count = self.cycleq.count - 1
			}
		}

		self.UNLOCK()

		return ret
	}


	public final func capacity () -> Int {
		return super.currentQueueSize()
	}


	public final func count () -> Int {
		var ret: Int?

		self.LOCK()
		ret = self.cycleq.count
		self.UNLOCK()

		return ret!
	}


	public func alloc (count c: UInt32, repeatedValue: T) -> Bool {
		var ret: Bool?

		self.LOCK()

		ret = super.reinit(count: c, repeatedValue: repeatedValue)
		if (ret!) {
			self.cycleq.reinit()
		}

		self.UNLOCK()

		return ret!
	}


	public func dealloc () {
		self.LOCK()

		self.cycleq.reinit()
		super.empty()

		self.UNLOCK()
	}


	/*
	 * NAME LOCK - lock
	 */
	private final func LOCK () {
		while (self.LOCKED) {
			usleep(self.LOCK_SLICE)
		}

		self.LOCKED = true
	}


	/*
	 * NAME UNLOCK - unlock
	 */
	private final func UNLOCK () {
		self.LOCKED = false
	}


	/*
	 * NAME LOCKED - var locked
	 */
	private final var LOCKED: Bool = false


	private final let LOCK_SLICE: UInt32 = UInt32(5 * 1e3)

	private let cycleq: CycleQ = CycleQ()
}
