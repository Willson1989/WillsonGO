//
//  Solution_04.swift
//  Play-with-Alorithms
//
//  Created by 郑毅 on 2019/2/7.
//  Copyright © 2019 ZhengYi. All rights reserved.
//

import Foundation

class Solution_04 {
    // MARK: - ------------- 单词模式 leetCode #290

    /*
     https://leetcode-cn.com/problems/word-pattern/
     给定一种 pattern(模式) 和一个字符串 str ，判断 str 是否遵循相同的模式。
     这里的遵循指完全匹配，例如， pattern 里的每个字母和字符串 str 中的每个非空单词之间存在着双向连接的对应模式。

     示例1:
     输入: pattern = "abba", str = "dog cat cat dog"   输出: true

     示例 2:
     输入:pattern = "abba", str = "dog cat cat fish"  输出: false

     示例 3:
     输入: pattern = "aaaa", str = "dog cat cat dog"  输出: false

     示例 4:
     输入: pattern = "abba", str = "dog dog dog dog"  输出: false

     ** 你可以假设 pattern 只包含小写字母， str 包含了由单个空格分隔的小写字母。
     */

    /*
     这里使用了两个字典:
     其中map字典用来生成pattern中每个字符和str中每个字符串的映射关系
     hasMapped字典则是用来标识已经和pattern产生映射的子字符串
     */
    func wordPattern(_ pattern: String, _ str: String) -> Bool {
        let words = str.components(separatedBy: " ")
        if words.count != pattern.count {
            return false
        }
        var map = [Character: String]()
        var hasMapped = [String: Bool]()
        for index in pattern.indices {
            let i = index.encodedOffset
            let key = pattern[index]
            let word = words[i]
            if !map.keys.contains(key) {
                if hasMapped.keys.contains(word) {
                    return false
                }
                map[key] = word
                hasMapped[word] = true
            } else {
                if let mapWord = map[key], mapWord != word {
                    return false
                }
            }
        }
        return true
    }

    // MARK: - ------------- 同构字符串 leetCode #205

    /*
     https://leetcode-cn.com/problems/isomorphic-strings/
     给定两个字符串 s 和 t，判断它们是否是同构的。
     如果 s 中的字符可以被替换得到 t ，那么这两个字符串是同构的。
     所有出现的字符都必须用另一个字符替换，同时保留字符的顺序。两个字符不能映射到同一个字符上，但字符可以映射自己本身。

     示例 1:
     输入: s = "egg", t = "add"  输出: true

     示例 2:
     输入: s = "foo", t = "bar"  输出: false

     示例 3:
     输入: s = "paper", t = "title"  输出: true

     说明:
     你可以假设 s 和 t 具有相同的长度
     */
    /*
     可以使用字典 dict 来记住这些字符对是一个很方便的做法。在这里面我用了两个字典 dict，
     一个字典 hasMapped 用来记 s 的字符到 t 的映射，另一个字典 map 用来记录 t 的字符到 s 的映射，
     用于判断 t 中的两个字符不能由 s 中同一个字符映射而来。
     */
    func isIsomorphic(_ s: String, _ t: String) -> Bool {
        // 思路同 leetCode #290（单词模式）
        if s.count != t.count {
            return false
        }
        var map = [Character: Character]()
        var hasMapped = [Character: Bool]()
        for index in s.indices {
            if !map.keys.contains(s[index]) {
                if hasMapped.keys.contains(t[index]) {
                    return false
                }
                map[s[index]] = t[index]
                hasMapped[t[index]] = true
            } else {
                if let mappedChar = map[s[index]], mappedChar != t[index] {
                    return false
                }
            }
        }
        return true
    }

    // MARK: - ------------- 根据字符出现频率排序 leetCode #451

    /*
     https://leetcode-cn.com/problems/sort-characters-by-frequency/
     给定一个字符串，请将字符串里的字符按照出现的频率降序排列。

     示例 1:
     输入:  "tree"   输出: "eert"
     解释:
     'e'出现两次，'r'和't'都只出现一次。 因此'e'必须出现在'r'和't'之前。此外，"eetr"也是一个有效的答案。

     示例 2:
     输入: "cccaaa"  输出: "cccaaa"
     解释:
     'c'和'a'都出现三次。此外，"aaaccc"也是有效的答案。 注意"cacaca"是不正确的，因为相同的字母必须放在一起。

     示例 3:
     输入: "Aabb" 输出: "bbAa"
     解释:
     此外，"bbaA"也是一个有效的答案，但"Aabb"是不正确的。 注意'A'和'a'被认为是两种不同的字符。
     */
    func frequencySort(_ s: String) -> String {
        typealias GreaterType = (_ c1: Character, _ c2: Character) -> Int
        typealias PartitinoType = (lt: Int, gt: Int)

        func quickSort(_ arr: inout [Character], greater: GreaterType) {
            func __quickSort(_ arr: inout [Character], l: Int, r: Int, greater: GreaterType) {
                if l >= r {
                    return
                }
                let p = __partition(&arr, l: l, r: r, greater: greater)
                __quickSort(&arr, l: l, r: p.lt - 1, greater: greater)
                __quickSort(&arr, l: p.gt, r: r, greater: greater)
            }

            func __partition(_ arr: inout [Character], l: Int, r: Int, greater: GreaterType) -> PartitinoType {
                let randomIdx = Int(arc4random() % UInt32(r - l + 1) + UInt32(l))
                swapElement(&arr, l, randomIdx)

                let v = arr[l]
                var lt = l
                var gt = r + 1
                var i = lt

                while i < gt {
                    let condition = greater(arr[i], v)
                    if condition == 0 {
                        swapElement(&arr, i, lt + 1)
                        lt += 1
                        i += 1
                    } else if condition == 1 {
                        swapElement(&arr, gt - 1, i)
                        gt -= 1
                    } else {
                        i += 1
                    }
                }
                swapElement(&arr, lt, l)
                return (lt, gt)
            }

            func swapElement<T>(_ arr: inout [T], _ posx: Int, _ posy: Int) {
                if posx >= arr.count ||
                    posy >= arr.count ||
                    posx < 0 ||
                    posy < 0 ||
                    arr.count <= 0 ||
                    posx == posy {
                    return
                }
                arr.swapAt(posx, posy)
            }
            __quickSort(&arr, l: 0, r: arr.count - 1, greater: greater)
        }

        var map = [Character: Int]()
        var chars = [Character]()
        for index in s.indices {
            let c = s[index]
            if let count = map[c] {
                map[c] = count + 1
            } else {
                map[c] = 1
            }
            if !chars.contains(c) {
                chars.append(c)
            }
        }

        quickSort(&chars) { (c1, c2) -> Int in
            let count1 = map[c1] ?? 0
            let count2 = map[c2] ?? 0
            if count1 > count2 {
                return 0
            } else if count1 < count2 {
                return 1
            } else {
                return 2
            }
        }

        var res = ""
        for c in chars {
            let count = map[c] ?? 0
            for _ in 0 ..< count {
                res += String(c)
            }
        }
        return res
    }

