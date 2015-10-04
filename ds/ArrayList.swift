/*
 * NAME ArrayList.swift - class ArrayList
 */

import Foundation


/*
 * NAME ArrayList - array list
 */
public class ArrayList <T> {
	/*
	 * NAME init - init instance data
	 */
	public init () {
		if (nil == self.data) {
			self.data = [T]()
		}
	}


	/*
	 * NAME count - count RO
	 */
	public final func count () -> Int {
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


	/*
	 * NAME append - append below old bottom
	 */
	public final func append (belowOldBottom v: T) -> Bool {
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
	 * NAME insert - insert above old top
	 */
	public final func insert (aboveOldTop v: T) -> Bool {
		var ret: Bool?

		self.LOCK()

		if (nil == self.data) {
			ret = false
		} else {
			self.data!.insert(v, atIndex: 0)
			ret = true
		}

		self.UNLOCK()

		return ret!
	}


	/*
	 * NAME enqueue - append and after-old-tail (below-old-bottom)
	 */
	public final func enqueue (v: T) -> Bool {
		return self.append(belowOldBottom: v)
	}


	/*
	 * NAME dequeue - remove and get head (first is the enqueue head)
	 */
	public final func dequeue () -> T? {
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


	/*
	 * NAME push - append and as top (latest append one)
	 */
	public final func push (v: T) -> Bool {
		return self.append(belowOldBottom: v)
	}


	/*
	 * NAME pop - remove and get top (last is latest append one)
	 */
	public final func pop () -> T? {
		var ret: T?

		self.LOCK()

		if (nil == self.data) {
			ret = nil
		} else {
			let c = self.data!.count

			if (c > 0) {
				ret = self.data!.removeLast()
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
	

	public func get (index: Int) -> T? {
		var ret: T?

		self.LOCK()
		
		if (nil == self.data) {
			ret = nil
		} else {
			let c = self.data!.count

			if (index >= 0 && c > index) {
				let i = index
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


	public func getLast () -> T? {
		var ret: T?

		self.LOCK()

		if (nil == self.data) {
			ret = nil
		} else {
			let c = self.data!.count

			if (c > 0) {
				ret = self.data![c - 1]
			} else {
				ret = nil
			}
		}

		self.UNLOCK()

		return ret
	}


	public func setLast (v: T) -> Bool {
		var ret: Bool?

		self.LOCK()

		if (nil == self.data) {
			ret = false
		} else {
			let c = self.data!.count

			if (c > 0) {
				self.data![c - 1] = v
				ret = true
			} else {
				ret = false
			}
		}

		self.UNLOCK()

		return ret!
	}


	public func getFirst () -> T? {
		var ret: T?

		self.LOCK()

		if (nil == self.data) {
			ret = nil
		} else {
			let c = self.data!.count

			if (c > 0) {
				ret = self.data![0]
			} else {
				ret = nil
			}
		}

		self.UNLOCK()

		return ret
	}


	public func setFirst (v: T) -> Bool {
		var ret: Bool?

		self.LOCK()

		if (nil == self.data) {
			ret = false
		} else {
			let c = self.data!.count

			if (c > 0) {
				self.data![0] = v
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
	 * NAME _data - 储值属性
	 */
	private final var data: [T]?


	/*
	 * NAME LOCKED - var locked 储值
	 */
	private final var LOCKED: Bool = false


	private let LOCK_SLICE: UInt32 = UInt32(5 * 1e3)
}
