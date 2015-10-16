public struct BytesSequence: SequenceType {

	public let chunkSize: Int
	public let data: [UInt8]

	public func generate() -> AnyGenerator<ArraySlice<UInt8>> {

		var offset:Int = 0

		return anyGenerator {
			let end = min(self.chunkSize, self.data.count - offset)
			let result = self.data[offset..<offset + end]
			offset += result.count
			return result.count > 0 ? result : nil
		}
	}

}
