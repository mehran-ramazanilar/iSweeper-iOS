//
//  ContentView.swift
//  Minesweeper
//
//  Created by Mehran Ramazanilar on 2/28/1402 AP.
//

import SwiftUI
import CoreData

struct GameScreen: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var rows: Int = 15
    @State private var bombCount: Int = 20
    @ObservedObject private var viewModel = GameScreenViewModel(rows: 9, columns: 9, bombCount: 10)
    
    var body: some View {
        ZStack {
            Color(UIColor(named: "backgroundColor")!)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack(alignment: .center) {
                    ImageButton(icon: "cupIcon") {
                        print("cup pressed")
                    }
                    .frame(width: 39, height: 39, alignment: .center)
                    .background(
                        RoundedRectangle(cornerRadius: 4, style: .continuous)
                            .fill(
                                .shadow(.drop(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 8, x: 2, y: 2))
                                .shadow(.inner(color: .white.opacity(0.9), radius: 8, x: 2, y: 2))
                            )
                            .foregroundColor(Color("backgroundColor"))
                    )
//                    .background(Color("backgroundColor"))
//                    .cornerRadius(4)
//                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.1), radius: 8, x: 2, y: 2)
                    .padding(.top, 24)
                    .padding(.leading, 16)
                    
                    Spacer()
                    
                    Text("MineSweeper")
                        .fontWeight(.medium)
                        .foregroundColor(Color("mainColor"))
                        .padding(.top, 24)
                    
                    Spacer()
                    
                    ImageButton(icon: "settingsIcon") {
                        print("setting pressed")
                    }
                    .frame(width: 39, height: 39, alignment: .center)
                    .background(Color("backgroundColor"))
                    .cornerRadius(4)
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.1), radius: 8, x: 2, y: 2)
                    .padding(.top, 24)
                    .padding(.trailing, 16)
                }
                
                HStack(alignment: .center) {
                    HStack(alignment: .center) {
                        Image("clockIcon")
                            .resizable()
                            .frame(width: 20, height: 20, alignment: .center)
                            .padding(.vertical, 16).padding(.leading, 20)
                        Text("2:30")
                            .fontWeight(.medium)
                            .foregroundColor(Color("labelColor"))
                        
                        Spacer()
                        
                        Image("bombIcon")
                            .resizable()
                            .frame(width: 20, height: 20, alignment: .center)
                            .padding(.vertical, 12).padding(.leading, 30)
                        Text("10")
                            .fontWeight(.medium)
                            .foregroundColor(Color("labelColor"))
                            .padding(.trailing, 20)
                    }
                    .frame(width: 200)
                    .background(
                        RoundedRectangle(cornerRadius: 4, style: .continuous)
                            .fill(
                                .shadow(.inner(color: Color(red: 0, green: 0, blue: 0, opacity: 0.1),radius: 8, x:4, y: 4))
                            )
                            .foregroundColor(Color("secondaryBackgroundColor")))
                    .padding(.top, 30).padding(.leading, 16)
                    
//                    Spacer()
//                    
//                    ImageButton(icon: "arrow.clockwise.circle", systemImage: true) {
//                        viewModel.regenerate()
//                    }
//                    .frame(width: 39, height: 39, alignment: .center)
//                    .background(Color("backgroundColor"))
//                    .cornerRadius(4)
//                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.1), radius: 8, x: 2, y: 2)
//                    .padding(.top, 30)
                    
                    Spacer()
                    
                    HStack(alignment: .center) {
                        ImageLabelButton(icon: "flagIcon", label: "Add Flag") {
                            print("addFlagPressed")
                        }
                        .frame(height: 39, alignment: .center)
                        .background(Color("backgroundColor"))
                        .cornerRadius(4)
                        .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.1), radius: 8, x: 2, y: 2)
                        .padding(.top, 30)
                        .padding(.trailing, 16)
                    }
                }

                LazyVGrid(columns: viewModel.gridColumns, spacing: viewModel.gridSpacing) {
                    ForEach($viewModel.tiles1D, id: \.id) { item in
                        TileView(data: item) { newItem in
                            viewModel.tileDidPressed(newItem)
                        }
                    }
                }
                .padding(.top, 30)
                .padding(.horizontal, 16)
                
                Spacer()
            }
        }
    }
    
}
