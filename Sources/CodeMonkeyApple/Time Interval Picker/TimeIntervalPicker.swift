//
//  TimeIntervalPicker.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 4/18/22.
//

import SwiftUI

public struct TimeIntervalPicker {
    @Binding public var duration: TimeInterval
    
    // MARK: Public Initialization
    
    public init(duration: Binding<TimeInterval>) {
        _duration = duration
    }
}

// MARK: - UIViewRepresentable Extension

extension TimeIntervalPicker: UIViewRepresentable {
    // MARK: Public Typealiases
    
    public typealias UIViewType = UIDatePickerScreen-Scale-Dependent Value
    
    // MARK: Creating and Updating the View
    
    public func makeCoordinator() -> TimeIntervalPicker.Coordinator {
        Coordinator(duration: $duration)
    }
    
    public func makeUIView(context: Context) -> UIDatePicker {
        let timeDurationPicker = UIDatePicker()
        timeDurationPicker.datePickerMode = .countDownTimer
        timeDurationPicker.addTarget(context.coordinator, action: #selector(Coordinator.changed(_:)), for: .valueChanged)
        return timeDurationPicker
    }
    
    public func updateUIView(_ uiView: UIDatePicker, context: Context) {
        uiView.countDownDuration = duration
    }
}

#if DEBUG
// MARK: - Previews

struct TimeIntervalPicker_Previews: PreviewProvider {
    // MARK: Public Static Interface
    
    public static var previews: some View {
        TimeIntervalPicker(duration: .constant(.hours(2)))
    }
}
#endif

// MARK: TimeIntervalPicker.Coordinator Extension

extension TimeIntervalPicker {
    public class Coordinator: NSObject {
        private var duration: Binding<TimeInterval>
        
        // MARK: Public Initialization

        public init(duration: Binding<TimeInterval>) {
            self.duration = duration
        }
        
        // MARK: Public Instance Interface

        @objc public func changed(_ sender: UIDatePicker) {
            self.duration.wrappedValue = sender.countDownDuration
        }
    }
}
