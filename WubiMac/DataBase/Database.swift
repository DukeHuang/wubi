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

    public let dbMainPointer: OpaquePointer? //五笔拆字
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
    func createTableGbk() throws {
        let createTableString = """
        CREATE TABLE IF NOT EXISTS wubigbk(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            word CHAR(255) NOT NULL UNIQUE,
            components CHAR(255),
            jianma_1 CHAR(255),
            jianma_2 CHAR(255),
            jianma_3 CHAR(255),
            quanma CHAR(255),
            pinyin CHAR(255));
        """
        guard let createTableStatement = try? prepareStatement(sql: createTableString) else {
            throw SQLiteError.Prepare(message: "Failed to prepare create table statement")
        }
        defer {
            sqlite3_finalize(createTableStatement)
        }
        if sqlite3_step(createTableStatement) == SQLITE_DONE {
            print("wubigbk table created successfully.")
        } else {
            let error = String(cString: sqlite3_errmsg(dbMainPointer))
            throw SQLiteError.Step(message: "Failed to create wubigbk table: \(error)")
        }
    }
}

extension Database {
    func createTable86Dic() throws {
        let createTableString = """
        CREATE TABLE IF NOT EXISTS wubi86(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            word CHAR(255) NOT NULL UNIQUE,
            components CHAR(255),
            jianma_1 CHAR(255),
            jianma_2 CHAR(255),
            jianma_3 CHAR(255),
            quanma CHAR(255),
            pinyin CHAR(255));
        """
        guard let createTableStatement = try? prepareStatement(sql: createTableString) else {
            throw SQLiteError.Prepare(message: "Failed to prepare create table statement")
        }
        defer {
            sqlite3_finalize(createTableStatement)
        }
        if sqlite3_step(createTableStatement) == SQLITE_DONE {
            print("wubi86 table created successfully.")
        } else {
            let error = String(cString: sqlite3_errmsg(dbMainPointer))
            throw SQLiteError.Step(message: "Failed to create wubi86 table: \(error)")
        }
    }
    
    func update_86(where theKey: String, equal theValue: Any, which key: String, equal value: Any) throws {
        let updateStatementString = "UPDATE wubi86 SET \(key) = ? WHERE \(theKey) = ? "
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
    
    func insert86Data() {
        let fileName = "86"
        var insertStatement: OpaquePointer?
        var dic_86: [String: [String]] = [:]
        if let file = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: file)
                if let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as? [[String]] {
                    for arr in jsonArray {
                        if arr.count > 1 {
                            let jianma = arr[0]
                            for word  in arr[1...] {
                                let isExit = dic_86.keys.contains(word)
                                if isExit {
                                    dic_86[word]?.append(jianma)
                                } else {
                                    dic_86[word] = [jianma]
                                }
                            }
                        }
                    }
                }
            } catch {
                print("Error parsing JSON: \(error)")
            }
        }
        //将这个数据插入数据库
        for x in dic_86 {
            let word = x.key
            let jianmas = x.value
            //3.将查到的数据insert到wubi98.db中
            var jianma_1 = ""
            var jianma_2 = ""
            var jianma_3 = ""
            for jianma in jianmas {
                if (jianma.count == 1) {
                    jianma_1 = jianma
                } else if (jianma.count == 2) {
                    jianma_2 = jianma
                } else if (jianma.count == 3) {
                    jianma_3 = jianma
                }
            }
            let quanma = jianmas.max(by: {$0.count < $1.count }) ?? ""
            var insertStatement: OpaquePointer?
            let insertStatementString = "INSERT INTO wubi86 (word, jianma_1, jianma_2, jianma_3,quanma) VALUES (?, ?, ?,?,?);"
            if sqlite3_prepare_v2(dbMainPointer, insertStatementString, -1, &insertStatement, nil) ==
                SQLITE_OK {
                sqlite3_bind_text(insertStatement, 1, (word as NSString).utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 2, (jianma_1 as NSString).utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 3, (jianma_2 as NSString).utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 4, (jianma_3 as NSString).utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 5, (quanma as NSString).utf8String, -1, nil)
                if sqlite3_step(insertStatement) == SQLITE_DONE {
                    print("\nSuccessfully inserted row.")
                } else {
                    print("\nCould not insert row.")
                }
            } else {
                print("\nINSERT statement is not prepared.")
            }
        }
        sqlite3_finalize(insertStatement)
    }
    
    func insert86compents() {
        if let file = Bundle.main.url(forResource: "86", withExtension: "txt") {
            do {
                let fileContent = try String(contentsOf: file, encoding: .utf8)
                // 创建一个空字典来存储解析结果
                var dictionary: [String: String] = [:]

                // 按行分割文件内容
                let lines = fileContent.split(separator: "\n")

                // 遍历每一行
                for line in lines {
                    // 按制表符或多个空格分割每一行以提取汉字和编码
                    let parts = line.split(whereSeparator: { $0.isWhitespace }).map(String.init)
                    if parts.count >= 2 {
                        let character = parts[0]  // 汉字
                        let code = parts.dropFirst().joined(separator: " ")  // 编码，将剩余部分合并回一个字符串
                        dictionary[character] = code
                    }
                }

                // 打印字典查看结果
                for (key, value) in dictionary {
                    print("\(key): \(value)")
                    do {
                        try self.update_86(where: "word", equal: key, which: "components", equal: value)
                    } catch {
                        print("Error update_86 txt  -> key: \(key), value: \(value), error: \(error)")
                    }
                }
            } catch {
                print("Error parsing txt: \(error)")
            }
        }
    }
    
    func insert86pinyin() {
        
    }
}

