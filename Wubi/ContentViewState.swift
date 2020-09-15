//
//  ContentViewState.swift
//  Wubi
//
//  Created by yongyou on 2020/7/15.
//  Copyright © 2020 sakuragi. All rights reserved.
//

import SwiftUI
import Combine
import SQLite3

let tutorialDirectoryUrl = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)

private enum Database: String {
	case Part1
	case Part2
	
	var path: String? {
		return tutorialDirectoryUrl?.appendingPathComponent("\(self.rawValue).sqlite").relativePath
	}
}

public let part1DbPath = Database.Part1.path

final class ContentViewState: ObservableObject {
	@Published var keyboardName: String = "a"
	@Published var imageName: String = "a1"
	@Published var result: String = ""
	@Published var song: String = ""
	@Published var tipsImageName = ""
	var db: OpaquePointer?
	let dic: Dictionary = ["a": ["a","a1","a2","a3","a4","a5","a6","a7","a8","a9","a10","a11","a12","a13","a14"],
						   "b": ["b","b1","b2","b3","b4","b5","b6","b7","b8","b9","b10","b11","b12","b13","b14","b15"],
						   "c": ["c","c1","c2","c3","c4","c5","c6","c7","c8"],
						   "d": ["d","d1","d2","d3","d4","d5","d6","d7","d8","d9","d10","d11","d12"],
						   "e": ["e","e1","e2","e3","e4","e5","e6","e7","e8","e9","e10","e11","e12","e13","e14","e15","e16"],
						   "f": ["f","f1","f2","f3","f4","f5","f6","f7","f8","f9","f10","f11","f12","f13"],
						   "g": ["g","g1","g2","g3","g4","g5","g6","g7","g8","g9"],
						   "h": ["h","h1","h2","h3","h4","h5","h6","h7","h8","h9","h10","h11"],
						   "i": ["i","i1","i2","i3","i4","i5","i6","i7","i8","i9","i10","i11","i12","i13"],
						   "j": ["j","j1","j2","j3","j4","j5","j6","j7","j8","j9","j10","j11","j12"],
						   "k": ["k","k1","k2","k3","k4"],
						   "l": ["l","l1","l2","l3","l4","l5","l6","l7","l8","l9"],
						   "m": ["m","m1","m2","m3","m4","m5","m6","m7","m8","m9"],
						   "n": ["n","n1","n2","n3","n4","n5","n6","n7","n8","n9","n10","n11","n12","n13","n14","n15","n16"],
						   "o": ["o","o1","o2","o3","o4","o5","o6","o7","o8","o9"],
						   "p": ["p","p1","p2","p3","p4","p5","p6","p7"],
						   "q": ["q","q1","q2","q3","q4","q5","q6","q7","q8","q9","q10","q11","q12","q13","q14","q15","q16","q17"],
						   "r": ["r","r1","r2","r3","r4","r5","r6","r7","r8","r9","r10"],
						   "s": ["s","s1","s2","s3","s4","s5","s6"],
						   "t": ["t","t1","t2","t3","t4","t5","t6","t7"],
						   "u": ["u","u1","u2","u3","u4","u5","u6","u7","u8","u9","u10","u11","u12","u13","u14","u15","u16","u17"],
						   "v": ["v","v1","v2","v3","v4","v5","v6","v7","v8","v9","v10"],
						   "w": ["w","w1","w2","w3","w4","w5","w6","w7","w8"],
						   "x": ["x","x1","x2","x3","x4","x5","x6","x7","x8","x9","x10","x11","x12","x13"],
						   "y": ["y","y1","y2","y3","y4","y5","y6","y7","y8","y9","y10","y11","y12"]]
	let dicSong: Dictionary =	  ["g": "王旁青头五夫一",
								   "f": "土干十寸未甘雨",
								   "d": "大犬戊其古石厂",
								   "s": "木丁西甫一四里",
								   "a": "工戈草头右框七",
								   "h": "目上卜止虎头具",
								   "j": "日早两竖与虫依",
								   "k": "口中两川三个竖",
								   "l": "田甲方框四车里",
								   "m": "山由贝骨下框集",
								   "t": "禾竹反文双人立",
								   "r": "白斤气丘叉手提",
								   "e": "月用力豸毛衣臼",
								   "w": "人八登头单人几",
								   "q": "金夕鸟儿犭边鱼",
								   "y": "言文方点谁人去",
								   "u": "立辛六羊病门里",
								   "i": "水族三点鳖头小",
								   "o": "火业广鹿四点米",
								   "p": "之字宝盖补礻衤",
								   "n": "已类左框心尸羽",
								   "b": "子耳了也乃框皮",
								   "v": "女刀九艮山西倒",
								   "c": "又巴牛厶马失蹄",
								   "x": "幺母贯头弓和匕",]
	
