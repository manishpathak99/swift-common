import Foundation


public class array_item_generator<T>: GeneratorType {
	public init (data dt: [T]?) {

		self.counter = 0
		if (nil != dt) {
			self.count = dt!.count
			self.data = dt
		}
	}


	public func next() -> T? {
		return (self.counter >= self.count) ? nil
			: self.data?[self.counter++]
	}


	private var data: [T]?
	private var counter: Int = 0
	private var count: Int = 0
}


public class array<T>: SequenceType {
	subscript (index: Int) -> T? {
		get {
			LOCK()

			let ret = self.data?[index]

			UNLOCK()

			return ret
		}

		/*
		set {
			if let nv = newValue {
				LOCK()

				self.data?[index] = nv

				UNLOCK()
			}
		}
		*/
	}


	public typealias Generator = array_item_generator<T>

	public func generate() -> Generator {
		return Generator(data: self.data)
	}


	public init () {
		LOCK()

		if (nil == self.data) {
			self.data = [T]()
		}

		UNLOCK()
	}


	public init (count c: UInt, repeatedValue rv: T) {
		LOCK()

		if (c <= 0) {
			self.data = [T]()
		} else {
			self.data = [T](count: Int(c), repeatedValue: rv)
		}

		UNLOCK()
	}


	public init (values vs: [T]) {
		LOCK()

		self.data = vs

		UNLOCK()
	}


	public init (values vs: [T], start: UInt, count: UInt) {
		LOCK()

		if ((vs.count <= 0) || (count <= 0)) {
			self.data = [T]()
		} else {
			let bsc = UInt(vs.count)
			var s = start

			if (s < 0) {
				s = 0
			} else if (s >= bsc) {
				s = bsc - 1
			}

			var c = count
			if ((s + c) > bsc) {
				c = bsc - s
			}

			self.data = [T](count: Int(c), repeatedValue: vs.first!)
			for i: UInt in 0..<c {
				self.data![Int(i)] = vs[Int(start + i)]
			}
		}

		UNLOCK()
	}


	public func finish () {
		LOCK()

		self.data = nil

		UNLOCK()
	}


	public func bvalue (value v: T) -> Bool {
		var ret: Bool?

		LOCK()

		if (nil == self.data) {
			ret = false
		} else {
			let c = self.data!.count

			for i in 0..<c {
				self.data![i] = v
			}

			ret = true
		}

		UNLOCK()

		return ret!
	}


	/* get all */
	public func get () -> [T]? {
		var ret: [T]?

		LOCK()

		ret = self.data

		UNLOCK()

		return ret
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


	/* get parts */
	public func get (fromStart s: UInt64, count: UInt64) -> [T]? {
		var ret: [T]?

		LOCK()

		if ((nil == self.data) || (count <= 0)) {
			ret = nil
		} else {
			let c = self.data!.count

			if ((s + count) > UInt64(c)) {
				ret = nil
			} else {
				let rv = self.data![0]
				ret = [T](count: Int(c), repeatedValue: rv)

				for i in s..<(s + count) {
					ret![Int(i - s)] = self.data![Int(i)]
				}
			}
		}

		UNLOCK()

		return ret
	}


	public func set (values vs: [T]) {
		self.LOCK()

		self.data = vs

		self.UNLOCK()
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

	/* TODO: add set parts to another-parts*/

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


	public final func empty () {
		self.LOCK()

		if (nil != self.data) {
			if (self.data!.count > 0) {
				self.data!.removeAll()
			}
		}

		self.UNLOCK()
	}


	public var count: Int {
		get {

			LOCK()

			var ret: Int?
			let reto = self.data?.count

			if let ret2 = reto {
				ret = ret2
			} else {
				ret = -1
			}

			UNLOCK()

			return ret!
		}
	}


	/*
	* NAME LOCK - lock
	*/
	private final func LOCK () {
		while (self.LOCKED) {
			usleep(BasisConfigRO.COMMON_LOCK_SLICE)
		}

		self.LOCKED = true
	}


	/*
	* NAME UNLOCK - unlock
	*/
	private final func UNLOCK () {
		self.LOCKED = false
	}


	public var data: [T]?

	/*
	 * NAME LOCKED - var locked
	 */
	private final var LOCKED: Bool = false
}
