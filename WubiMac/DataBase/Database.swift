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
    case user //用户记录表
    case main //五笔字根单字
    var path: String? {
        if let directoryUrl = try? FileManager.default.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("\(self.rawValue).db").relativePath {
            if !FileManager.default.fileExists(atPath: directoryUrl) {
                if let dbResourcePath = Bundle.main.path(forResource: "\(self.rawValue)", ofType: "db") {
                    do {
                        try FileManager.default.copyItem(atPath: dbResourcePath, toPath: directoryUrl)
                    } catch {

                    }
                }
            }
            return directoryUrl
        } else {
            return nil
        }
    }
}

enum SQLiteError: Error {
    case OpenDatabase(message: String)
    case Prepare(message: String)
    case Step(message: String)
    case Bind(message: String)
    case Update(meessage: String)
    case Query(message: String)
    case QueryStatementInvalid
}


//protocol SQLTable {
//    static var createStatement: String { get }
//}
//
//extension Wubi: SQLTable {
//    static var createStatement: String {
//        return "ALTER TABLE sing_dic ADD COLUMN is_Favorite INTEGER DEFAULT 0"
//    }
//}

class Database {

    static let shared = try? Database.open(path: DatabasePart.main.path!)

    private let dbMainPointer: OpaquePointer? //五笔拆字
//    private let dbUserPointer: OpaquePointer? //五笔练习


    private init(dbMainPointer: OpaquePointer?) {
        self.dbMainPointer = dbMainPointer
//        self.dbUserPointer = dbUserPointer
    }

    fileprivate var errorMessage: String {
        if let errorPointer = sqlite3_errmsg(dbMainPointer) {
            let errorMessage = String(cString: errorPointer)
            return errorMessage
        } else {
            return "No error message provided from sqlite."
        }
    }

    deinit {
        sqlite3_close(dbMainPointer)
    }

    static func open(path: String) throws -> Database {
        var db: OpaquePointer?
        if sqlite3_open(path, &db) == SQLITE_OK {
            print("Successfully opened connection to database at \(path)")
            return Database(dbMainPointer: db)
        } else {
            defer {
                if db != nil {
                    sqlite3_close(db)
                }
            }
            if let errorPointer = sqlite3_errmsg(db) {
                let message = String(cString: errorPointer)
                throw SQLiteError.OpenDatabase(message: message)
            } else {
                throw SQLiteError.OpenDatabase(message: "No error message provided from sqlite.")
            }
        }
    }
}

extension Database {
    func prepareStatement(sql: String) throws -> OpaquePointer? {
        var statement: OpaquePointer?
        guard sqlite3_prepare_v2(dbMainPointer, sql, -1, &statement, nil) == SQLITE_OK else {
            throw SQLiteError.Prepare(message: errorMessage)
        }
        return statement
    }
}

extension Database {
    private func resultToDictonary(stmt: OpaquePointer?) -> [String: Any] {
        let columnCount = sqlite3_column_count(stmt)
        var dict = [String : Any](minimumCapacity: Int(columnCount))

        for column in 0..<columnCount {
            if let cName = sqlite3_column_name(stmt, column),
               let name = String(cString: cName, encoding: .utf8),
               let value = valueOfSQLStatement(stmt, atColumn: column) {
                dict[name] = value
            }
        }

        return dict
    }

    private func valueOfSQLStatement(_ stmt: OpaquePointer!, atColumn column: Int32) -> Any? {

        var value: Any?
        let type = sqlite3_column_type(stmt, column)
        switch type {
        case SQLITE_INTEGER:
            value = sqlite3_column_int(stmt, column)
        case SQLITE_FLOAT:
            value = sqlite3_column_double(stmt, column)
        case SQLITE_TEXT:
            value = String(cString: sqlite3_column_text(stmt, column))
        case SQLITE_NULL:
            value = nil
        case SQLITE_BLOB:
//            DLog("SQLite type 'BLOB' not supported right now")
            value = nil
        default:
//            DLog("Unknown data type: \(type)")
            value = nil
        }
        //record the screen
        return value
    }