    // MARK: - ------------- 两数之和 leetCode #1

    /*
     https://leetcode-cn.com/problems/two-sum/description/
     给定一个整数数组和一个目标值，找出数组中和为目标值的两个数。
     你可以假设每个输入只对应一种答案，且同样的元素不能被重复利用。

     示例:
     给定 nums = [2, 7, 11, 15], target = 9
     因为 nums[0] + nums[1] = 2 + 7 = 9
     所以返回 [0, 1]
     */
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        var dic = [Int: Int?]()
        for i in 0 ..< nums.count {
            if let idx = dic[target - nums[i]] {
                return [idx!, i]
            } else {
                dic[nums[i]] = i
            }
        }
        return []
    }

    // MARK: - ------------- 三数之和 leetCode #451

    /*
     https://leetcode-cn.com/problems/3sum/
     给定一个包含 n 个整数的数组 nums，判断 nums 中是否存在三个元素 a，b，c ，使得 a + b + c = 0 ？找出所有满足条件且不重复的三元组。
     注意：答案中不可以包含重复的三元组。
     例如, 给定数组 nums = [-1, 0, 1, 2, -1, -4]，

     满足要求的三元组集合为：
     [
        [-1, 0, 1],
        [-1, -1, 2]
     ]
     参考： https://www.jianshu.com/p/69b0a1170f96

     先对数组有小到大排序，然后遍历数组中的元素。由于是三数之和为0，那么只需要遍历到的元素为小于等于0就可以。
     假设当前遍历的元素索引为i。采用双索引指针的方式（j 和 k）分别指向i之后的第一个元素和数组的最后一个元素。
     假设 target = sum - arr[i],在 j < k 的条件下，如果arr[j] + arr[k] > target, 则需要小一些的数，
     此时k向左移动一位（k--）、反之如果大于target，则需要大一些的数，此时j向右移动一位（j++）
     直到找到 arr[j] + arr[k] == target的两个数。由于三元组不能重复，那么只需要把相同的元素过滤掉：往左或者往右走一位
     看是否和上一个数字相等，如果相等，则过滤掉。
        while j < k && MutNums[j] == MutNums[j+1] {
            j = j + 1
        }
     */
    func threeSum(_ nums: [Int]) -> [[Int]] {
        if nums.count < 3 {
            return []
        }
        return __threeSum(nums, targetNum: 0)
    }

    private func __threeSum(_ nums: [Int], targetNum: Int) -> [[Int]] {
        var res = [[Int]]()
        var itemNums = [Int]()

        // 先排序
        var nums = nums.sorted { (n1, n2) -> Bool in
            n1 < n2
        }

        // 遍历排序后的数组
        for i in 0 ..< nums.count {
            // 如果当前数字大于 targetNum，则不会有和为 targetNum 的组合，直接返回空
            if nums[i] > targetNum {
                break
            }
            // 过滤相同元素
            if i > 0 && nums[i] == nums[i - 1] {
                continue
            }
            var j = i + 1
            var k = nums.count - 1
            let target = targetNum - nums[i]

            while j < k {
                if nums[j] + nums[k] == target {
                    itemNums.append(nums[i])
                    itemNums.append(nums[j])
                    itemNums.append(nums[k])
                    res.append(itemNums)
                    itemNums.removeAll()

                    // 判断 j 下一个元素是否是相同的元素，如果相同则跳过
                    while j < k && nums[j] == nums[j + 1] {
                        j += 1
                    }

                    // 判断 k 前一个元素是否是相同的元素，如果相同则跳过
                    while j < k && nums[k] == nums[k - 1] {
                        k -= 1
                    }

                    // j 和 k 的下一个要遍历的元素与其当前位置的元素不相等，则两者向中间靠拢
                    j += 1
                    k -= 1

                } else if nums[j] + nums[k] < target {
                    // j 和 k 元素之和小于target，此时 j += 1，获取更大一些的数字
                    j += 1

                } else {
                    // nums[j] + nums[k] > target
                    // j 和 k 元素之和小于target，此时 k -= 1，获取更小一些的数字
                    k -= 1
                }
            }
        }
        return res
    }

    // MARK: - ------------- 四数之和 leetCode #18

    /*
     https://leetcode-cn.com/problems/4sum/submissions/
     给定一个包含 n 个整数的数组 nums 和一个目标值 target，判断 nums 中是否存在四个元素 a，b，c 和 d ，
     使得 a + b + c + d 的值与 target 相等？找出所有满足条件且不重复的四元组。

     注意：
     答案中不可以包含重复的四元组。

     示例：
     给定数组 nums = [1, 0, -1, 0, -2, 2]，和 target = 0。
     满足要求的四元组集合为：
     [
        [-1,  0, 0, 1],
        [-2, -1, 1, 2],
        [-2,  0, 0, 2]
     ]
     参考： https://blog.csdn.net/hit1110310422/article/details/80934545
     相当于在三数之和的基础上再加一层循环
     */
    func fourSum(_ nums: [Int], _ target: Int) -> [[Int]] {
        if nums.count < 4 {
            return []
        }
        let nums = nums.sorted { (a, b) -> Bool in
            a < b
        }

        var res = [[Int]]()
        var items_four = [Int]()

        for i in 0 ..< nums.count {
            if i > 0 && nums[i] == nums[i - 1] {
                // duplicate
                continue
            }

            // three sum
            for j in i + 1 ..< nums.count {
                if j > i + 1 && nums[j] == nums[j - 1] {
                    // duplicate
                    continue
                }
                var k = j + 1
                var z = nums.count - 1
                let subTarget = target - nums[i] - nums[j]

                while k < z {
                    if nums[k] + nums[z] == subTarget {
                        items_four.append(nums[i])
                        items_four.append(nums[j])
                        items_four.append(nums[k])
                        items_four.append(nums[z])
                        res.append(items_four)
                        items_four.removeAll()

                        while k < z && nums[k] == nums[k + 1] {
                            k += 1
                        }

                        while k < z && nums[z] == nums[z - 1] {
                            z -= 1
                        }

                        k += 1
                        z -= 1

                    } else if nums[k] + nums[z] > subTarget {
                        z -= 1
                    } else {
                        // nums[k] + nums[z] < subTarget
                        k += 1
                    }
                }
            }
        }
        return res
    }

    // MARK: - ------------- 四数相加 II leetCode #454

    /*
     https://leetcode-cn.com/problems/4sum-ii/
     给定四个包含整数的数组列表 A , B , C , D ,计算有多少个元组 (i, j, k, l) ，使得 A[i] + B[j] + C[k] + D[l] = 0。
     为了使问题简单化，所有的 A, B, C, D 具有相同的长度 N，且 0 ≤ N ≤ 500 。所有整数的范围在 -228 到 228 - 1 之间，
     最终结果不会超过 231 - 1 。

     例如:
     输入:
     A = [ 1, 2]
     B = [-2,-1]
     C = [-1, 2]
     D = [ 0, 2]

     输出:
     2

     解释:
     两个元组如下:
     1. (0, 0, 0, 1) -> A[0] + B[0] + C[0] + D[1] = 1 + (-2) + (-1) + 2 = 0
     2. (1, 1, 0, 0) -> A[1] + B[1] + C[0] + D[0] = 2 + (-1) + (-1) + 0 = 0

     解法：
     合理合理运用查找表的键值，首先遍历A、B两个数组，将两个数组中所有元素搭配求和之后的值作为键值存储到 map 中，value值为次数。
     再遍历C、D两个数组，将0减去C中某一个元素和D中某一个元素相加的和（0 - (C[i] + D[j])）作为key到map中查找，如果找到了就代表之前
     遍历A和B时有两个元素之和再加上C、D两数之和正好为0。
     */
    func fourSumCount(_ A: [Int], _ B: [Int], _ C: [Int], _ D: [Int]) -> Int {
        var map = [Int: Int]()
        for i in 0 ..< A.count {
            for j in 0 ..< B.count {
                let key = A[i] + B[j]
                if let count = map[key] {
                    map[key] = count + 1
                } else {
                    map[key] = 1
                }
            }
        }

        var res = 0
        for i in 0 ..< C.count {
            for j in 0 ..< D.count {
                let key = 0 - (C[i] + D[j]) // A + B
                if let count = map[key] {
                    res += count
                }
            }
        }
        return res
    }

    // MARK: - ------------- 字母异位词分组 leetCode #49

    /*
     https://leetcode-cn.com/problems/group-anagrams/
     给定一个字符串数组，将字母异位词组合在一起。字母异位词指字母相同，但排列不同的字符串。

     示例:

     输入: ["eat", "tea", "tan", "ate", "nat", "bat"],
     输出:
     [
     ["ate","eat","tea"],
     ["nat","tan"],
     ["bat"]
     ]
     说明：

     所有输入均为小写字母。
     不考虑答案输出的顺序。

     解法：
     遍历数组，将每一个单词按字符排序之后作为key存入字典中，字典的value对应的是一个set
     */
    func groupAnagrams(_ strs: [String]) -> [[String]] {
        func sort(_ s: String) -> String {
            return String(s.sorted())
        }
        var map = [String: [String]]()
        for str in strs {
            let key = sort(str)
            if var arr = map[key] {
                arr.append(str)
                map[key] = arr
            } else {
                var arr = [String]()
                arr.append(str)
                map[key] = arr
            }
        }
        var res = [[String]]()
        for (_, strs) in map {
            res.append(strs)
        }
        return res
    }

    // MARK: - ------------- 回旋镖的数量 leetCode #447

    /*
     https://leetcode-cn.com/problems/number-of-boomerangs/submissions/
     给定平面上 n 对不同的点，“回旋镖” 是由点表示的元组 (i, j, k) ，
     其中 i 和 j 之间的距离和 i 和 k 之间的距离相等（需要考虑元组的顺序）。
     找到所有回旋镖的数量。你可以假设 n 最大为 500，所有点的坐标在闭区间 [-10000, 10000] 中。

     示例:
     输入:  [[0,0],[1,0],[2,0]]  输出: 2

     解释:
     两个回旋镖为 [[1,0],[0,0],[2,0]] 和 [[1,0],[2,0],[0,0]]

     解法：
     观察到 i 是一个 “枢纽”，对于每个点i，遍历其余点到 i 的距离对于每个枢纽 i，
     计算它到其它点j的距离，并将距离作为键存入字典 dict 中，value 为距离的个数。时间复杂度为：O(n^2)。 距离作为键值。
     如果对应距离的个数大于1，则证明存在回旋镖组合，对value进行全排列（value * （value-1））则得出了该回旋镖的数目
     */
    func numberOfBoomerangs(_ points: [[Int]]) -> Int {
        func getDistance(_ p1: [Int], _ p2: [Int]) -> Double {
            let x = Double(p1[0] - p2[0])
            let y = Double(p1[1] - p2[1])
            return x * x + y * y
        }

        // 以点 i 为枢纽记录其它点到 i 的距离作为key，而 value 则是到 i 点的相应距离的数目
        var totalCount = 0
        for i in 0 ..< points.count {
            var distMap = [Double: Int]()
            for j in 0 ..< points.count {
                if i == j {
                    continue
                }
                let d = getDistance(points[i], points[j])
                if let count = distMap[d] {
                    distMap[d] = count + 1
                } else {
                    distMap[d] = 1
                }
            }
            var subCount = 0
            // 统计以 i 点为枢纽的回旋镖的数目
            for (_, count) in distMap {
                subCount = subCount + (count * (count - 1)) // 全排列
            }
            totalCount += subCount
        }
        return totalCount
    }

    // MARK: - ------------- 直线上最多的点数 leetCode #149

    /*
     https://leetcode-cn.com/problems/max-points-on-a-line/
     给定一个二维平面，平面上有 n 个点，求最多有多少个点在同一条直线上。

     示例 1:
     输入: [[1,1],[2,2],[3,3]]  输出: 3
     解释:
     ^
     |
     |        o
     |     o
     |  o
     +------------->
     0  1  2  3  4

     示例 2:
     输入: [[1,1],[3,2],[5,3],[4,1],[2,3],[1,4]]   输出: 4
     解释:
     ^
     |
     |  o
     |     o        o
     |        o
     |  o        o
     +------------------->
     0  1  2  3  4  5  6

     · 知识点：哈希表、欧几里得最大公约数算法
     · 思路：用分数形式存储直线的斜率，切勿忘记斜率不存在的情况
     · 解法：
       1) 新建一个长度为点的数量的数组maxCount，用以保存对于每一个点i其斜率存在的情况下的直线的经过的最多的点的个数。
       2) 首先设置一个外循环依次遍历所有的点，外循环变量记为i。每一次循环都新建一个哈希表用以记录与i点在同一条直线上
          的直线的斜率以及该斜率直线下点的个数。 再新建一个变量samePointCount，用以记录与点i在坐标平面上位置相同的
          点j的数量。还得新建一个变量verticalCount，用以记录经过点i且垂直于x轴（即斜率不存在）的直线的情况。
       3) 再设置一个内循环依次遍历所有的点，内循环变量记为j。
       4) 如果遍历到的点满足i ！= j，说明遍历到的不是同一个点，那么我们就需要来判断点j和点i是否在同一条直线上。
          由数学基本知识可知，平面上的一点以及相应的斜率就可以确定一条直线。
          设点A(x1, y1), 点B(x2, y2), 直线AB的斜率 K = (y2 - y1) / (x2 - x1)
       5) 当点i的x坐标与点j的x坐标不相等时，点i和点j的斜率是存在的。由于直接求斜率会产生误差，LeetCode上的一些测试用例不能通过。
          因此我们计算其分数形式表示的斜率，即dy/dx，其中dy为点i和点j的y坐标的差值，dx为点i和点j的x坐标的差值。
          另外，我们需要把分数dy/dx化简到不能约分的形式，防止4/2和2/1这两条斜率明明相同的直线却被视作两条直线的情况出现。
          需要保存两个变量dy和dx，可以用一个长度为2的整型数组arrKey来保存，其中arrKey[0]保存dy，arrKey[1]保存dx。
          如果（1）中新建的哈希表中已经保存了nums的值，那么相应arrKey对应的值+1即可；否则，在哈希表中新增一个键arrKey，其值为1。
       6) 在（4）中我们说需要对dy/dx进行约分处理，那么我们就需要一个函数来求dy和dx的最大公约数gcd，
          令dy = dy / gcd，dx = dx / gcd。
          该函数其实很简单，我们可以用欧几里得算法递归地求解，公式为gcd(a, b) = gcd(b, a mod b)。
       7) 如果点i的x坐标与点j的x坐标相等，这又可以分为两种情况:
          a) 如果点i的y坐标和点j的y坐标也相等，那么说明点i和点j的点在坐标平面上是同一个点，那么我们需要samePointCount++，
             同时垂直于x轴的直线的数量也需要verticalCount++。
          b) 如果点i的y坐标和点j的y坐标不相等，我们只需要对垂直于x轴的直线的数量 verticalCount 进行加1处理
       8) 对于每一个点i，经过点i且经过点数最多的直线应该在verticalCount + 1(加一是要加上i点本身) 和（samePointCount + maxCount[i]）中取最大值。
       9) 遍历一遍count数组，求得其最大值返回即可。
     · 时间复杂度是O(n ^ 2)。空间复杂度是O(n)。

     · 参考： https://blog.csdn.net/qq_41231926/article/details/81475442
     */
    private func _maxPoints(_ points: [Point]) -> Int {
        // 求最大公约数
        func getGCD(_ a: Int, _ b: Int) -> Int {
            if b == 0 {
                return a
            }
            return getGCD(b, a % b)
        }

        // 数组大小为点的个数，用来记录与每一个点在同一条直线上的最大点的个数
        var maxCount: [Int] = Array(repeating: 0, count: points.count)

        for i in 0 ..< points.count {
            // 至少有一个点
            maxCount[i] = 1
            // 经过点i，和i垂直的点的个数，由于垂直两点的斜率不存在（除零），所以单独统计
            var verticalCount: Int = 0
            var samePointCount: Int = 0
            // 以斜率信息为为key， 该斜率对应的直线上(经过i点)的点的个数为value
            var map = [[Int]: Int]()

            for j in 0 ..< points.count {
                if i == j {
                    continue
                }
                // j 到 i 的线段
                if points[i].x != points[j].x {
                    let dx = points[i].x - points[j].x
                    let dy = points[i].y - points[j].y
                    let gcd = getGCD(dx, dy)
                    let arrKey = [dx / gcd, dy / gcd]
                    if let count = map[arrKey] {
                        map[arrKey] = count + 1
                    } else {
                        map[arrKey] = 1
                    }
                } else { // points[i].x == points[j].x
                    if points[i].y == points[j].y {
                        // 如果有坐标也相等，则是同一个点
                        samePointCount += 1
                    }
                    verticalCount += 1
                }
            }

            for (_, pCount) in map {
                let finalCount = pCount + 1 // 加上i点本身
                if finalCount > maxCount[i] {
                    maxCount[i] = finalCount
                }
            }

            // 有斜率的直线上的点的总数（包括坐标与 i 点相同的点的个数）
            // 没有斜率的直线（垂直经过i点的直线线）上的点的总数（包括坐标与 i 点相同的点的个数）
            // 上述两者取最大值，即为和i点的在同一条直线上数目最多的点的个数
            maxCount[i] = maxCount[i] + samePointCount
            maxCount[i] = max(maxCount[i], verticalCount + 1)
        }
        var res: Int = 0
        for count in maxCount {
            if count > res {
                res = count
            }
        }
        return res
    }

    // Definition for a point.
    class Point {
        public var x: Int
        public var y: Int
        public init(_ x: Int, _ y: Int) {
            self.x = x
            self.y = y
        }
    }

    func maxPoints(_ points: [[Int]]) -> Int {
        var pArr = [Point]()
        for p in points {
            let pModel = Point(p[0], p[1])
            pArr.append(pModel)
        }
        return _maxPoints(pArr)
    }

    // MARK: - ------------- 存在重复元素 II leetCode #219

    /*
     https://leetcode-cn.com/problems/contains-duplicate-ii/
     给定一个整数数组和一个整数 k，判断数组中是否存在两个不同的索引 i 和 j，
     使得 nums [i] = nums [j]，并且 i 和 j 的差的绝对值最大为 k。

     示例 1:
     输入: nums = [1,2,3,1], k = 3 输出: true

     示例 2:
     输入: nums = [1,0,1,1], k = 1 输出: true

     示例 3:
     输入: nums = [1,2,3,1,2,3], k = 2 输出: false

     使用滑动窗口和查找表来解答此题:
     滑动窗口指在查找表中限制有限的元素个数（限制可视范围），并对即将放入的元素进行条件判断
     该题中，循环遍历数组元素并将元素放入查找表中，然后不断查找当前滑动窗口中是否有重复值，
     当窗口中元素大于k时，要将窗口中最左边的元素移除（保证窗口中有<=k的个数的元素）
     */
    func containsNearbyDuplicate(_ nums: [Int], _ k: Int) -> Bool {
        let len = nums.count
        if len <= 1 {
            return false
        }
        var set = Set<Int>()
        for i in 0 ..< len {
            // 如果在有限个数k的窗口中包含相同的元素，则条件成立，返回true
            if set.contains(nums[i]) {
                return true
            }
            set.insert(nums[i])
            if set.count > k {
                // 如果窗口中元素个数>k，则移出最左边的元素(最老的元素)，保证窗口大小为k
                set.remove(nums[i - k])
            }
        }
        return false
    }

    // MARK: - ------------- 存在重复元素 III leetCode #220

    /*
     https://leetcode-cn.com/problems/contains-duplicate-iii/
     给定一个整数数组，判断数组中是否有两个不同的索引 i 和 j，
     使得 nums [i] 和 nums [j] 的差的绝对值最大为 t，并且 i 和 j 之间的差的绝对值最大为 k。

     示例 1:
     输入: nums = [1,2,3,1], k = 3, t = 0 输出: true

     示例 2:
     输入: nums = [1,0,1,1], k = 1, t = 2 输出: true

     示例 3:
     输入: nums = [1,5,9,1,5,9], k = 2, t = 3 输出: false

     依然使用#219的思路，使用滑动窗口和查找表来解答此题:
     限制滑动窗口的大小为k，当遍历数组得到一个元素时，用该元素与查找表滑动窗口中的每个元素做相减绝对值处理。
     如果得数 <= t, 则满足题中条件，return true
     */
    func containsNearbyAlmostDuplicate(_ nums: [Int], _ k: Int, _ t: Int) -> Bool {
        let len = nums.count
        if len <= 1 {
            return false
        }
        var set = Set<Int>()
        for i in 0 ..< len {
            let elem = nums[i]
            if t == 0 {
                if set.contains(elem) {
                    return true
                }
            } else {
                for subElem in set {
                    if abs(elem - subElem) <= t {
                        return true
                    }
                }
            }
            set.insert(elem)
            if set.count > k {
                set.remove(nums[i - k])
            }
        }
        return false
    }
}