	func randomImageName() -> Void {
		self.keyboardName = self.dic.randomElement()?.key as! String
		self.imageName = self.dic[self.keyboardName]?.randomElement()! as! String
//		self.song = ""
		self.song = self.dicSong[self.keyboardName]!
//		self.tipsImageName  = ""
		self.tipsImageName  = "\(self.keyboardName)_keyboard"
		self.result = "right"
	}
	func showTips() -> Void {
		self.song = self.dicSong[self.keyboardName]!
		self.tipsImageName  = "\(self.keyboardName)_keyboard"
		self.result = "error"
	}
	
	func showCountAdd(keyName:String) -> Void {
		
	}
	
	func openDatabase() -> OpaquePointer? {
		guard let part1DbPath = part1DbPath else {
			print("part1DbPath is nil.")
			return nil
		}
		if sqlite3_open(part1DbPath, &db) == SQLITE_OK {
			print("Successfully opened connection to database at \(part1DbPath)")
			return db
		} else {
			print("Unable to open database.")
			return nil
		}
	}
	func createTable() {
		// 1
		var createTableStatement: OpaquePointer?
		
		let createTableString = """
		CREATE TABLE Contact(
		Id INT PRIMARY KEY NOT NULL,
		KeyName CHAR(255),
		KeyValue CHAR(255),
		ShowCount INTEGER,
		ErrorCount INTEGER)
		"""
		// 2
		if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) ==
			SQLITE_OK {
			// 3
			if sqlite3_step(createTableStatement) == SQLITE_DONE {
				print("\nContact table created.")
			} else {
				print("\nContact table is not created.")
			}
		} else {
			print("\nCREATE TABLE statement is not prepared.")
		}
		// 4
		sqlite3_finalize(createTableStatement)
	}
	
	func insert() {
		var insertStatement: OpaquePointer?
		let insertStatementString = "INSERT INTO Contact (Id, KeyName,KeyValue,ShowCount,ErrorCount) VALUES (?, ?, ?,0,0);"

		// 1
		var id: Int32 = 1
		for e in dic {
			let keyValueArr: Array = dic[e.key]!
			for v in keyValueArr {
				if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) ==
					SQLITE_OK {
					
					let keyName: String = e.key
					// 2
					sqlite3_bind_int(insertStatement, 1, id)
					id+=1
					// 3
					sqlite3_bind_text(insertStatement, 2, (keyName as NSString).utf8String, -1, nil)

					sqlite3_bind_text(insertStatement, 3, (v as NSString ).utf8String, -1, nil)
					// 4
					if sqlite3_step(insertStatement) == SQLITE_DONE {
						print("\nSuccessfully inserted row.")
					} else {
						print("\nCould not insert row.")
					}
				} else {
					print("\nINSERT statement is not prepared.")
				}
			}
			
		}
		// 5
		sqlite3_finalize(insertStatement)
	}
	
	func update(updateStatementString:String) {
//		let updateStatementString = "UPDATE Contact SET Name = 'Adam' WHERE Id = 1;"
		var updateStatement: OpaquePointer?
		if sqlite3_prepare_v2(db, updateStatementString, -1, &updateStatement, nil) ==
			SQLITE_OK {
			
			
			if sqlite3_step(updateStatement) == SQLITE_DONE {
				print("\nSuccessfully updated row.")
			} else {
				print("\nCould not update row.")
			}
		} else {
			print("\nUPDATE statement is not prepared")
		}
		sqlite3_finalize(updateStatement)
	}
	
	func AddShowCount(keyValue:String) {
		let updateStatementString = "UPDATE Contact SET ShowCount = ShowCount + 1 WHERE KeyValue = ?;"
		var updateStatement: OpaquePointer?
		if sqlite3_prepare_v2(db, updateStatementString, -1, &updateStatement, nil) ==
			SQLITE_OK {
			sqlite3_bind_text(updateStatement, 1, (keyValue as NSString).utf8String, -1, nil)
			if sqlite3_step(updateStatement) == SQLITE_DONE {
				print("\nSuccessfully updated row for ShowCount.")
			} else {
				print("\nCould not update row for ShowCount.")
			}
		} else {
			print("\nUPDATE statement is not prepared for ShowCount")
		}
		sqlite3_finalize(updateStatement)
	}
	
	
	func AddErrorCount(keyValue:String) {
		let updateStatementString = "UPDATE Contact SET ErrorCount = ErrorCount + 1 WHERE KeyValue = ?;"
		var updateStatement: OpaquePointer?
		if sqlite3_prepare_v2(db, updateStatementString, -1, &updateStatement, nil) ==
			SQLITE_OK {
			sqlite3_bind_text(updateStatement, 1, (keyValue as NSString).utf8String, -1, nil)
			if sqlite3_step(updateStatement) == SQLITE_DONE {
				print("\nSuccessfully updated row for ErrorCount.")
			} else {
				print("\nCould not update row for ErrorCount.")
			}
		} else {
			print("\nUPDATE statement is not prepared for ErrorCount")
		}
		sqlite3_finalize(updateStatement)
	}
}


