// main.swift
// 15/10/3.

import Foundation

let al = ArrayList<String>()

var teminate: Bool = false

func rt (argument arg: UnsafePointer<UInt8>?) -> Int64 {
	var savedState = BufferUtil.getBuffer(int32_count: 1)

	pthread.setCancelState(outOldState: &savedState,
		state: pthread.PTHREAD_CANCEL_ENABLE)

	var savedType = BufferUtil.getBuffer(int32_count: 1)

	let ret = pthread.setCancelType(outOldType: &savedType,
		type: pthread.PTHREAD_CANCEL_DEFERRED)

	if (0 != ret) {
		print(__LINE__, "setCancelType: fail: \(ret)")
		return Int64(ret)
	}

	var t: Int = 0

	print("run")

	while (!teminate) {
		pthread.setCancelType(outOldType: &savedType,
			type: pthread.PTHREAD_CANCEL_DEFERRED)
		pthread.testThreadCancel()

		switch (t % 5) {
		case 4:
			if let r = al.pop() {
				print("pop: \(t):", r)
			} else {
				print("pop: \(t): nil")
			}
			break
	
		case 3:
			if let r = al.dequeue() {
				print("dequeue: \(t):", r)
			} else {
				print("dequeue: \(t): nil")
			}
			break

		case 0:
			let c = al.count()

			if let r = al.get(c - 1) {
				print("G: \(t):", r)
			} else {
				print("G: \(t): nil")
			}
			al.set(index: c - 1, v: "00\(c - 1)")
			break

		default:
			if let r = al.get(0) {
				print("G2: \(t):", r)
			} else {
				print("G2: \(t): nil")
			}
			al.set(index: 0, v: "000")
			break
		}

		pthread.setCancelType(outOldType: &savedType,
			type: pthread.PTHREAD_CANCEL_ASYNCHRONOUS)
		usleep(UInt32(100 * 1e3))
		++t
	}

	pthread.setCancelState(outOldState: &savedState,
		state: savedState.first!)
	pthread.setCancelType(outOldType: &savedType,
		type: savedType.first!)

	return 0
}


let t = Pthread()

let ret = t.start(routine: rt)
print("ret: \(ret)")

let t2 = Pthread()

let ret2 = t.start(routine: rt)
print("ret2: \(ret2)")
if (0 != ret2) {
	teminate = true
}


var tt = 0
var time: Int = 0
while (tt++ < 100) {
	if (0 == (tt % 2)) {
		al.enqueue("\(tt)")
		print("enqueue \(time): \(tt)")
	} else {
		al.push("\(tt)")
		print("push \(time): \(tt)")
	}

	usleep(UInt32(50 * 1e3))
	++time
}

al.empty()

usleep(UInt32(Double(tt + 2) * 50 * 1e3))
teminate = true
pthread.cancelThread(tid: t.tid)
pthread.cancelThread(tid: t2.tid)
pthread.waitThreadExit(tid: t.tid)
pthread.waitThreadExit(tid: t2.tid)