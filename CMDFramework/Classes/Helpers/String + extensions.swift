//
//  String + Extensions.swift
//  CinemoodApp
//
//  Created by Nikolay Karataev aka Babaka on 16/08/2017.
//  Copyright © 2017 CINEMOOD. All rights reserved.
//

import Foundation

public extension String {
    public var l:String {
        get {
            return NSLocalizedString(self, tableName: "Localizable", bundle: Bundle.main, value: self, comment: self)
        }
    }
    
    public var podLocalization: String {
        get {
            let path = Bundle(for: BaseView.self).path(forResource: "Localization", ofType: "bundle")
            let bundle = Bundle(path: path!) ?? Bundle.main
            return NSLocalizedString(self, bundle: bundle, comment: self)
        }
    }
    
    public func containsOnlyCharactersIn(matchCharacters: String) -> Bool {
        let disallowedCharacterSet = NSCharacterSet(charactersIn: matchCharacters).inverted
        return self.rangeOfCharacter(from: disallowedCharacterSet) == nil
    }
    
    public var trim:String {
        get {
            return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    
    public func isMatch(regex: String, options: NSRegularExpression.Options) -> Bool {
        let exp = try! NSRegularExpression(pattern: regex, options: options)
        let matchCount = exp.matches(in: self, options: [], range: NSRange(location: 0, length:  self.characters.count))
        return matchCount.count > 0
    }
    
    public func withReplacedCharacters(_ characters: String, by separator: String) -> String {
        let characterSet = CharacterSet(charactersIn: characters)
        return components(separatedBy: characterSet).joined(separator: separator)
    }
    
    public func isValidEmail() -> Bool {
        let regex = try? NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}", options: .caseInsensitive)
        return regex?.firstMatch(in: self, options: [], range: NSMakeRange(0, self.characters.count)) != nil
    }
    
    public func isValidPhone() -> Bool {
        let regex = try? NSRegularExpression(pattern: "^\\+[0-9]+$", options: .caseInsensitive)
        return regex?.firstMatch(in: self, options: [], range: NSMakeRange(0, self.characters.count)) != nil
    }
    
    public static func random(length: Int = 32) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let randomLength = UInt32(letters.characters.count)
        
        let randomString: String = (0 ..< length).reduce(String()) { accum, _ in
            let randomOffset = arc4random_uniform(randomLength)
            let randomIndex = letters.index(letters.startIndex, offsetBy: Int(randomOffset))
            return accum.appending(String(letters[randomIndex]))
        }
        
        return randomString
    }
    
    public func matchingStrings(regex: String) -> [[String]] {
        guard let regex = try? NSRegularExpression(pattern: regex, options: []) else { return [] }
        let nsString = self as NSString
        let results  = regex.matches(in: self, options: [], range: NSMakeRange(0, nsString.length))
        return results.map { result in
            (0..<result.numberOfRanges).map { result.rangeAt($0).location != NSNotFound
                ? nsString.substring(with: result.rangeAt($0))
                : ""
            }
        }
    }
    
    public func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }
    
    public func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return substring(from: fromIndex)
    }
    
    public func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return substring(to: toIndex)
    }
    
    public func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return substring(with: startIndex..<endIndex)
    }
    
    public func insert(string: String, index: Int) -> String {
        return  String(self.characters.prefix(index)) + string + String(self.characters.suffix(self.characters.count-index))
    }
    
    public func intIndex(_ index: Index) -> Int {
        return distance(from: startIndex, to: index)
    }

}


public extension Character {
    public func isMatchWithCharacters(_ characters: String) -> Bool {
        var flag = false
        characters.characters.forEach {
            if $0 == self {
                flag = true
            }
        }
        return flag
    }
}
