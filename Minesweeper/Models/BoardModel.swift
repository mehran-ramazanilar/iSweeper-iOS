//
//  BoardModel.swift
//  Minesweeper
//
//  Created by Mehran Ramazanilar on 2/28/1402 AP.
//

import Foundation

struct BoardModel {
    let rows: Int
    let columns: Int
    let bombs: [Int]
    
    var tileCount: Int {
        return rows * columns
    }
    
    var topLeftCornerIndex: Int {
        return 0
    }
    
    var topRightCornerIndex: Int {
        return columns - 1
    }
    
    var bottomLeftCornerIndex: Int {
        return (tileCount - (columns - 1)) - 1
    }
    
    var bottomRightCornerIndex: Int {
        return tileCount - 1
    }
    
    func getTopEdgeIndexes() -> [Int] {
        var array: [Int] = []
        for i in 1...columns {
            array.append(i - 1)
        }
        return array.filter { $0 != topLeftCornerIndex && $0 != topRightCornerIndex }
    }
    
    func getBottomEdgeIndexes() -> [Int] {
        var array: [Int] = []
        let startIndex: Int = columns * (rows - 1)
        for i in 1...columns {
            array.append(startIndex + (i - 1))
        }
        return array.filter { $0 != bottomLeftCornerIndex && $0 != bottomRightCornerIndex }
    }
    
    func getLeftEdgeIndexes() -> [Int] {
        var array: [Int] = []
        for i in 1...rows {
            array.append((i - 1) * columns)
        }
        return array.filter { $0 != topLeftCornerIndex && $0 != bottomLeftCornerIndex }
    }
    
    func getRightEdgeIndexes() -> [Int] {
        var array: [Int] = []
        for i in 1...rows {
            array.append((i * columns) - 1)
        }
        return array.filter { $0 != topRightCornerIndex && $0 != bottomRightCornerIndex }
    }
}
