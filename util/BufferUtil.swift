import Foundation

class BufferAnyUtil <T> {
	static func getBuffer (count c: Int, repeatedValue: T) -> [T] {
		return [T](count: c, repeatedValue: repeatedValue)
	}
}


class BufferUtil {
	static func getBuffer (void_count c: Int) -> [Void] {
		return [Void](count: c, repeatedValue: Void())
	}


	static func getBuffer (uint8_count c: Int) -> [UInt8] {
		return [UInt8](count: c, repeatedValue: 0x0)
	}


	static func getBuffer (int8_count c: Int) -> [Int8] {
		return [Int8](count: c, repeatedValue: 0x0)
	}


	static func getBuffer (int32_count c: Int) -> [Int32] {
		return [Int32](count: c, repeatedValue: 0x0)
	}


	static func getBuffer (int64_count c: Int) -> [Int64] {
		return [Int64](count: c, repeatedValue: 0x0)
	}


	static func getBuffer (uint32_count c: Int) -> [UInt32] {
		return [UInt32](count: c, repeatedValue: 0x0)
	}


	static func getBuffer (uint64_count c: Int) -> [UInt64] {
		return [UInt64](count: c, repeatedValue: 0x0)
	}


	static func getBuffer (char_count c: Int) -> [Character] {
		return [Character](count: c, repeatedValue: "\0".characters.first!)
	}


	static func getBuffer (pthread_t_count c: Int) -> [pthread_t] {
		return [pthread_t](count: c, repeatedValue: pthread_t())
	}


	static func getBuffer (string_count c: Int) -> [String] {
		return [String](count: c, repeatedValue: "")
	}
}