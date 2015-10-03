class MyArray <T> {
	func append (v: T) {
		data.append(v)
	}


	func count () -> Int {
		return data.count
	}


	func empty () {
		if (data.count > 0) {
			data.removeAll()
		}
	}


	func get (index: Int) -> T? {
		let c = data.count

		if (index >= 0 && c > index) {
			let i = index
			return data[i]
		} else {
			return nil
		}
	}


	func getLast () -> T? {
		let c = data.count

		if (c > 0) {
			return data[c - 1]
		} else {
			return nil
		}
	}


	func setLast (v: T) -> Bool {
		let c = data.count

		if (c > 0) {
			data[c - 1] = v
			return true
		} else {
			return false
		}
	}

	func removeLast () -> T? {
		let c = data.count

		if (c > 0) {
			return data.removeLast()
		} else {
			return nil
		}
	}


	var data: [T] = [T]()
}