extension Solution_04 {
    // MARK: - ------------- 两两交换链表中的节点 leetCode #24

    /*
     https://leetcode-cn.com/problems/swap-nodes-in-pairs/
     给定一个链表，两两交换其中相邻的节点，并返回交换后的链表。
     你不能只是单纯的改变节点内部的值，而是需要实际的进行节点交换。
     示例1:
     给定 1->2->3->4, 你应该返回 2->1->4->3

     示例2:
     给定 1->2->3->4->5, 你应该返回 2->1->4->3->5
     */
    func swapPairs(_ head: ListNode?) -> ListNode? {
        guard head != nil, head?.next != nil else {
            return head
        }
        var prev: ListNode?
        var curr: ListNode? = head
        var next: ListNode? = curr?.next
        let ret: ListNode? = next
        while next != nil {
            prev?.next = next
            curr?.next = next?.next
            next?.next = curr
            prev = curr
            curr = curr?.next
            next = curr?.next
        }
        return ret
    }

    // MARK: - ------------- 删除链表的倒数第N个节点 leetCode #19

    /*
     https://leetcode-cn.com/problems/remove-nth-node-from-end-of-list/
     给定一个链表，删除链表的倒数第 n 个节点，并且返回链表的头结点。

     示例：
     给定一个链表: 1->2->3->4->5, 和 n = 2.
     当删除了倒数第二个节点后，链表变为 1->2->3->5.

     说明：
     给定的 n 保证是有效的。

     进阶：
     你能尝试使用一趟扫描实现吗？
     */
    func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
        var start: ListNode? = head
        var end: ListNode? = start
        if n <= 0 {
            return head
        }
        for _ in 0 ..< n - 1 {
            end = end?.next
        }
        if end == nil {
            return head
        }
        var prev: ListNode?
        while end?.next != nil {
            prev = start
            start = start?.next
            end = end?.next
        }
        if prev == nil {
            let ret = start?.next
            start?.next = nil
            return ret

        } else {
            prev?.next = start?.next
            start?.next = nil
            return head
        }
    }

    // MARK: - ------------- 下一个排列 leetCode #31

    /*
     https://leetcode-cn.com/problems/next-permutation/
     实现获取下一个排列的函数，算法需要将给定数字序列重新排列成字典序中下一个更大的排列。

     如果不存在下一个更大的排列，则将数字重新排列成最小的排列（即升序排列）。

     必须原地修改，只允许使用额外常数空间。

     以下是一些例子，输入位于左侧列，其相应输出位于右侧列。
     实例1：
     1,2,3 → 1,3,2
     解释：
     123 这个数字，下一个比它大的数字是132，所以输出 1，3，2 而不是 2，1，3

     实例2：
     3,2,1 → 1,2,3
     解释：
     没有比321更大的数字了，所以输出最小的数字123的排列，即 1，2，3
     */

    /*
     1. 我们希望下一个数比当前数大，这样才满足“下一个排列”的定义。因此只需要将后面的「大数」与前面的「小数」交换，就能得到一个更大的数。
        比如 123456，将 5 和 6 交换就能得到一个更大的数 123465。
     2. 我们还希望下一个数增加的幅度尽可能的小，这样才满足“下一个排列与当前排列紧邻“的要求。为了满足这个要求，我们需要：
        1. 在尽可能靠右的低位进行交换，需要从后向前查找
        2. 将一个 尽可能小的「大数」 与前面的「小数」交换。比如 123465，下一个排列应该把 5 和 4 交换而不是把 6 和 4 交换
        3. 将「大数」换到前面后，需要将「大数」后面的所有数重置为升序，升序排列就是最小的排列。
           以 123465 为例：首先按照上一步，交换 5 和 4，得到 123564；
           然后需要将 5 之后的数重置为升序，得到 123546。
           显然 123546 比 123564 更小，123546 就是 123465 的下一个排列。
     https://leetcode-cn.com/problems/next-permutation/solution/xia-yi-ge-pai-lie-suan-fa-xiang-jie-si-lu-tui-dao-/
     */
    func nextPermutation(_ nums: inout [Int]) {
        var i = nums.count - 1
        let len = nums.count - 1
        // 从后向前遍历，保持升序，如果发现降序，则停止
        while i > 0 && nums[i] <= nums[i - 1] {
            i -= 1
        }
        if i == 0 {
            // 逆序输出
            var from = 0, to = len
            while from <= to {
                swapElem(&nums, from, to)
                from += 1
                to -= 1
            }
            return
        }
        // 从[i, nums.count - 1) 现在是降序的，在这个区间里面照一个最小的，并且比 nums[i-1] 大的数，两者交换位置
        for j in stride(from: len, through: i, by: -1) {
            if nums[j] > nums[i - 1] {
                swapElem(&nums, j, i - 1)
                break
            }
        }

        // 将[i, nums.count - 1) 区间内的数升序排列，这样才能保证是尽量小的
        var from = i, to = len
        while from <= to {
            swapElem(&nums, from, to)
            from += 1
            to -= 1
        }
    }

    func swapElem(_ a: inout [Int], _ i: Int, _ j: Int) {
        if a[i] == a[j] || i == j {
            return
        }
        a[i] = a[i] ^ a[j]
        a[j] = a[i] ^ a[j]
        a[i] = a[i] ^ a[j]
    }

    // MARK: - ------------- 在排序数组中查找元素的第一个和最后一个位置 leetCode #34

    /*
     https://leetcode-cn.com/problems/find-first-and-last-position-of-element-in-sorted-array/
     给定一个按照升序排列的整数数组 nums，和一个目标值 target。找出给定目标值在数组中的开始位置和结束位置。
     你的算法时间复杂度必须是 O(log n) 级别。
     如果数组中不存在目标值，返回 [-1, -1]。

     示例 1:
     输入: nums = [5,7,7,8,8,10], target = 8
     输出: [3,4]

     示例 2:
     输入: nums = [5,7,7,8,8,10], target = 6
     输出: [-1,-1]
     */
    /*
     二分查找法 递归
     */
    func searchRange(_ nums: [Int], _ target: Int) -> [Int] {
        func inner_search(from: Int, to: Int) -> [Int] {
            if from > to {
                return [-1, -1]
            }
            let mid = (from + to) / 2
            let midNum = nums[mid]
            if midNum > target {
                return inner_search(from: from, to: mid - 1)

            } else if midNum < target {
                return inner_search(from: mid + 1, to: to)

            } else {
                let left = inner_search(from: from, to: mid - 1)
                let right = inner_search(from: mid + 1, to: to)
                return [left[0] == -1 ? mid : left[0], right[1] == -1 ? mid : right[1]]
            }
        }
        return inner_search(from: 0, to: nums.count - 1)
    }

    /*
     二分查找法 while
     https://leetcode-cn.com/problems/find-first-and-last-position-of-element-in-sorted-array/solution/er-fen-cha-zhao-suan-fa-xi-jie-xiang-jie-by-labula/
     */
    func searchRange_1(_ nums: [Int], _ target: Int) -> [Int] {
        func leftBounds() -> Int {
            var left = 0, right = nums.count - 1
            while left <= right {
                let mid = left + (right - left) / 2
                if nums[mid] == target {
                    right = mid - 1
                } else if nums[mid] > target {
                    right = mid - 1
                } else if nums[mid] < target {
                    left = mid + 1
                }
            }
            if left >= nums.count || nums[left] != target {
                return -1
            }
            return left
        }

        func rightBounds() -> Int {
            var left = 0, right = nums.count - 1
            while left <= right {
                let mid = left + (right - left) / 2
                if nums[mid] == target {
                    left = mid + 1
                } else if nums[mid] > target {
                    right = mid - 1
                } else if nums[mid] < target {
                    left = mid + 1
                }
            }
            if right < 0 || nums[right] != target {
                return -1
            }
            return right
        }

        let l = leftBounds()
        let r = rightBounds()
        if l != -1 && r != -1 {
            return [l, r]
        }
        return [-1, -1]
    }
}

