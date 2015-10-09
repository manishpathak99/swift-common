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
	init () {
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
	 * NAME append - append to last (the latest one)
	 *  For stack the-latest one is top
	 *  For queue the-latest one is tail
	 */
	public final func append (v: T) -> Bool {
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


	public final func append (vs: [T]) -> Bool {
		var ret: Bool?

		self.LOCK()

		if (nil == self.data) {
			self.data = vs
			ret = true
		} else {
			self.data = self.data! + vs
			ret = true
		}

		self.UNLOCK()

		return ret!
	}


	/*
	 * NAME insert - insert as new head
	 */
	public final func insert (head v: T) -> Bool {
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
	 * NAME insert - insert as index i
	 */
	public final func insert (value v: T, atIndex i: Int) -> Bool {
		var ret: Bool?

		self.LOCK()

		if ((nil == self.data) || (i < 0)) {
			ret = false
		} else {
			let c = self.data!.count

			if (i <= c) {
				self.data!.insert(v, atIndex: i)
				ret = true
			} else {
				ret = false
			}
		}

		self.UNLOCK()

		return ret!
	}


	/*
	 * NAME insert - insert all and first at index i
	 */
	public final func insert (values vs: [T], atIndex i: Int) -> Bool {
		var ret: Bool?

		self.LOCK()

		if ((nil == self.data) || (i < 0)) {
			ret = false
		} else {
			let c = self.data!.count

			if (i <= c) {
				let e = vs.count + i
				for ins in i..<e {
					self.data!.insert(vs[ins - i], atIndex: ins)
				}
				ret = true
			} else {
				ret = false
			}
		}

		self.UNLOCK()

		return ret!
	}


	/*
	 * NAME enqueue - append and after-old-tail (be-the-latest-one)
	 */
	public func enqueue (v: T) -> Bool {
		return self.append(v)
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


	/*
	 * NAME push - append and as top (latest-one)
	 */
	public final func push (v: T) -> Bool {
		return self.append(v)
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


	/* get all */
	public func get () -> [T]? {
		var ret: [T]?

		self.LOCK()

		ret = self.data

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
	 * NAME _data
	 */
	private final var data: [T]?


	/*
	 * NAME LOCKED - var locked
	 */
	private final var LOCKED: Bool = false


	private final let LOCK_SLICE: UInt32 = UInt32(5 * 1e3)
}