extension Database {
    
    func isExits(word:UnsafePointer<UInt8>?) -> Bool {
        //查询wubi98中是否有该数据
        let queryStatementString = "SELECT EXISTS(SELECT 1 FROM wubi98 WHERE word = ?);"
        var queryStatement: OpaquePointer?
        if sqlite3_prepare_v2(dbMainPointer, queryStatementString, -1, &queryStatement, nil) ==
            SQLITE_OK {
            sqlite3_bind_text(queryStatement, 1, word, -1, nil)
            if sqlite3_step(queryStatement) == SQLITE_ROW {
                let exists = sqlite3_column_int(queryStatement, 0);
                if (exists > 0) {
                    return true
                } else {
                    return false
                }
            } else {
                return false
            }
        } else {
            return false
        }
    }
    
    func convert98() throws {
        //1.创建一个表wubi98.db
        let createTableString = """
        CREATE TABLE IF NOT EXISTS wubi98(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            word CHAR(255) NOT NULL UNIQUE,
            components CHAR(255),
            jianma_1 CHAR(255),
            jianma_2 CHAR(255),
            jianma_3 CHAR(255),
            quanma CHAR(255),
            pinyin CHAR(255));
        """
        guard let createTableStatement = try? prepareStatement(sql: createTableString) else {
            throw SQLiteError.Prepare(message: "Failed to prepare create table statement")
        }
        defer {
            sqlite3_finalize(createTableStatement)
        }
        if sqlite3_step(createTableStatement) == SQLITE_DONE {
            print("wubi98 table created successfully.")
        } else {
            let error = String(cString: sqlite3_errmsg(dbMainPointer))
            throw SQLiteError.Step(message: "Failed to create wubi98 table: \(error)")
        }
        //2.从main.db中查询数据
        
        let queryStatementString = "SELECT * FROM sing_dic;"

        guard let queryStatement =  try prepareStatement(sql: queryStatementString) else {
            throw SQLiteError.QueryStatementInvalid
        }
        defer {
            sqlite3_finalize(queryStatement)
        }
        while  sqlite3_step(queryStatement) == SQLITE_ROW  {
//            let queryResult = self.resultToDictonary(stmt: queryStatement)
//            print(queryResult)
            
            let a = sqlite3_column_text(queryStatement, 0) //id
            let b = sqlite3_column_text(queryStatement, 1) //简码
            let c = sqlite3_column_text(queryStatement, 2) //单字
            let d = sqlite3_column_text(queryStatement, 3) //拆字
            let e = sqlite3_column_text(queryStatement, 4) //全码
            let f = sqlite3_column_text(queryStatement, 5) //拼音
            
            if (isExits(word: c)) {
                var updateStatementString = ""
                let jianmaString = String(cString:b!)
                if (jianmaString.count == 1) {
                    updateStatementString = "UPDATE wubi98 SET jianma_1 = ? WHERE word = ? "
                } else if (jianmaString.count == 2) {
                    updateStatementString = "UPDATE wubi98 SET jianma_2 = ? WHERE word = ? "
                } else if (jianmaString.count == 3) {
                    updateStatementString = "UPDATE wubi98 SET jianma_3 = ? WHERE word = ? "
                } else if (jianmaString.count == 4) {
                    updateStatementString = "UPDATE wubi98 SET quanma = ? WHERE word = ? "
                }
                
                
                guard let updateStatement = try? prepareStatement(sql: updateStatementString) else {
                    throw SQLiteError.Update(meessage: "statement invalid")
                }
                
                
                guard sqlite3_bind_text(updateStatement, 1, b, -1, nil) == SQLITE_OK else {
                    throw SQLiteError.Bind(message: "Bind  \(String(describing: c)) to word Failed")
                }
                
                guard sqlite3_bind_text(updateStatement, 2, c, -1, nil) == SQLITE_OK else {
                    throw SQLiteError.Bind(message: "Bind  \(String(describing: c)) to word Failed")
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
            }  else {
                //3.将查到的数据insert到wubi98.db中
                
                var insertStatement: OpaquePointer?
                let insertStatementString = "INSERT INTO wubi98 (word, components, jianma_1, jianma_2, jianma_3,quanma,pinyin) VALUES (?, ?, ?,?,?,?,?);"
                if sqlite3_prepare_v2(dbMainPointer, insertStatementString, -1, &insertStatement, nil) ==
                    SQLITE_OK {
                    sqlite3_bind_text(insertStatement, 1, c, -1, nil)
                    sqlite3_bind_text(insertStatement, 2, d, -1, nil)
                    
                    
                    let jianma = String(cString:b!)
                    
                    if (jianma.count == 1) {
                        sqlite3_bind_text(insertStatement, 3, b,  -1, nil)
                        sqlite3_bind_text(insertStatement, 4, "",  -1, nil)
                        sqlite3_bind_text(insertStatement, 5, "",  -1, nil)
                    } else if (jianma.count == 2) {
                        sqlite3_bind_text(insertStatement, 3, "",  -1, nil)
                        sqlite3_bind_text(insertStatement, 4, b,  -1, nil)
                        sqlite3_bind_text(insertStatement, 5, "",  -1, nil)
                    } else if (jianma.count == 3) {
                        sqlite3_bind_text(insertStatement, 3, "",  -1, nil)
                        sqlite3_bind_text(insertStatement, 4, "",  -1, nil)
                        sqlite3_bind_text(insertStatement, 5, b,  -1, nil)
                    }
                    
                    sqlite3_bind_text(insertStatement, 6, e,  -1, nil)
                    sqlite3_bind_text(insertStatement, 7, f,  -1, nil)
                    
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
    func query(table name: String, which key: String, equal value: Any) throws -> [Wubi] {
        let queryStatementString = "SELECT components,pinyin,jianma_1,jianma_2,jianma_3,quanma FROM \(name) WHERE \(key) = ?;"
        
        guard let queryStatement =  try prepareStatement(sql: queryStatementString) else {
            throw SQLiteError.QueryStatementInvalid
        }
        defer {
            sqlite3_finalize(queryStatement)
        }
        
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
        
        var wubis: [Wubi] = []
        while  sqlite3_step(queryStatement) == SQLITE_ROW  {
            let queryResult = self.resultToDictonary(stmt: queryStatement)
            print(queryResult)
            let components = sqlite3_column_text(queryStatement, 0) //拆字
            let pinyin = sqlite3_column_text(queryStatement, 1) //拼音
            let jianma_1 = sqlite3_column_text(queryStatement, 2) //简码
            let jianma_2 = sqlite3_column_text(queryStatement, 3) //简码
            let jianma_3 = sqlite3_column_text(queryStatement, 4) //简码
            let quanma = sqlite3_column_text(queryStatement, 5) //全码
            
            
            let componentsString = String(cString:components!)
            let pinyinString = String(cString:pinyin!)
            let jianma_1String = String(cString:jianma_1!)
            let jianma_2String = String(cString:jianma_2!)
            let jianma_3String = String(cString:jianma_3!)
            let quanmaString = String(cString:quanma!)
            
            var scheme: WubiScheme = .wubi86
            
            if name == "wubi86" {
                scheme = .wubi86
            } else if name == "wubi98" {
                scheme = .wubi98
            } else if name == "wubigbk" {
                scheme = .wubigbk
            }
            
            let wubi = Wubi(word: value as! String, pingyin: pinyinString, components: [scheme: componentsString], jianma_1: [scheme: jianma_1String], jianma_2: [scheme: jianma_2String], jianma_3: [scheme: jianma_3String], quanma: [scheme: quanmaString])
            
            wubis.append(wubi)
        }
        return wubis
    }
    
    func query(scheme: WubiScheme, word:String) -> Wubi? {
        var name = ""
        switch scheme {
        case .wubi86:
            name = "wubi86"
        case .wubi98:
            name = "wubi98"
        case .wubigbk:
            name = "wubigbk"
        }
        
        var wubi: Wubi?
        do {
             wubi = try self.query(table: name, which: "word", equal: word).first
        } catch {
            print(error)
        }
        
        return wubi
    }
    
    func query(word: String) -> Wubi? {
        
        var wubi: Wubi?
        if let wubi86 = query(scheme: .wubi86, word: word) {
            wubi = wubi86
        }
        if let wubi98 = query(scheme: .wubi98, word: word) {
            if let wubi = wubi {
                wubi.jianma_1.merge(wubi98.jianma_1, uniquingKeysWith: { _, new in new })
                wubi.jianma_2.merge(wubi98.jianma_2, uniquingKeysWith: { _, new in new })
                wubi.jianma_3.merge(wubi98.jianma_3, uniquingKeysWith: { _, new in new })
                wubi.quanma.merge(wubi98.quanma, uniquingKeysWith: { _, new in new })
            } else {
                wubi = wubi98
            }
        }
        if let wubigbk = query(scheme: .wubigbk, word: word) {
            if let wubi = wubi {
                wubi.jianma_1.merge(wubigbk.jianma_1, uniquingKeysWith: { _, new in new })
                wubi.jianma_2.merge(wubigbk.jianma_2, uniquingKeysWith: { _, new in new })
                wubi.jianma_3.merge(wubigbk.jianma_3, uniquingKeysWith: { _, new in new })
                wubi.quanma.merge(wubigbk.quanma, uniquingKeysWith: { _, new in new })
            } else {
                wubi = wubigbk
            }
        }
        return wubi
    }

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
