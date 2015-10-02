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