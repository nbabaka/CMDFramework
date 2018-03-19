//
//  String + Extensions.swift
//  CinemoodApp
//
//  Created by Nikolay Karataev aka Babaka on 16/08/2017.
//  Copyright © 2017 CINEMOOD. All rights reserved.
//

import Foundation

public extension Bool {
    public init?(string: String) {
        switch string {
        case "True", "true", "yes", "1":
            self = true
        case "False", "false", "no", "0":
            self = false
        default:
            return nil
        }
    }
}

public extension String {
    public var l:String {
        get {
            return NSLocalizedString(self, tableName: "Localizable", bundle: Bundle.main, value: self, comment: self)
        }
    }
    
    public var podLocalization: String {
        get {
            let path = getBundleFilePath(bundle: "Localization")
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
        let matchCount = exp.matches(in: self, options: [], range: NSRange(location: 0, length:  self.count))
        return matchCount.count > 0
    }
    
    public func withReplacedCharacters(_ characters: String, by separator: String) -> String {
        let characterSet = CharacterSet(charactersIn: characters)
        return components(separatedBy: characterSet).joined(separator: separator)
    }
    
    public func isValidEmail() -> Bool {
        let regex = try? NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}", options: .caseInsensitive)
        return regex?.firstMatch(in: self, options: [], range: NSMakeRange(0, self.count)) != nil
    }
    
    public func isValidPhone() -> Bool {
        let regex = try? NSRegularExpression(pattern: "^\\+[0-9]+$", options: .caseInsensitive)
        return regex?.firstMatch(in: self, options: [], range: NSMakeRange(0, self.count)) != nil
    }
    
    public static func random(length: Int = 32) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let randomLength = UInt32(letters.count)
        
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
            (0..<result.numberOfRanges).map { result.range(at: $0).location != NSNotFound
                ? nsString.substring(with: result.range(at: $0))
                : ""
            }
        }
    }
    
    public func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }
    
    public func insert(string: String, index: Int) -> String {
        return  String(self.prefix(index)) + string + String(self.suffix(self.count-index))
    }
    
    public func intIndex(_ index: Index) -> Int {
        return distance(from: startIndex, to: index)
    }

}


public extension Character {
    public func isMatchWithCharacters(_ characters: String) -> Bool {
        var flag = false
        characters.forEach {
            if $0 == self {
                flag = true
            }
        }
        return flag
    }
}
