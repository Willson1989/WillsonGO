//
//  StringExtension.swift
//  Play-with-Alorithms
//
//  Created by 郑毅 on 2019/2/22.
//  Copyright © 2019 ZhengYi. All rights reserved.
//

import Foundation

extension String {
    // 获取子字符串
    func substringInRange(_ r: Range<Int>) -> String? {
        if r.lowerBound < 0 || r.upperBound > count {
            return nil
        }
        let startIndex = index(self.startIndex, offsetBy: r.lowerBound)
        let endIndex = index(self.startIndex, offsetBy: r.upperBound)
        return String(self[startIndex ..< endIndex])
    }

    func charAt(_ i: Int) -> Character {
        return self[String.Index(encodedOffset: i)]
    }

    public subscript(x: Int) -> Character {
        return charAt(x)
    }

    public func replaced(from: Int, to: Int, with: String) -> String {
        guard from <= to, from >= 0, to <= count - 1 else {
            return self
        }
        var s = self
        let rang = index(startIndex, offsetBy: from) ..< index(startIndex, offsetBy: to)
        s.replaceSubrange(rang, with: "X")
        return s
    }
}

extension Character {
    var isChar: Bool {
        return (self >= "a" && self <= "z") || (self >= "A" && self <= "Z")
    }

    var isNum: Bool {
        let scanner = Scanner(string: String(self))
        var val: Int = 0
        return scanner.scanInt(&val) && scanner.isAtEnd
    }

    var isBracket: Bool {
        return self == "[" || self == "]"
    }

    var ASCII: Int {
        var num = 0
        for scalar in String(self).unicodeScalars {
            num = Int(scalar.value)
        }
        return num
    }

    var isUpper: Bool {
        let a = ASCII
        return a >= 65 && a <= 90
    }

    var isLower: Bool {
        let a = ASCII
        return a >= 97 && a <= 122
    }
}