    func update(where theKey: String, equal theValue: Any, which key: String, equal value: Any) throws {
        let updateStatementString = "UPDATE sing_dic SET \(key) = ? WHERE \(theKey) = ? "
        guard let updateStatement = try? prepareStatement(sql: updateStatementString) else {
            throw SQLiteError.Update(meessage: "statement invalid")
        }

        if  let value = value as? Int {
            guard sqlite3_bind_int(updateStatement, 1, Int32(value as Int)) == SQLITE_OK else {
                throw SQLiteError.Bind(message: "Bind  \(value) to \(key) Failed")
            }

        } else if let value = value as? Double {
            guard sqlite3_bind_double(updateStatement, 1, Double(floatLiteral: value)) == SQLITE_OK else {
                throw SQLiteError.Bind(message: "Bind  \(value) to \(key) Failed")
            }
        } else if let value =  value as? String {
            guard sqlite3_bind_text(updateStatement, 1, (value as NSString).utf8String, -1, nil) == SQLITE_OK else {
                throw SQLiteError.Bind(message: "Bind  \(value) to \(key) Failed")
            }
        } else {
            throw SQLiteError.Bind(message: "Bind  \(value) to \(key) Failed, not supported this type")
        }

        if  let theValue = theValue as? Int {
            guard sqlite3_bind_int(updateStatement, 2, Int32(theValue as Int)) == SQLITE_OK else {
                throw SQLiteError.Bind(message: "Bind  \(value) to \(key) Failed")
            }

        } else if let theValue = theValue as? Double {
            guard sqlite3_bind_double(updateStatement, 2, Double(floatLiteral: theValue)) == SQLITE_OK else {
                throw SQLiteError.Bind(message: "Bind  \(theValue) to \(theKey) Failed")

            }
        } else if let theValue =  theValue as? String {
            guard sqlite3_bind_text(updateStatement, 2, (theValue as NSString).utf8String, -1, nil) == SQLITE_OK else {
                throw SQLiteError.Bind(message: "Bind  \(theValue) to \(theKey) Failed")
            }
        } else {
            throw SQLiteError.Bind(message: "Bind  \(theValue) to \(theKey) Failed, not supported this type")
        }

        defer {
            sqlite3_finalize(updateStatement)
        }

        if sqlite3_step(updateStatement) == SQLITE_DONE {
            print("update success")
        } else {
            let error = String(cString:sqlite3_errmsg(updateStatement))
            throw SQLiteError.Update(meessage: error)
        }
    }

