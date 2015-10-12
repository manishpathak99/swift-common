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


public class array <T>: SequenceType {
	subscript (index: Int) -> T? {
		get {
			return self.data?[index]
		}

		set {
			if let nv = newValue {
				self.data?[index] = nv
			}
		}
	}


	public typealias Generator = array_item_generator<T>

	public func generate() -> Generator {
		return Generator(data: self.data)
	}


	public init () {
		LOCK()

		self.data = [T]()

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


	public func getData (fromStart s: UInt64, bytes: UInt64) -> [T]? {
		var ret: [T]?

		LOCK()

		if ((nil == self.data) || (bytes <= 0)) {
			ret = nil
		} else {
			let c = self.data!.count

			if ((s + bytes) > UInt64(c)) {
				ret = nil
			} else {
				let rv = self.data![0]
				ret = [T](count: Int(c), repeatedValue: rv)

				for i in s..<(s + bytes) {
					ret![Int(i - s)] = self.data![Int(i)]
				}
			}
		}

		UNLOCK()

		return ret!
	}


	public var count: Int {
		let reto = self.data?.count
		if let ret = reto {
			return ret
		} else {
			return 0
		}
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


	public var data: [T]?

	/*
	 * NAME LOCKED - var locked
	 */
	private final var LOCKED: Bool = false


	private final let LOCK_SLICE: UInt32 = UInt32(5 * 1e3)
}
