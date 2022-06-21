//
//  String+SnakeCase.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 4/1/22.
//

extension String {
    // MARK: Public Instance Interface
    
    public func logCased() -> String {
        snakeCased().uppercased()
    }
    
    public func snakeCased() -> String {
        guard !isEmpty else {
            return self
        }

        var words: [Range<String.Index>] = []
        var wordStart = startIndex
        var searchRange = index(after: wordStart) ..< endIndex

        while let upperCaseRange = rangeOfCharacter(from: .uppercaseLetters, options: [], range: searchRange) {
            let untilUpperCase = wordStart ..< upperCaseRange.lowerBound
            words.append(untilUpperCase)
            searchRange = upperCaseRange.lowerBound ..< searchRange.upperBound
            
            guard
                let lowerCaseRange = rangeOfCharacter(
                    from: .lowercaseLetters,
                    options: [],
                    range: searchRange
                )
            else {
                wordStart = searchRange.lowerBound
                break
            }

            let nextCharacterAfterCapital = index(after: upperCaseRange.lowerBound)
            
            if lowerCaseRange.lowerBound == nextCharacterAfterCapital {
                wordStart = upperCaseRange.lowerBound
            } else {
                let beforeLowerIndex = index(before: lowerCaseRange.lowerBound)
                words.append(upperCaseRange.lowerBound ..< beforeLowerIndex)
                wordStart = beforeLowerIndex
            }
            
            searchRange = lowerCaseRange.upperBound ..< searchRange.upperBound
        }
        
        words.append(wordStart ..< searchRange.upperBound)
        
        return words
            .map { self[$0].lowercased() }
            .joined(separator: "_")
    }
}