extension Solution_04 {
    // MARK: - ------------- 组合总和 leetCode #39

    /*
     https://leetcode-cn.com/problems/combination-sum/
     给定一个无重复元素的数组 candidates 和一个目标数 target ，找出 candidates 中所有可以使数字和为 target 的组合。
     candidates 中的数字可以无限制重复被选取。

     说明：
     所有数字（包括 target）都是正整数。
     解集不能包含重复的组合。

     示例 1：
     输入：candidates = [2,3,6,7], target = 7,
     所求解集为：
     [
       [7],
       [2,2,3]
     ]

     示例 2：
     输入：candidates = [2,3,5], target = 8,
     所求解集为：
     [
       [2,2,2,2],
       [2,3,3],
       [3,5]
     ]
     */
    /*
     回溯法 + 剪枝
     https://leetcode-cn.com/problems/combination-sum/solution/fei-chang-xiang-xi-de-di-gui-hui-su-tao-lu-by-re-2/
     https://leetcode-cn.com/problems/combination-sum/solution/hui-su-suan-fa-jian-zhi-python-dai-ma-java-dai-m-2/
     */
    func combinationSum(_ candidates: [Int], _ target: Int) -> [[Int]] {
        // 虽然数组的排序也有复杂度，但是相比于接下来的剪枝操作节省的运行时间，总体的执行效率会有提升。
        let sorted = candidates.sorted(by: <)
        var ret = [[Int]]()
        process_39(begin: 0, target: target, path: [Int](), candidates: sorted, res: &ret)
        return ret
    }

