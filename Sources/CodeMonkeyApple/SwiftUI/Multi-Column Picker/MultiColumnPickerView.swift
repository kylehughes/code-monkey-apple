//
//  MultiColumnPickerView.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 7/11/22.
//

#if canImport(UIKit) && !os(watchOS)

import Foundation
import SwiftUI
import UIKit

public struct MultiColumnPickerView<SelectionValue> {
    public typealias ValueForSelection = (Selection) -> SelectionValue
    
    private let configuration: Configuration
    private let valueForSelection: ValueForSelection
    
    @Binding private var selectionValue: SelectionValue
    
    // MARK: Public Initialization
    
    public init(
        configuration: Configuration,
        selectionValue: Binding<SelectionValue>,
        valueForSelection: @escaping ValueForSelection
    ) {
        self.configuration = configuration
        self.valueForSelection = valueForSelection
        
        _selectionValue = selectionValue
    }
}

// MARK: - UIViewRepresentable Extension

extension MultiColumnPickerView: UIViewRepresentable {
    // MARK: Creating and Updating the View
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(
            configuration: configuration,
            selectionValue: $selectionValue,
            valueForSelection: valueForSelection
        )
    }
    
    public func makeUIView(context: Context) -> UIPickerView {
        let view = UIPickerView(frame: .zero)
        view.dataSource = context.coordinator
        view.delegate = context.coordinator
        
        return view
    }
    
    public func updateUIView(_ uiView: UIPickerView, context: Context) {
        
    }
}

// MARK: - MultiColumnPickerView.Configuration Definition

extension MultiColumnPickerView {
    public struct Configuration {
        public typealias NumberOfComponents = () -> Int
        public typealias NumberOfRowsInComponent = (_ component: Int) -> Int
        public typealias TitleForRowInComponent = (_ row: Int, _ component: Int) -> String
        
        public let numberOfComponents: NumberOfComponents
        public let numberOfRowsInComponent: NumberOfRowsInComponent
        public let titleForRowInComponent: TitleForRowInComponent
        
        // MARK: Public Initialization
        
        public init(
            numberOfComponents: @autoclosure @escaping NumberOfComponents,
            numberOfRowsInComponent: @escaping NumberOfRowsInComponent,
            titleForRowInComponent: @escaping TitleForRowInComponent
        ) {
            self.numberOfComponents = numberOfComponents
            self.numberOfRowsInComponent = numberOfRowsInComponent
            self.titleForRowInComponent = titleForRowInComponent
        }
    }
}

// MARK: - MultiColumnPickerView.Coordinator Definition

extension MultiColumnPickerView {
    public final class Coordinator: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
        private let configuration: Configuration
        private let valueForSelection: ValueForSelection
        
        @Binding private var selectionValue: SelectionValue
        
        // MARK: Public Initialization
        
        public init(
            configuration: Configuration,
            selectionValue: Binding<SelectionValue>,
            valueForSelection: @escaping ValueForSelection
        ) {
            self.configuration = configuration
            self.valueForSelection = valueForSelection
            
            _selectionValue = selectionValue
        }
        
        // MARK: UIPickerViewDataSource Implementation
        
        public func numberOfComponents(in pickerView: UIPickerView) -> Int {
            configuration.numberOfComponents()
        }
        
        public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            configuration.numberOfRowsInComponent(component)
        }
        
        // MARK: UIPickerViewDelegate Implementation
        
        public func pickerView(
            _ pickerView: UIPickerView,
            titleForRow row: Int,
            forComponent component: Int
        ) -> String? {
            configuration.titleForRowInComponent(row, component)
        }
        
        public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            let selection = Selection(component: component, row: row)
            
            selectionValue = valueForSelection(selection)
        }
    }
}

// MARK: - MultiColumnPickerView.Selection Definition

extension MultiColumnPickerView {
    public struct Selection {
        public let component: Int
        public let row: Int
    }
}

#endif
