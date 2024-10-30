//
//  TileModel.swift
//  Minesweeper
//
//  Created by Mehran Ramazanilar on 2/28/1402 AP.
//

import Foundation

struct TileModel: Identifiable, Hashable {
    let id: UUID
    let board: BoardModel
    let row: Int
    let column: Int
    let index: Int
    var isOpened: Bool = false
    
    var type: TileType {
        if board.bombs.contains(index) {
            return .bomb
        } else if adjacentBombCount > 0 {
            return .number
        } else {
            return .empty
        }
    }
    
    var adjacentBombCount: Int {
        Array(Set(getNeighborPositions()).intersection(board.bombs)).count
    }
    
    var identifier: String {
        return id.uuidString
    }
    
    func getTilePosition() -> TilePosition {
        if index == board.topLeftCornerIndex {
            return .topLeftCorner
        } else if index == board.topRightCornerIndex {
            return .topRightCorner
        } else if index == board.bottomLeftCornerIndex {
            return .bottomLeftCorner
        } else if index == board.bottomRightCornerIndex {
            return .bottomRightCorner
        } else if board.getTopEdgeIndexes().contains(index) {
            return .topEdge
        } else if board.getBottomEdgeIndexes().contains(index) {
            return .bottomEdge
        } else if board.getLeftEdgeIndexes().contains(index) {
            return .leftEdge
        } else if board.getRightEdgeIndexes().contains(index) {
            return .rightEdge
        } else {
            return .center
        }
    }
    
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(identifier)
    }
    
    public static func == (lhs: TileModel, rhs: TileModel) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}

extension TileModel {
    
    func getNeighborPositions() -> [Int] {
        let position = getTilePosition()
        switch position {
        case .center:
            return centerNeighbors(toOpen: false)
        case .topEdge:
            return topEdgeNeighbors(toOpen: false)
        case .bottomEdge:
            return bottomEdgeNeighbors(toOpen: false)
        case .leftEdge:
            return leftEdgeNeighbors(toOpen: false)
        case .rightEdge:
            return rightEdgeNeighbors(toOpen: false)
        case .topLeftCorner:
            return topLeftCornerNeighbors(toOpen: false)
        case .topRightCorner:
            return topRightCornerNeighbors(toOpen: false)
        case .bottomLeftCorner:
            return bottomLeftCornerNeighbors(toOpen: false)
        case .bottomRightCorner:
            return bottomRightCornerNeighbors(toOpen: false)
        }
    }
    
    func getNeighborPositionsToOpen() -> [Int] {
        let position = getTilePosition()
        switch position {
        case .center:
            return centerNeighbors(toOpen: true)
        case .topEdge:
            return topEdgeNeighbors(toOpen: true)
        case .bottomEdge:
            return bottomEdgeNeighbors(toOpen: true)
        case .leftEdge:
            return leftEdgeNeighbors(toOpen: true)
        case .rightEdge:
            return rightEdgeNeighbors(toOpen: true)
        case .topLeftCorner:
            return topLeftCornerNeighbors(toOpen: true)
        case .topRightCorner:
            return topRightCornerNeighbors(toOpen: true)
        case .bottomLeftCorner:
            return bottomLeftCornerNeighbors(toOpen: true)
        case .bottomRightCorner:
            return bottomRightCornerNeighbors(toOpen: true)
        }
    }
    
    private func centerNeighbors(toOpen: Bool) -> [Int] {
        if toOpen == false {
            return [
                index - board.columns - 1,
                index - board.columns,
                index - board.columns + 1,
                index - 1,
                index + 1,
                index + board.columns - 1,
                index + board.columns ,
                index + board.columns + 1
            ]
        } else {
            return [
                index - board.columns,
                index - 1,
                index + 1,
                index + board.columns
            ]
        }
    }
    
    private func topEdgeNeighbors(toOpen: Bool) -> [Int] {
        if toOpen == false {
            return [
                index - 1,
                index + 1,
                index + board.columns - 1,
                index + board.columns,
                index + board.columns + 1
            ]
        } else {
            return [
                index - 1,
                index + 1,
                index + board.columns
            ]
        }
    }
    
    private func bottomEdgeNeighbors(toOpen: Bool) -> [Int] {
        if toOpen == false {
            return [
                index - board.columns - 1,
                index - board.columns,
                index - board.columns + 1,
                index - 1,
                index + 1
            ]
        } else {
            return [
                index - board.columns,
                index - 1,
                index + 1
            ]
        }
    }
    
    private func leftEdgeNeighbors(toOpen: Bool) -> [Int] {
        if toOpen == false {
            return [
                index - board.columns,
                index - board.columns + 1,
                index + 1,
                index + board.columns,
                index + board.columns + 1
            ]
        } else {
            return [
                index - board.columns,
                index + 1,
                index + board.columns
            ]
        }
    }
    
    private func rightEdgeNeighbors(toOpen: Bool) -> [Int] {
        if toOpen == false {
            return [
                index - board.columns - 1,
                index - board.columns,
                index - 1,
                index + board.columns - 1,
                index + board.columns
            ]
        } else {
            return [
                index - board.columns,
                index - 1,
                index + board.columns
            ]
        }
    }
    
    private func topLeftCornerNeighbors(toOpen: Bool) -> [Int] {
        if toOpen == false {
            return [
                index + 1,
                index + board.columns,
                index + board.columns + 1
            ]
        } else {
            return [
                index + 1,
                index + board.columns
            ]
        }
    }
    
    private func topRightCornerNeighbors(toOpen: Bool) -> [Int] {
        if toOpen == false {
            return [
                index - 1,
                index + board.columns - 1,
                index + board.columns
            ]
        } else {
            return [
                index - 1,
                index + board.columns
            ]
        }
    }
    
    private func bottomLeftCornerNeighbors(toOpen: Bool) -> [Int] {
        if toOpen == false {
            return [
                index - board.columns,
                index - board.columns + 1,
                index + 1
            ]
        } else {
            return [
                index - board.columns,
                index + 1
            ]
        }
    }
    
    private func bottomRightCornerNeighbors(toOpen: Bool) -> [Int] {
        if toOpen == false {
            return [
                index - board.columns - 1,
                index - board.columns,
                index - 1
            ]
        } else {
            return [
                index - board.columns,
                index - 1
            ]
        }
    }
    
}

enum TileType: Hashable {
    case empty
    case number
    case bomb
}

enum TilePosition: Hashable {
    case center
    case topEdge
    case bottomEdge
    case leftEdge
    case rightEdge
    case topLeftCorner
    case topRightCorner
    case bottomLeftCorner
    case bottomRightCorner
}
