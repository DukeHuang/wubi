//
//  AttributedDemoView.swift
//  WubiMac
//
//  Created by yongyou on 2024/3/12.
//

import SwiftUI

struct AttributedDemoView: View {
    var message: AttributedString {
        let amount = Measurement(value: 200, unit: UnitLength.kilometers)
        var result = amount.formatted(.measurement(width: .wide).attributed)

        let distanceStyling = AttributeContainer.font(.title)
        let distance = AttributeContainer.measurement(.value)
        result.replaceAttributes(distance, with: distanceStyling)

        return result
    }


    var body: some View {

        VStack {
            Text(message)
            Button("登录/注册1") {

            }
            .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15))
            .cornerRadius(15)
            Button("登录/注册2") {

            }
            .foregroundColor(.white)
            .padding(EdgeInsets(top: 38, leading: 15, bottom: 38, trailing: 15))
            .background(Color.gray)
            .clipShape(Circle())

            Button("登录/注册3") {

            }
            .foregroundColor(.white)
            .padding(EdgeInsets(top: 38, leading: 15, bottom: 38, trailing: 15))
            .background(Color.gray)
            .clipShape(Circle())

            Button("登录/注册4") {

            }
            .foregroundColor(.white)
            .padding(EdgeInsets(top: 38, leading: 15, bottom: 38, trailing: 15))
            .background(Color.gray)
            .clipShape(Circle())

            Button("登录/注册5") {

            }
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .stroke(.orange, lineWidth: 2)

            )
            Button("登录/注册6") {

            }
            .overlay(Circle().stroke(.orange, lineWidth: 2))
        }



    }
}

#Preview {
    AttributedDemoView()
        .frame(width: 800,height: 800)
}