    func process_39(begin: Int, target: Int, path: [Int], candidates: [Int], res: inout [[Int]]) {
        var path = path
        // 在上一层已经进行了剪枝操作，那么不会存在 target < 0 的情况出现
        if target == 0 {
            // 将路径添加到结果集中
            res.append(path)
            return
        }
        // 例如有数组 [1,3,4]
        // 由于数字的组合不能重复，当遍历到数字3时，target减去3之后的组合里面不能有 3 前面的数字 1.
        // 因为 1 和 3 的组合在上一次已经遍历到了。所以在遍历到一个数字时，它只能和后面的数字进行组合。
        for i in begin ..< candidates.count {
            let n = candidates[i]
            if target - n < 0 {
                // 剪枝，前提是数组已经排好序，如果 target - n < 0, 则 n 后面的数字都不需要遍历了
                break
            }
            path.append(n)
            process_39(begin: i, target: target - candidates[i], path: path, candidates: candidates, res: &res)
            // 回溯
            // 不论是 target == 0 还是 小于0，在dfs执行完之后都需要删除最后的结点
            // 使程序可以继续输出别的结果。
            path.removeLast()
        }
    }
}

extension Solution_04 {
    // MARK: - ------------- 递增子序列 leetCode #491

    /*
     https://leetcode-cn.com/problems/increasing-subsequences/
     给定一个整型数组, 你的任务是找到所有该数组的递增子序列，递增子序列的长度至少是2。

     示例:
     输入: [4, 6, 7, 7]
     输出: [[4, 6], [4, 7], [4, 6, 7], [4, 6, 7, 7], [6, 7], [6, 7, 7], [7,7], [4,7,7]]

     说明:
     给定数组的长度不会超过15。
     数组中的整数范围是 [-100,100]。
     给定数组中可能包含重复数字，相等的数字应该被视为递增的一种情况。
     */

