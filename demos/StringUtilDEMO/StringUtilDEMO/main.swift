// main.swift
// 15/10/2.

import Foundation


/* "" */
let es = ""

print("es:", es)


var ss = StringUtil.split(string: es, byCharacter: "，".characters.first!)

print("ss: ", ss)


ss = StringUtil.split(string: es, byString: "，")

print("2 ss: ", ss)


/* "xxx" */
var s = "你好，世界，⬆️"
print("s:", s)

ss = StringUtil.split(string: s, byString: "，")
print("ss: ", ss)


s = "你好0，2 xx /世界0，1/⬆️==0，1/😀"
print("s:", s)

ss = StringUtil.split(string: s, byString: "0，1/")
print("ss: ", ss)


ss = StringUtil.split(string: s, byString: "0，1/nnn")
print("2 ss: ", ss)


/* charsCount */
s = "123abc"
var csc = StringUtil.charsCount(ofString: s)
print("s:", s, "len: \(csc)")


s = "一二😓4"
csc = StringUtil.charsCount(ofString: s)
print("s:", s, "len: \(csc)")


/* cstringCount */
csc = StringUtil.cstringCount(ofString: s, whenEncoding: NSUTF8StringEncoding)
print("s:", s, "when utf8 len: \(csc)")


csc = StringUtil.cstringCount(ofString: s, whenEncoding: NSUTF16StringEncoding)
print("s:", s, "2 when utf16 len: \(csc)")


csc = StringUtil.cstringCount(ofString: "", whenEncoding: NSUTF8StringEncoding)
print("s:", "", "3 when utf8 len: \(csc)")


/* substring */
s = "am一二😓XX"
print("s:", s, "0, 0:", StringUtil.substring(ofString: s, from: 0, to: 0))
let c = StringUtil.charsCount(ofString: s)
print("s:", s, "0, \(c):", StringUtil.substring(ofString: s, from: 0, to: c))
print("s:", s, "1, 3:", StringUtil.substring(ofString: s, from: 0, to: 3))
print("s:", s, "-1, \(c):", StringUtil.substring(ofString: s, from: -1, to: c))
print("s:", s, "0, \(c + 1):", StringUtil.substring(ofString: s, from: -1,
	to: (c + 1)))
print("s:", "", "0, 1:", StringUtil.substring(ofString: "", from: 0, to: 1))