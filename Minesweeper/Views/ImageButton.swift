//
//  TileView.swift
//  Minesweeper
//
//  Created by Mehran Ramazanilar on 2/28/1402 AP.
//

import SwiftUI

struct ImageButton: View {
    
    let action: () -> Void
    let iconName: String
    var systemImage: Bool
    
    init(icon: String, systemImage: Bool = false, action: @escaping () -> Void) {
        self.action = action
        self.iconName = icon
        self.systemImage = systemImage
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            if systemImage {
                Image(systemName: iconName)
                    .resizable()
                    .tint(Color("mainColor"))
                    .frame(width: 20, height: 20)
            } else {
                Image(iconName)
                    .resizable()
                    .frame(width: 20, height: 20)
            }
        }
    }
}