    /*
     回溯法
     https://leetcode-cn.com/problems/increasing-subsequences/solution/491-di-zeng-zi-xu-lie-shen-sou-hui-su-xiang-jie-by/
     */
    func findSubsequences(_ nums: [Int]) -> [[Int]] {
        var res = [[Int]]()
        var path = [Int]()
        func process(start: Int) {
            if path.count > 1 {
                res.append(path)
            }
            // 使用set来对尾部元素进行去重
            var used_tails = Set<Int>()
            for i in start ..< nums.count {
                if (path.isEmpty || (!path.isEmpty && nums[i] >= path.last!)) && !used_tails.contains(nums[i]) {
                    path.append(nums[i])
                    process(start: i + 1)
                    // back trace
                    used_tails.insert(nums[i]) // 在回溯的时候，记录这个元素用过了，后面不能再用了
                    path.removeLast()
                }
            }
        }
        process(start: 0)
        return res
    }

    func findSubsequences_1(_ nums: [Int]) -> [[Int]] {
        var res = [[Int]]()
        var used = Set<String>()
        var path = [Int]()
        func process(_ i: Int) {
            if path.count > 1 {
                let key = path.reduce("") { $0 + "\($1)" }
                if !used.contains(key) {
                    res.append(path)
                    used.insert(key)
                }
            }
            for k in i ..< nums.count {
                if !path.isEmpty && nums[k] < path.last! {
                    continue
                }
                path.append(nums[k])
                process(k + 1)
                path.removeLast()
            }
        }
        process(0)
        return res
    }

