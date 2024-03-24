//
//  Sidebar.swift
//  WubiMac
//
//  Created by yongyou on 2023/7/4.
//

import SwiftUI

struct SideBarLabel: View {
    var item: SideBarItem

    var body: some View {
        HStack {
            Image(systemName:item.icon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.all,4)
                .foregroundColor(.white)
                .background(item.backgroundColor)
                .frame(maxWidth: 20,maxHeight: 20)
                .cornerRadius(5.0)
                
                
            Spacer().frame(width: 10)
            Text(item.name)
        }
    }
}

#Preview {
    SideBarLabel(item: .about).frame(width: 300,height: 300)
}


