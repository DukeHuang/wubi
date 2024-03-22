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
        Text(message)
    }
}

#Preview {
    AttributedDemoView()
        .frame(width: 800,height: 800)
}