    // MARK: - ------------- 子集 II leetCode #90

    /*
      https://leetcode-cn.com/problems/subsets-ii/
      给定一个可能包含重复元素的整数数组 nums，返回该数组所有可能的子集（幂集）。

      说明：解集不能包含重复的子集。

      示例:

      输入: [1,2,2]
      输出:
      [
        [2],
        [1],
        [1,2,2],
        [2,2],
        [1,2],
        []
      ]
     */
    /*
     回溯 + 同层去重
     https://leetcode-cn.com/problems/subsets-ii/solution/li-jie-li-jie-qu-zhong-cao-zuo-by-jin-ai-yi/
     */
    func subsetsWithDup(_ nums: [Int]) -> [[Int]] {
        var res: [[Int]] = [[]]
        var path = [Int]()
        var nums = nums.sorted(by: <)
        func process(_ begin: Int) {
            if begin >= nums.count {
                return
            }
            for i in begin ..< nums.count {
                if i > begin && nums[i] == nums[i - 1] {
                    continue
                }
                path.append(nums[i])
                res.append(path)
                process(i + 1)
                path.removeLast()
            }
        }
        process(0)
        return res
    }

    /*
     回溯 + Set去重
     */
    func subsetsWithDup_1(_ nums: [Int]) -> [[Int]] {
        var res = [[Int]]()
        res.append([])
        // 存在这种情况 [4,4,4,1,4], 在进行遍历之前需要先排序将相同的数字放到一起
        // 才能使最后的结果不会出现重复的子集合
        var nums = nums.sorted(by: <)
        var path = [Int]()
        func process(_ begin: Int) {
            if begin >= nums.count {
                return
            }
            // 使用集合判断去重
            var used = Set<Int>()
            for i in begin ..< nums.count {
                let n = nums[i]
                if used.contains(n) {
                    continue
                }
                path.append(n)
                res.append(path)
                process(i + 1)
                if path.isEmpty == false {
                    let last = path.removeLast()
                    used.insert(last)
                }
            }
        }
        process(0)
        return res
    }
}

extension Solution_04 {
    // MARK: - ------------- 重新安排行程 leetCode #332

