import Foundation


public class Queue<T> {
	/*
	 * NAME init - init instance data
	 */
	init (noAlloc na: Bool = false) {
		if ((!na) && (nil == self.data)) {
			self.data = [T]()
		}
	}


	public final func reinit (count c: UInt32, repeatedValue: T) -> Bool {
		var ret: Bool?

		self.LOCK()

		/* if (nil == self.data) { */
		if (c <= 0) {
			ret = false
		} else {
			self.data = [T](count: Int(c), repeatedValue: repeatedValue)
			ret = true
		}
		/* } */

		self.UNLOCK()

		return ret!
	}


	/*
	 * NAME currentQueueSize - RO current elements count
	 */
	public final func currentQueueSize () -> Int {
		var ret: Int?

		self.LOCK()

		if (nil == self.data) {
			ret = 0
		} else {
			ret = self.data!.count
		}

		self.UNLOCK()

		return ret!
	}


	public func isEmpty () -> Int {
		var ret: Int?

		self.LOCK()

		if (nil == self.data) {
			ret = -1
		} else if (self.data!.count <= 0) {
			ret = 1
		} else {
			ret = 0
		}

		self.UNLOCK()

		return ret!
	}


	/*
	 * NAME enqueue - append and after-old-tail (be-the-latest-one)
	 */
	public func enqueue (v: T) -> Bool {
		var ret: Bool?

		self.LOCK()

		if (nil == self.data) {
			ret = false
		} else {
			self.data!.append(v)
			ret = true
		}

		self.UNLOCK()

		return ret!
	}


	/*
	 * NAME dequeue - remove and get head (first is the dequeue head)
	 */
	public func dequeue () -> T? {
		var ret: T?

		self.LOCK()

		if (nil == self.data) {
			ret = nil
		} else {
			let c = self.data!.count

			if (c > 0) {
				ret = self.data!.removeFirst()
			} else {
				ret = nil
			}
		}

		self.UNLOCK()

		return ret
	}


	public final func empty () {
		self.LOCK()

		if (nil != self.data) {
			if (self.data!.count > 0) {
				self.data!.removeAll()
			}
		}

		self.UNLOCK()
	}


	public func get (index i: Int) -> T? {
		var ret: T?

		self.LOCK()

		if (nil == self.data) {
			ret = nil
		} else {
			let c = self.data!.count

			if (i >= 0 && c > i) {
				ret = self.data![i]
			} else {
				ret = nil
			}
		}

		self.UNLOCK()

		return ret
	}


	public func set (index i: Int, v: T) -> Bool {
		var ret: Bool?

		self.LOCK()

		if ((i < 0) || (nil == self.data)) {
			ret = false
		} else {
			let c = self.data!.count

			if (i < c) {
				self.data![i] = v
				ret = true
			} else {
				ret = false
			}
		}

		self.UNLOCK()

		return ret!
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
	 * NAME _data
	 */
	private final var data: [T]?


	/*
	 * NAME LOCKED - var locked
	 */
	private final var LOCKED: Bool = false


	private final let LOCK_SLICE: UInt32 = UInt32(5 * 1e3)
}
