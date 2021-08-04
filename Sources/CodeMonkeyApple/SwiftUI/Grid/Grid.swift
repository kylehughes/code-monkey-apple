//
//  Grid.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 7/19/21.
//

import SwiftUI

public struct Grid {
    public static let defaultColor: Color = .black
    public static let defaultLineWidth: CGFloat = 1
    
    private let color: Color
    private let lineWidth: CGFloat
    private let numberOfColumns: Int
    private let numberOfRows: Int
    
    // MARK: Public Initialization
    
    public init(
        _ numberOfCellsOnEachAxis: Int,
        color: Color = defaultColor,
        lineWidth: CGFloat = defaultLineWidth
    ) {
        self.init(numberOfCellsOnEachAxis, numberOfCellsOnEachAxis, color: color, lineWidth: lineWidth)
    }
    
    public init(
        _ numberOfColumns: Int,
        _ numberOfRows: Int,
        color: Color = defaultColor,
        lineWidth: CGFloat = defaultLineWidth
    ) {
        self.numberOfColumns = numberOfColumns
        self.numberOfRows = numberOfRows
        self.color = color
        self.lineWidth = lineWidth
    }
}

// MARK: - View Extension

extension Grid: View {
    // MARK: View Body
    
    public var body: some View {
        GeometryReader { geometry in
            Path { path in
                let columnWidth = geometry.size.width / CGFloat(numberOfColumns)
                let rowHeight = geometry.size.height / CGFloat(numberOfRows)
                
                for column in 0 ... numberOfColumns {
                    let offset = CGFloat(column) * columnWidth
                    path.move(to: CGPoint(x: offset, y: 0))
                    path.addLine(to: CGPoint(x: offset, y: geometry.size.height))
                }
                
                for row in 0 ... numberOfRows {
                    let offset = CGFloat(row) * rowHeight
                    path.move(to: CGPoint(x: 0, y: offset))
                    path.addLine(to: CGPoint(x: geometry.size.width, y: offset))
                }
            }
            .stroke(color, lineWidth: lineWidth)
        }
    }
}

// MARK: - Extension for View

extension View {
    // MARK: Public Instance Interace
    
    public func overlayWithGrid(
        _ numberOfCellsOnEachAxis: Int,
        color: Color = Grid.defaultColor,
        lineWidth: CGFloat = Grid.defaultLineWidth
    ) -> some View {
        overlay(Grid(numberOfCellsOnEachAxis, color: color, lineWidth: lineWidth))
    }
    
    public func overlayWithGrid(
        _ numberOfColumns: Int,
        _ numberOfRows: Int,
        color: Color = Grid.defaultColor,
        lineWidth: CGFloat = Grid.defaultLineWidth
    ) -> some View {
        overlay(Grid(numberOfColumns, numberOfRows, color: color, lineWidth: lineWidth))
    }
}
