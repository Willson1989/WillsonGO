//
//  Solution_03.swift
//  Play-with-Alorithms
//
//  Created by 朱金倩 on 2018/8/28.
//  Copyright © 2018年 ZhengYi. All rights reserved.
//

import Foundation


extension Solution {
    
    /*
     leetCode #804
     https://leetcode-cn.com/problems/unique-morse-code-words/description/
     国际摩尔斯密码定义一种标准编码方式，将每个字母对应于一个由一系列点和短线组成的字符串，
     比如: "a" 对应 ".-", "b" 对应 "-...", "c" 对应 "-.-.", 等等。
     为了方便，所有26个英文字母对应摩尔斯密码表如下：[".-","-...","-.-.","-..",".","..-.","--.","....","..",".---","-.-",".-..","--","-.","---",".--.","--.-",".-.","...","-","..-","...-",".--","-..-","-.--","--.."]
     给定一个单词列表，每个单词可以写成每个字母对应摩尔斯密码的组合。
     例如，"cab" 可以写成 "-.-.-....-"，(即 "-.-." + "-..." + ".-"字符串的结合)。我们将这样一个连接过程称作单词翻译。
     返回我们可以获得所有词不同单词翻译的数量。
     
     例如:
     输入: words = ["gin", "zen", "gig", "msg"]   输出: 2
     解释:
     各单词翻译如下:
     "gin" -> "--...-."
     "zen" -> "--...-."
     "gig" -> "--...--."
     "msg" -> "--...--."
     
     共有 2 种不同翻译, "--...-." 和 "--...--.".
     */
    func uniqueMorseRepresentations(_ words: [String]) -> Int {
        
        let morse : [String] = [".-","-...","-.-.","-..",".","..-.","--.","....",
                                "..",".---","-.-",".-..","--","-.","---",".--.","--.-",
                                ".-.","...","-","..-","...-",".--","-..-","-.--","--.."]
        let letters : [Character] = ["A","B","C","D","E","F","G","H","I","J","K","L","M",
                                     "N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
        var total = [String : Int]()
        for i in 0 ..< words.count {
            var res : String = ""
            let s = words[i].uppercased()
            for c in s {
                let index = letters.index(of: c) ?? -1
                if index < 0 {
                    return -1
                }
                res = res + morse[index]
            }
            total[res] = 1
        }
        return total.keys.count
    }

    /*
     leetCode #28
     https://leetcode-cn.com/problems/implement-strstr/description/
     实现 strStr() 函数。
     给定一个 haystack 字符串和一个 needle 字符串，在 haystack 字符串中找出 needle 字符串出现的第一个位置 (从0开始)。如果不存在，则返回  -1。
     
     示例 1:
     输入: haystack = "hello", needle = "ll"  输出: 2
     
     示例 2:
     输入: haystack = "aaaaa", needle = "bba" 输出: -1
     
     说明:
     当 needle 是空字符串时，我们应当返回什么值呢？这是一个在面试中很好的问题。
     对于本题而言，当 needle 是空字符串时我们应当返回 0 。这与C语言的 strstr() 以及 Java的 indexOf() 定义相符。
     */
    func strStr(_ haystack: String, _ needle: String) -> Int {
        
        let m = haystack.count, n = needle.count
        if n == 0 { return 0 }
        if m < n  { return -1 }
        func char(at i : Int ,in s : String) -> Character {
            return s[s.index(s.startIndex, offsetBy: i)]
        }
        for i in 0 ... m - n {
            var j = 0
            while j < n {
                if char(at: i+j, in: haystack) != char(at: j, in: needle) {
                    break
                }
                j += 1
            }
            if j == n { return i }
        }
        return -1
    }
    
    
}