    func query(key: String, value: Any) throws -> [Wubi] {
        let queryStatementString = "SELECT * FROM sing_dic WHERE \(key) = ?;"

        guard let queryStatement =  try prepareStatement(sql: queryStatementString) else {
            throw SQLiteError.QueryStatementInvalid
        }
        defer {
            sqlite3_finalize(queryStatement)
        }

//        guard sqlite3_bind_text(queryStatement, 1, (key as NSString).utf8String, -1, nil) == SQLITE_OK else {
//            throw SQLiteError.Bind(message: "Bind  \(key) to \(key) Failed")
//        }

        if  let value = value as? Int {
            guard sqlite3_bind_int(queryStatement, 1, Int32(value as Int)) == SQLITE_OK else {
                throw SQLiteError.Bind(message: "Bind  \(value) to \(key) Failed")
            }

        } else if let value = value as? Double {
            guard sqlite3_bind_double(queryStatement, 1, Double(floatLiteral: value)) == SQLITE_OK else {
                throw SQLiteError.Bind(message: "Bind  \(value) to \(key) Failed")
            }
        } else if let value =  value as? String {
            guard sqlite3_bind_text(queryStatement, 1, (value as NSString).utf8String, -1, nil) == SQLITE_OK else {
                throw SQLiteError.Bind(message: "Bind  \(value) to \(key) Failed")
            }
        } else {
            throw SQLiteError.Bind(message: "Bind  \(value) to \(key) Failed, not supported this type")
        }

//        guard sqlite3_step(queryStatement) == SQLITE_ROW  else {
//            throw SQLiteError.Query(message: "faild")
//        }

        var wubis: [Wubi] = []
        while  sqlite3_step(queryStatement) == SQLITE_ROW  {
            let queryResult = self.resultToDictonary(stmt: queryStatement)
            print(queryResult)

            let a = sqlite3_column_text(queryStatement, 0) //id
            let b = sqlite3_column_text(queryStatement, 1) //简码
            let c = sqlite3_column_text(queryStatement, 2) //单字
            let d = sqlite3_column_text(queryStatement, 3) //拆字
            let e = sqlite3_column_text(queryStatement, 4) //全码
            let f = sqlite3_column_text(queryStatement, 5) //拼音
//            let g = sqlite3_column_int(queryStatement, 6) //是否收藏过

            let aString = String(cString:a!)
            let bString = String(cString:b!)
            let cString = String(cString:c!)
            let dString = String(cString:d!)
            let eString = String(cString:e!)
            let fString = String(cString:f!)
//            let gBool = g != 0

            let wubi = Wubi(id: aString, character: cString, components: dString, jianma: bString,
                            quanma: eString, jianmaKeys: bString.map { String($0) },
                            quanmaKeys: eString.map { String($0) }, pingyin: fString)

            wubis.append(wubi)
        }
        return wubis
    }

    func query(keyValue:String) throws -> Wubi {

        if let wubi = try self.query(key: "C_key", value: keyValue).first {
            return wubi
        } else {
            throw  SQLiteError.QueryStatementInvalid
        }
    }

//    func queryFavorites() throws -> [Wubi] {
//        return try self.query(key: "is_Favorite", value: 1)
//    }


//    func isExitColumn() throws -> Bool {
//
//        let statementString = "SELECT count(*) FROM pragma_table_info('sing_dic') WHERE name = 'is_Favorites'"
//        guard let statement = try? prepareStatement(sql: statementString) else {
//            throw SQLiteError.invalid
//        }
//        defer {
//            sqlite3_finalize(statement)
//        }
//        guard sqlite3_step(statement) == SQLITE_ROW  else {
//            throw SQLiteError.noResult
//        }
//        return false
//        //        return count > 0
//    }

//    func addColumn() throws {
//        if (try self.isExitColumn()) {
//            return
//        }
//        let addColumnStatementString = "ALTER TABLE sing_dic ADD COLUMN is_Favorite INTEGER DEFAULT 0"
//        guard let addColumnStatement = try? prepareStatement(sql: addColumnStatementString) else {
//            throw SQLiteError.invalid
//        }
//        defer {
//            sqlite3_finalize(addColumnStatement)
//        }
//        guard sqlite3_step(addColumnStatement) == SQLITE_DONE  else {
//            throw SQLiteError.noResult
//        }
//    }
}

