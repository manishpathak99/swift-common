import Foundation

class BufferUtil {
	static func getBuffer (uint8_count c: Int) -> [UInt8] {
		return [UInt8](count: c, repeatedValue: 0x0)
	}


	static func getBuffer (int8_count c: Int) -> [Int8] {
		return [Int8](count: c, repeatedValue: 0x0)
	}


	static func getBuffer (int64_count c: Int) -> [Int64] {
		return [Int64](count: c, repeatedValue: 0x0)
	}
}