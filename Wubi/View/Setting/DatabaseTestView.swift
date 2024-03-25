//
//  DatabaseTestView.swift
//  Wubi
//
//  Created by sakuragi on 2024/3/17.
//

import SwiftUI

struct DatabaseTestView: View {
    var body: some View {
        Button(action: {
            do {
              try  Database.shared?.convert98()
            } catch {
                print("error: \(error)")
            }
        }, label: {
            Text("转换98五笔数据表")
        })
        
        Button(action: {
            do {
                try Database.shared?.createTable86Dic()
            } catch {
                print("search error: \(error)")
            }
            Database.shared?.insert86Data()
            Database.shared?.insert86compents()
        }, label: {
            Text("转换86五笔数据表")
        })
        
        Button(action: {
            do {
                try Database.shared?.createTableGbk()
            } catch {
                print("search error: \(error)")
            }
            Database.shared?.insertgbkData()
            Database.shared?.insertgbkcompents()
        }, label: {
            Text("创建gbk五笔数据表")
        })
        
               
    }
}

#Preview {
    DatabaseTestView()
}