//extension Database {
//
//    func openDatabaseFiveTypistPractise() -> OpaquePointer? {
//        var db: OpaquePointer?
//        guard let fiveTypistPractise = DatabasePart.user.path else {
//            print("fiveTypistPractise is nil.")
//            return nil
//        }
//        if sqlite3_open(fiveTypistPractise, &db) == SQLITE_OK {
//            print("Successfully opened connection to database at \(fiveTypistPractise)")
//            return db
//        } else {
//            print("Unable to open database fiveTypistPractise")
//            return nil
//        }
//    }
//
//    func createTable() {
//        let createTableString = """
//                CREATE TABLE Contact(
//                Id INT PRIMARY KEY NOT NULL,
//                KeyName CHAR(255),
//                KeyValue CHAR(255),
//                ShowCount INTEGER,
//                ErrorCount INTEGER)
//                """
//        var createTableStatement: OpaquePointer?
//        if sqlite3_prepare_v2(db_user, createTableString, -1, &createTableStatement, nil) ==
//            SQLITE_OK {
//            if sqlite3_step(createTableStatement) == SQLITE_DONE {
//                print("\nContact table created.")
//            } else {
//                print("\nContact table is not created.")
//            }
//        } else {
//            print("\nCREATE TABLE statement is not prepared.")
//        }
//        sqlite3_finalize(createTableStatement)
//    }
//    func insert() {
//        var insertStatement: OpaquePointer?
//        let insertStatementString = "INSERT INTO Contact (Id, KeyName,KeyValue,ShowCount,ErrorCount) VALUES (?, ?, ?,0,0);"
//
//        var id: Int32 = 1
//        for e in FiveStroke.components {
//            let keyValueArr: Array = FiveStroke.components[e.key]!
//            for v in keyValueArr {
//                if sqlite3_prepare_v2(db_user, insertStatementString, -1, &insertStatement, nil) ==
//                    SQLITE_OK {
//
//                    let keyName: String = e.key
//                    sqlite3_bind_int(insertStatement, 1, id)
//                    id+=1
//                    sqlite3_bind_text(insertStatement, 2, (keyName as NSString).utf8String, -1, nil)
//
//                    sqlite3_bind_text(insertStatement, 3, (v as NSString ).utf8String, -1, nil)
//                    if sqlite3_step(insertStatement) == SQLITE_DONE {
//                        print("\nSuccessfully inserted row.")
//                    } else {
//                        print("\nCould not insert row.")
//                    }
//                } else {
//                    print("\nINSERT statement is not prepared.")
//                }
//            }
//        }
//        sqlite3_finalize(insertStatement)
//    }
//
//    func update(updateStatementString:String) {
//        var updateStatement: OpaquePointer?
//        if sqlite3_prepare_v2(db_user, updateStatementString, -1, &updateStatement, nil) ==
//            SQLITE_OK {
//            if sqlite3_step(updateStatement) == SQLITE_DONE {
//                print("\nSuccessfully updated row.")
//            } else {
//                print("\nCould not update row.")
//            }
//        } else {
//            print("\nUPDATE statement is not prepared")
//        }
//        sqlite3_finalize(updateStatement)
//    }
//    func addShowCount(keyValue:String) {
//        let updateStatementString = "UPDATE Contact SET ShowCount = ShowCount + 1 WHERE KeyValue = ?;"
//        var updateStatement: OpaquePointer?
//        if sqlite3_prepare_v2(db_user, updateStatementString, -1, &updateStatement, nil) ==
//            SQLITE_OK {
//            sqlite3_bind_text(updateStatement, 1, (keyValue as NSString).utf8String, -1, nil)
//            if sqlite3_step(updateStatement) == SQLITE_DONE {
//                print("\nSuccessfully updated row for ShowCount.")
//            } else {
//                print("\nCould not update row for ShowCount.")
//            }
//        } else {
//            print("\nUPDATE statement is not prepared for ShowCount")
//        }
//        sqlite3_finalize(updateStatement)
//    }
//    func addErrorCount(keyValue:String) {
//        let updateStatementString = "UPDATE Contact SET ErrorCount = ErrorCount + 1 WHERE KeyValue = ?;"
//        var updateStatement: OpaquePointer?
//        if sqlite3_prepare_v2(db_user, updateStatementString, -1, &updateStatement, nil) ==
//            SQLITE_OK {
//            sqlite3_bind_text(updateStatement, 1, (keyValue as NSString).utf8String, -1, nil)
//            if sqlite3_step(updateStatement) == SQLITE_DONE {
//                print("\nSuccessfully updated row for ErrorCount.")
//            } else {
//                print("\nCould not update row for ErrorCount.")
//            }
//        } else {
//            print("\nUPDATE statement is not prepared for ErrorCount")
//        }
//        sqlite3_finalize(updateStatement)
//    }
//
//
//}
