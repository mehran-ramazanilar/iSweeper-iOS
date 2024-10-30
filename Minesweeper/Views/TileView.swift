//
//  TileView.swift
//  Minesweeper
//
//  Created by Mehran Ramazanilar on 2/28/1402 AP.
//

import SwiftUI

struct TileView: View {
    
    @State private var isPressed: Bool = false
    @Binding var data: TileModel
    let action: (_ newItem: TileModel) -> Void
    
    init(data: Binding<TileModel>, action: @escaping (_ newItem: TileModel) -> Void) {
        self._data = data
        self.action = action
    }
    
    var body: some View {
        ZStack {
//            if isPressed == true {
//                if data.type == .bomb {
//                    Color(UIColor(named: "appRed")!)
//                        .frame(minHeight: 40)
//                        .cornerRadius(4)
//                    Image(systemName: "bolt.circle")
//                        .resizable()
//                        .foregroundColor(.white)
//                        .frame(width: 24, height: 24, alignment: .center)
//                } else {
//                    Color(UIColor(named: "appGreen")!)
//                        .frame(minHeight: 40)
//                        .cornerRadius(4)
//                    Text(data.adjacentBombCount > 0 ? "\(data.adjacentBombCount)" : "")
//                }
//            } else {
//                Button {
//                    isPressed = true
//                } label: {
//                    Color(UIColor(named: "appBlue")!)
//                        .frame(minHeight: 40)
//                        .cornerRadius(4)
//                }
//            }
            if data.isOpened {
                if data.type == .bomb {
                    Color(UIColor(named: "appRed")!)
                        .frame(minHeight: 40)
                        .cornerRadius(4)
                } else {
                    Color(UIColor(named: "appGreen")!)
                        .frame(minHeight: 40)
                        .cornerRadius(4)
                    Text(data.adjacentBombCount > 0 ? "\(data.adjacentBombCount)" : "")
                        .foregroundColor(.white)
                }
            } else {
                Button {
                    data.isOpened = true
                    action(data)
                } label: {
//                    if data.type == .bomb {
//                        Image(systemName: "bolt.circle")
//                            .resizable()
//                            .foregroundColor(.white)
//                            .frame(width: 24, height: 24, alignment: .center)
//                    } else {
//                        Text(data.adjacentBombCount > 0 ? "\(data.adjacentBombCount)" : "")
//                            .foregroundColor(.white)
//                    }
                    LinearGradient(
                        colors: [Color("mainColorGradient"), Color("mainColor")],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .frame(minHeight: 40)
                    .cornerRadius(4)
//                    Color(UIColor(named: "appBlue")!)
//                        .frame(minHeight: 40)
//                        .cornerRadius(4)
                }
            }
            
        }
    }
}
