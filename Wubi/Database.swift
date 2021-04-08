//
//  Database.swift
//  Wubi
//
//  Created by yongyou on 2021/1/27.
//  Copyright © 2021 sakuragi. All rights reserved.
//

import Foundation
import SQLite3

enum DatabasePart: String {
    case Part1
    case Part2
    var path: String? {
        let directoryUrl = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        return directoryUrl?.appendingPathComponent("\(self.rawValue).sqlite").relativePath
    }
}

struct FiveTypist {
    var character: String //字
    var components: String //字根
    var alphabetical: String //简码
    var all_alphabetical: String //全码
    var pingyin: String //拼音
}

struct Database {
    var db: OpaquePointer?
    var db1: OpaquePointer?
    var fileStroke: FiveStroke {
        get {
            return FiveStroke()
        }
    }
    func openDatabase() -> OpaquePointer? {
        var db: OpaquePointer?
        guard let part1DbPath = DatabasePart.Part1.path else {
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

    func openDatabase1() -> OpaquePointer? {
        var db: OpaquePointer?
        guard let path = Bundle.main.path(forResource: "single", ofType: "db") else {
            print("part1DbPath is nil.")
            return nil
        }
        if sqlite3_open(path, &db) == SQLITE_OK {
            print("Successfully opened connection to database at \(path)")
            return db
        } else {
            print("Unable to open database.")
            return nil
        }
    }


    func createTable() {
        let createTableString = """
                CREATE TABLE Contact(
                Id INT PRIMARY KEY NOT NULL,
                KeyName CHAR(255),
                KeyValue CHAR(255),
                ShowCount INTEGER,
                ErrorCount INTEGER)
                """
        var createTableStatement: OpaquePointer?
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) ==
            SQLITE_OK {
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print("\nContact table created.")
            } else {
                print("\nContact table is not created.")
            }
        } else {
            print("\nCREATE TABLE statement is not prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    func insert() {
        var insertStatement: OpaquePointer?
        let insertStatementString = "INSERT INTO Contact (Id, KeyName,KeyValue,ShowCount,ErrorCount) VALUES (?, ?, ?,0,0);"

        var id: Int32 = 1
        for e in fileStroke.components {
            let keyValueArr: Array = fileStroke.components[e.key]!
            for v in keyValueArr {
                if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) ==
                    SQLITE_OK {

                    let keyName: String = e.key
                    sqlite3_bind_int(insertStatement, 1, id)
                    id+=1
                    sqlite3_bind_text(insertStatement, 2, (keyName as NSString).utf8String, -1, nil)

                    sqlite3_bind_text(insertStatement, 3, (v as NSString ).utf8String, -1, nil)
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
        sqlite3_finalize(insertStatement)
    }

    func update(updateStatementString:String) {
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
    func addShowCount(keyValue:String) {
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
    func addErrorCount(keyValue:String) {
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
    func query(keyValue:String) -> FiveTypist? {
        let queryStatementString = "Select B_key,C_key,D_key,E_key,F_key FROM sing_dic  where C_Key = ?;"
        var queryStatement: OpaquePointer?
        if sqlite3_prepare_v2(db1, queryStatementString, -1, &queryStatement, nil) ==
            SQLITE_OK {
            sqlite3_bind_text(queryStatement, 1, (keyValue as NSString).utf8String, -1, nil)
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let b = sqlite3_column_text(queryStatement, 0)
                let c = sqlite3_column_text(queryStatement, 1)
                let d = sqlite3_column_text(queryStatement, 2)
                let e = sqlite3_column_text(queryStatement, 3)
                let f = sqlite3_column_text(queryStatement, 4)

                let bString = String(cString:b!)
                let cString = String(cString:c!)
                let dString = String(cString:d!)
                let eString = String(cString:e!)
                let fString = String(cString:f!)
                sqlite3_finalize(queryStatement)
                return FiveTypist(character: cString, components: dString, alphabetical: bString, all_alphabetical: eString, pingyin: fString)
            }
                return nil;
        } else {
            let errorMessage = String(cString: sqlite3_errmsg(db1))
            print("\nQuery is not prepared \(errorMessage)")
            sqlite3_finalize(queryStatement)
            return nil
        }
    }

}