    /*
      https://leetcode-cn.com/problems/reconstruct-itinerary/
      给定一个机票的字符串二维数组 [from, to]，子数组中的两个成员分别表示飞机出发和降落的机场地点，对该行程进行重新规划排序。所有这些机票都属于一个从 JFK（肯尼迪国际机场）出发的先生，所以该行程必须从 JFK 开始。

      说明:
      如果存在多种有效的行程，你可以按字符自然排序返回最小的行程组合。例如，行程 ["JFK", "LGA"] 与 ["JFK", "LGB"] 相比就更小，排序更靠前
      所有的机场都用三个大写字母表示（机场代码）。
      假定所有机票至少存在一种合理的行程。

      示例 1:
      输入: [["MUC", "LHR"], ["JFK", "MUC"], ["SFO", "SJC"], ["LHR", "SFO"]]
      输出: ["JFK", "MUC", "LHR", "SFO", "SJC"]

      示例 2:
      输入: [["JFK","SFO"],["JFK","ATL"],["SFO","ATL"],["ATL","JFK"],["ATL","SFO"]]
      输出: ["JFK","ATL","JFK","SFO","ATL","SFO"]
      解释: 另一种有效的行程是 ["JFK","SFO","ATL","JFK","ATL","SFO"]。但是它自然排序更大更靠后。
     */

    /*
     经典的欧拉路径问题
     Hierholzer 算法:
     Hierholzer 算法用于在连通图中寻找欧拉路径，其流程如下：
     从起点出发，进行深度优先搜索。
     每次沿着某条边从某个顶点移动到另外一个顶点的时候，都需要删除这条边。
     如果没有可移动的路径，则将所在节点加入到栈中，并返回。
     当我们顺序地考虑该问题时，我们也许很难解决该问题，因为我们无法判断当前节点的哪一个分支是「死胡同」分支。

     不妨倒过来思考。我们注意到只有那个入度与出度差为 11 的节点会导致死胡同。
     而该节点必然是最后一个遍历到的节点。我们可以改变入栈的规则，当我们遍历完一个节点所连的所有节点后，我们才将该节点入栈（即逆序入栈）。

     对于当前节点而言，从它的每一个非「死胡同」分支出发进行深度优先搜索，都将会搜回到当前节点。
     而从它的「死胡同」分支出发进行深度优先搜索将不会搜回到当前节点。也就是说当前节点的死胡同分支将会优先于其他非「死胡同」分支入栈
     这样就能保证我们可以「一笔画」地走完所有边，最终的栈中逆序地保存了「一笔画」的结果。我们只要将栈中的内容反转，即可得到答案。

     https://leetcode-cn.com/problems/reconstruct-itinerary/solution/zhong-xin-an-pai-xing-cheng-by-leetcode-solution/
     (可以参考 BasicGraph 类里面的 eulerPath 方法)
     */
    func findItinerary(_ tickets: [[String]]) -> [String] {
        var map: [String: [String]] = [:]
        var ret: [String] = []

        func dfs(_ n: String) {
            while var set = map[n], set.count > 0 {
                let next = set.removeFirst()
                map[n] = set
                dfs(next)
            }
            // set.count == 0 代表和结点n相连的所有通路都走完了，可以输出了
            ret.append(n)
        }

        for t in tickets {
            if var set = map[t[0]] {
                set.append(t[1])
                map[t[0]] = set
            } else {
                var set = [String]()
                set.append(t[1])
                map[t[0]] = set
            }
        }

        // 因为要输出字典序中尽量小的组合，所以要对每个结点的通路目标结点进行字典序排序
        for (k, v) in map {
            map[k] = v.sorted(by: <)
        }

        dfs("JFK")
        // ret 是逆序输出的,即第一个结点是这个路径的终点
        return ret.reversed()
    }
}

extension Solution_04 {
    // MARK: - ------------- 实现 Trie (前缀树) leetCode #208

    /*
       https://leetcode-cn.com/problems/implement-trie-prefix-tree/
       实现一个 Trie (前缀树)，包含 insert, search, 和 startsWith 这三个操作。

       示例:
       Trie trie = new Trie();
       trie.insert("apple");
       trie.search("apple");   // 返回 true
       trie.search("app");     // 返回 false
       trie.startsWith("app"); // 返回 true
       trie.insert("app");
       trie.search("app");     // 返回 true

       说明:
       你可以假设所有的输入都是由小写字母 a-z 构成的。
       保证所有输入均为非空字符串。
     */
    // https://leetcode-cn.com/problems/implement-trie-prefix-tree/solution/shi-xian-trie-qian-zhui-shu-by-leetcode/
    class Trie {
        class Node {
            private var _link: [Character: Trie.Node] = [:]
            private var _isEnd: Bool = false

            func put(_ ch: Character, node: Trie.Node) {
                _link[ch] = node
            }

            func get(_ ch: Character) -> Trie.Node? {
                return _link[ch]
            }

            func setEnd(_ e: Bool) {
                _isEnd = e
            }

            func isEnd() -> Bool {
                return _isEnd
            }
        }

        private var root: Trie.Node

        /** Initialize your data structure here. */
        init() {
            root = Trie.Node()
        }

        /** Inserts a word into the trie. */
        func insert(_ word: String) {
            var curr = root
            let len = word.count
            for i in 0 ..< len {
                let c = word[String.Index(encodedOffset: i)]
                if let node = curr.get(c) {
                    if i == len - 1 {
                        node.setEnd(true)
                    }
                    curr = node
                } else {
                    let newNode = Trie.Node()
                    newNode.setEnd(i == len - 1)
                    curr.put(c, node: newNode)
                    curr = newNode
                }
            }
        }

        /** Returns if the word is in the trie. */
        func search(_ word: String) -> Bool {
            var curr = root
            let len = word.count
            for i in 0 ..< len {
                if let node = curr.get(word[String.Index(encodedOffset: i)]) {
                    if i == len - 1 && !node.isEnd() {
                        return false
                    }
                    curr = node
                } else {
                    return false
                }
            }
            return true
        }

        /** Returns if there is any word in the trie that starts with the given prefix. */
        func startsWith(_ prefix: String) -> Bool {
            var curr = root
            for i in 0 ..< prefix.count {
                if let node = curr.get(prefix[String.Index(encodedOffset: i)]) {
                    curr = node
                } else {
                    return false
                }
            }
            return true
        }
    }
}
