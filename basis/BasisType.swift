public class array <T> {
	public init () {
		self.data = [T]()
	}


	public init (count c: UInt, repeatedValue rv: T) {
		if (c <= 0) {
			self.data = [T]()
		} else {
			self.data = [T](count: Int(c), repeatedValue: rv)
		}
	}


	public var data: [T]!
}