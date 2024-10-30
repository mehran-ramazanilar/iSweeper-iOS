//
//  TileView.swift
//  Minesweeper
//
//  Created by Mehran Ramazanilar on 2/28/1402 AP.
//

import SwiftUI

struct ImageLabelButton: View {
    
    let action: () -> Void
    let labelString: String
    let iconName: String
    
    init(icon: String, label: String, action: @escaping () -> Void) {
        self.action = action
        self.iconName = icon
        self.labelString = label
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack(alignment: .center) {
                Image(iconName)
                    .resizable()
                    .frame(width: 20, height: 20)
                    .padding(.leading, 12)
                
                Text(labelString)
                    .fontWeight(.medium)
                    .font(.system(size: 11))
                    .foregroundColor(Color("mainColor"))
                    .padding(.leading, 2).padding(.trailing, 12)
            }
            .padding(.vertical, 8)
        }
    }
}
