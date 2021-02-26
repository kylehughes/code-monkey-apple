//
//  TimeInterval+CodeMonkeyApple.swift
//  ditherpedia-bot
//
//  Created by Kyle Hughes on 2/26/21.
//

import Foundation

extension TimeInterval {
    // MARK: Public Static Interface
    
    public static func day() -> TimeInterval {
        days(1)
    }
    
    public static func days(_ days: Double) -> TimeInterval {
        hours(24) * days
    }
    
    public static func hour() -> TimeInterval {
        hours(1)
    }
    
    public static func hours(_ hours: Double) -> TimeInterval {
        minutes(60) * hours
    }
    
    public static func minutes() -> TimeInterval {
        minutes(1)
    }
    
    public static func minutes(_ minutes: Double) -> TimeInterval {
        seconds(60) * minutes
    }
    
    public static func second() -> TimeInterval {
        seconds(1)
    }
    
    public static func seconds(_ seconds: Double) -> TimeInterval {
        seconds
    }
}

