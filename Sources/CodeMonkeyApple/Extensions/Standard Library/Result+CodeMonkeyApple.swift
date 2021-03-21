//
//  Result+CodeMonkeyApple.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 3/21/21.
//

extension Result where Success == Void {
    // MARK: Public Static Interface
    
    public static var success: Self {
        .success(())
    }
}
