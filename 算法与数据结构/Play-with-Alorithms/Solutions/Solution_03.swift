//
//  Solution_03.swift
//  Play-with-Alorithms
//
//  Created by 朱金倩 on 2018/8/28.
//  Copyright © 2018年 ZhengYi. All rights reserved.
//

import Foundation


extension Solution {
    
    // MARK: -------------- leetCode #804
    /*
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

    // MARK: -------------- leetCode #28
    /*
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
    
    // MARK: -------------- leetCode #21
    /*
     https://leetcode-cn.com/problems/merge-two-sorted-lists/
     将两个有序链表合并为一个新的有序链表并返回。新链表是通过拼接给定的两个链表的所有节点组成的。
     输入：1->2->4, 1->3->4
     输出：1->1->2->3->4->4
     */
    func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        var l1 = l1, l2 = l2
        var dummy : ListNode? = ListNode(0)
        let newHeader = dummy
        while l1 != nil && l2 != nil {
            if l1!.val > l2!.val {
                dummy?.next = l2
                l2 = l2!.next
            } else {
                dummy?.next = l1
                l1 = l1!.next
            }
            dummy = dummy?.next
        }
        while l2 != nil {
            dummy?.next = l2
            dummy = dummy?.next
            l2 = l2!.next
        }
        while l1 != nil {
            dummy?.next = l1
            dummy = dummy?.next
            l1 = l1!.next
        }
        return newHeader?.next
    }
    
    // MARK: -------------- leetCode #784
    /*
     https://leetcode-cn.com/problems/letter-case-permutation/
     给定一个字符串S，通过将字符串S中的每个字母转变大小写，我们可以获得一个新的字符串。返回所有可能得到的字符串集合。
     示例:
     输入: S = "a1b2"
     输出: ["a1b2", "a1B2", "A1b2", "A1B2"]
     
     输入: S = "3z4"
     输出: ["3z4", "3Z4"]
     
     输入: S = "12345"
     输出: ["12345"]
     
     注意：
     S 的长度不超过12。
     S 仅由数字和字母组成。
     */
    func letterCasePermutation_1(_ S: String) -> [String] {
        func isNum( _ s : String) -> Bool {
            let scan = Scanner(string: s)
            var val : Int = 0
            return scan.scanInt(&val) && scan.isAtEnd
        }
        func char(at i : Int, _ s : String) -> String {
            return String(s[s.index(s.startIndex, offsetBy: i)])
        }
        var source : [String] = []
        for i in 0 ..< S.count {
            source.append(char(at: i, S))
        }
        var res = [String]()
        let n = S.count
        func backTrace(t : Int, src : [String], s :  String) {
            if t >= n {
                res.append(s)
            } else {
                if isNum(source[t]) {
                    backTrace(t: t+1, src: source, s: s+source[t])
                    return
                }
                for i in 0 ... 1 {
                    if i == 0 { //小写
                        backTrace(t: t+1, src: source, s: s+source[t].lowercased())
                        
                    } else { // i == 1 大写
                        backTrace(t: t+1, src: source, s: s+source[t].uppercased())
                    }
                }
            }
        }
        backTrace(t: 0, src: source, s: "")
        return res
    }
    
    func letterCasePermutation_2(_ S: String) -> [String] {
        
        func isChar(_ c : String) -> Bool {
            return (c >= "a" && c <= "z") || (c >= "A" && c <= "Z")
        }
        func char(at i : Int, _ s : String) -> String {
            return String(s[s.index(s.startIndex, offsetBy: i)])
        }
        func rmChar(at i : Int, s : String) -> String {
            var s = s
            if i < 0 || i >= s.count { return s }
            let range = s.index(s.startIndex, offsetBy: i) ... s.index(s.startIndex, offsetBy: i)
            s.replaceSubrange(range, with: "")
            return s
        }
        
        var source : [String] = []
        for i in 0 ..< S.count {
            source.append(char(at: i, S))
        }
        
        var res = [String]()
        let n = source.count
        func backTrace(t : Int, s : String , src : [String]) {
            var s = s
            if t >= n {
                res.append(s)
                return
            }
            if isChar(src[t]) {
                //解空间左子树
                s += src[t].uppercased()
                backTrace(t: t+1, s: s, src: src)
                s = rmChar(at: s.count-1, s: s)  //回溯
                
                //解空间右子树
                s += src[t].lowercased()
                backTrace(t: t+1, s: s, src: src)
                s = rmChar(at: s.count-1, s: s)  //回溯
                
            } else {
                //不是字母则直接添加
                s += src[t]
                backTrace(t: t+1, s: s, src: src)
            }
        }
        backTrace(t: 0, s: "", src: source)
        return res
    }
    
    // MARK: -------------- leetCode #401
    /*
     https://leetcode-cn.com/problems/binary-watch/
     二进制手表顶部有 4 个 LED 代表小时（0-11），底部的 6 个 LED 代表分钟（0-59）。
     (hour : 1, 2, 4, 8    min : 1, 2, 4, 8, 16, 32)
     每个 LED 代表一个 0 或 1，最低位在右侧。
     给定一个非负整数 n 代表当前 LED 亮着的数量，返回所有可能的时间。
     
     案例:
     输入: n = 1
     返回: ["1:00", "2:00", "4:00", "8:00", "0:01", "0:02", "0:04", "0:08", "0:16", "0:32"]

     注意事项:
     输出的顺序没有要求。
     小时不会以零开头，比如 “01:00” 是不允许的，应为 “1:00”。
     分钟必须由两位数组成，可能会以零开头，比如 “10:2” 是无效的，应为 “10:02”。
     
     参考：
     https://blog.csdn.net/camellhf/article/details/52738031
     https://blog.csdn.net/whl_program/article/details/71155498
     */
    //回溯法
    func readBinaryWatch(_ num: Int) -> [String] {
        var res : [String] = []
        let hours : [Int] = [1,2,4,8]
        let mins  : [Int] = [1,2,4,8,16,32]
        let count = hours.count + mins.count
        typealias Time = (totalHours : Int, totalMins : Int)
        let t : Time = (0, 0)
        
        //回溯函数
        func helper(time : Time, num : Int, startIndex : Int) {
            var time = time
            if num == 0 {
                if time.totalMins < 10 {
                    res.append("\(time.totalHours):0\(time.totalMins)")
                } else {
                    res.append("\(time.totalHours):\(time.totalMins)")
                }
                return
            }
            
            for i in startIndex ..< count {
                if i < hours.count {
                    time.totalHours += hours[i]
                    if time.totalHours < 12 {
                        helper(time: time, num: num - 1, startIndex : i + 1)
                    }
                    time.totalHours -= hours[i]
                
                } else {
                    let idx = i - hours.count
                    time.totalMins += mins[idx]
                    if time.totalMins < 60 {
                        helper(time: time, num: num - 1, startIndex : i + 1)
                    }
                    time.totalMins -= mins[idx]
                }
            }
        }
        //入口
        helper(time: (0,0), num: num, startIndex : 0)
        
        return res
    }
    
    
    // MARK: -------------- leetCode #383
    /*
     https://leetcode-cn.com/problems/ransom-note/
     给定一个赎金信 (ransom) 字符串和一个杂志(magazine)字符串，
     判断第一个字符串ransom能不能由第二个字符串magazines里面的字符构成。
     如果可以构成，返回 true ；否则返回 false。
     
     (题目说明：为了不暴露赎金信字迹，要从杂志上搜索各个需要的字母，组成单词来表达意思。杂志上面的字母个数要够用，用一个少一个)
     你可以假设两个字符串均只含有小写字母。
     canConstruct("a", "b") -> false
     canConstruct("aa", "ab") -> false
     canConstruct("aa", "aab") -> true
     
     参考：
     http://www.cnblogs.com/strengthen/p/9775114.html
     */
    func canConstruct1(_ ransomNote: String, _ magazine: String) -> Bool {
        func char(at i : Int, _ s : String) -> Character {
            return s[s.index(s.startIndex, offsetBy: i)]
        }
        
        func charIndex(_ c : Character) -> Int {
            if c >= "a" && c <= "z" {
                return getASCII(c) - getASCII("a")
            } else if c >= "A" && c <= "Z" {
                return getASCII(c) - getASCII("A") + 26
            } else {
                return -1
            }
        }
        
        func getASCII(_ c : Character) -> Int {
            var num = 0
            for scalar in String(c).unicodeScalars {
                num = Int(scalar.value)
            }
            return num
        }
        
        /*
         构建一个针对每一个字母出现个数的字符表，由于区分大小写，所以表里面有52个元素
         */
        func charCountTable(_ s : String) -> [Int] {
            var res : [Int] = Array(repeating: 0, count: 52)
            for i in 0 ..< s.count {
                let c = char(at: i, s)
                let index = charIndex(c)
                if index >= 0 && index < res.count {
                    res[index] += 1
                }
            }
            return res
        }
        
        /*
         针对杂志出现的字母构建字母个数表
         ransomNote出现一个字母，字母表改字母对应位置的元素中就减去1，如果该元素小于0
         则说明字母个数不够用，返回false
         */
        var magazineTable = charCountTable(magazine)
        for i in 0 ..< ransomNote.count {
            let c = char(at: i, ransomNote)
            let index = charIndex(c)
            if index < 0 {
                continue
            }
            magazineTable[index] -= 1
            if magazineTable[index] < 0 {
                return false
            }
        }
        return true
    }
    
    /*
     1.优化版，使用了for in 通过String的indices来遍历每一个字符
     2.由于只存在小写字符，所以直接减去97即可不需要再通过api获取a的ASCII码
     */
    func canConstruct(_ ransomNote: String, _ magazine: String) -> Bool {
        var tb = Array(repeating: 0, count: 26)
        for index in magazine.indices {
            let char : Character = magazine[index]
            for asc in char.unicodeScalars {
                let num = Int(asc.value - 97)
                tb[num] += 1
            }
        }
        for index in ransomNote.indices {
            let char : Character = ransomNote[index]
            for asc in char.unicodeScalars {
                let num = Int(asc.value - 97)
                tb[num] -= 1
                if tb[num] < 0 {
                    return false
                }
            }
        }
        return true
    }
    
    // MARK: -------------- leetCode #492
    /*
     https://leetcode-cn.com/problems/construct-the-rectangle/
     现给定一个具体的矩形页面面积，你的任务是设计一个长度为 L 和宽度为 W 且满足以下要求的矩形的页面。要求：
     1. 你设计的矩形页面必须等于给定的目标面积。
     2. 宽度 W 不应大于长度 L，换言之，要求 L >= W 。
     3. 长度 L 和宽度 W 之间的差距应当尽可能小。
     
     你需要按顺序输出你设计的页面的长度 L 和宽度 W。
     示例：
     输入: 4   输出: [2, 2]
     解释: 目标面积是 4， 所有可能的构造方案有 [1,4], [2,2], [4,1]。
     但是根据要求2，[1,4] 不符合要求; 根据要求3，[2,2] 比 [4,1] 更能符合要求.
     所以输出长度 L 为 2， 宽度 W 为 2。
     
     说明:
     给定的面积不大于 10,000,000 且为正整数。
     你设计的页面的长度和宽度必须都是正整数。
     参考：
     */
    func constructRectangle1(_ area: Int) -> [Int] {
        if area <= 0 {
            return [0, 0]
        }
        if area < 3 {
            return [area, 1]
        }
        if area == 4 {
            return [2, 2]
        }
        var res = [Int]()
        var minSub = area
        for i in 1 ... area/3 {
            let a = area % i
            let b = area / i
            if a == 0 && abs(i-b) < minSub{
                minSub = abs(i-b)
                if i < b {
                    res = [b, i]
                } else {
                    res = [i, b]
                }
            }
        }
        return res
    }

    /*
     优化之后，执行效率大大提高，上一个方法大概1300ms，优化之后达到大概12ms
     只需要从area的平方根转为Int的值开始到0遍历即可
     离平方根越近的两个值之间的差最小
     */
    func constructRectangle(_ area: Int) -> [Int] {
        var res = [Int]()
        for i in stride(from: Int(sqrt(Double(area))), to: 0, by: -1) {
            if area % i == 0 {
                res = [area/i, i]
                break
            }
        }
        return res
    }
}
