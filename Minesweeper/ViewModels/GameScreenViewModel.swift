//
//  GameScreenViewModel.swift
//  Minesweeper
//
//  Created by Mehran Ramazanilar on 2/28/1402 AP.
//

import Combine
import Foundation
import SwiftUI

class GameScreenViewModel: ObservableObject {
    
    @Published var tiles2D: [[TileModel]] = []
    @Published var tiles1D: [TileModel] = []
    @Published var didFindBomb: Bool = false
    
    var board: BoardModel?
    var gridColumns: [GridItem]
    var openedArray: [Int] = []
    var arrayToOpen: [Int] = []
    
    let rows: Int
    let columns: Int
    let bombCount: Int
    let gridSpacing: CGFloat = 2
    
    init(rows: Int, columns: Int, bombCount: Int) {
        self.rows = rows
        self.columns = columns
        self.bombCount = bombCount
        self.gridColumns = []
        setup()
    }
    
    func setup() {
        for _ in 1...columns {
            self.gridColumns.append(GridItem(spacing: gridSpacing))
        }
        let bombPositions = getRandomBombs()
        board = .init(rows: rows, columns: columns, bombs: bombPositions)
        create2DArray(bombs: bombPositions)
    }
    
    func getRandomBombs() -> [Int] {
        var bombsArray: [Int] = []
        for _ in 1...bombCount {
            var isAvailable = true
            while isAvailable == true {
                let randomNumber = Int.random(in: 0...(rows * columns) - 1)
                if !bombsArray.contains(randomNumber) {
                    bombsArray.append(randomNumber)
                    isAvailable = false
                }
            }
        }
        return bombsArray.sorted { $0 < $1 }
    }
    
    func create2DArray(bombs: [Int]) {
        guard let board = board else { return }
        for rowIndex in 0...(rows - 1) {
            var newArray: [TileModel] = []
            for columnIndex in 0...(columns - 1) {
                let tileIndex = (rowIndex * columns) + (columnIndex + 1) - 1
                let tile = TileModel(id: UUID(), board: board, row: rowIndex, column: columnIndex, index: tileIndex)
                newArray.append(tile)
                tiles1D.append(tile)
            }
            tiles2D.append(newArray)
        }
    }
    
    func tileDidPressed(_ tile: TileModel) {
        switch tile.type {
        case .empty:
            arrayToOpen = tile.getNeighborPositionsToOpen()
            openEmptyTiles()
        case .number:
            break
        case .bomb:
            break
        }
    }
    
    func openEmptyTiles() {
        var newArray: [Int] = []
        for i in arrayToOpen {
            if tiles1D[i].type != .bomb {
                tiles1D[i].isOpened = true
                if openedArray.contains(i) == false {
                    openedArray.append(i)
                }
            }
            if tiles1D[i].type == .empty {
                let newNeighbors = tiles1D[i].getNeighborPositionsToOpen()
                for newNeighbor in newNeighbors {
                    if tiles1D[newNeighbor].isOpened == false && openedArray.contains(newNeighbor) == false && newArray.contains(newNeighbor) == false {
                        newArray.append(newNeighbor)
                    }
                }
                arrayToOpen = newArray
            }
        }
        if arrayToOpen.count > 0 && newArray.count > 0 {
            openEmptyTiles()
        }
    }
    
    func regenerate() {
        openedArray = []
        arrayToOpen = []
        tiles1D = []
        tiles2D = []
        let bombPositions = getRandomBombs()
        board = .init(rows: rows, columns: columns, bombs: bombPositions)
        create2DArray(bombs: bombPositions)
    }
    
}
