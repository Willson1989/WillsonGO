//
//  UnionFindSet.swift
//  Play-with-Alorithms
//
//  Created by fn-273 on 2020/8/26.
//  Copyright © 2020 ZhengYi. All rights reserved.
//

import Foundation

// MARK: - ------------- review : 2020 / 8 / 27
class UnionFindSet {
    fileprivate var data: [Int] = []
    fileprivate var parent: [Int]
    fileprivate var level: [Int]

    init(capacity: Int) {
        parent = Array(repeating: 0, count: capacity)
        level = Array(repeating: 0, count: capacity)
        for i in 0 ..< capacity {
            data.append(i)
            parent[i] = i
            level[i] = 1
        }
    }

    func union(_ e1: Int, _ e2: Int) {
        if !isValid(e1) || !isValid(e2) || e1 == e2 {
            return
        }

        guard let r_e1 = find(e1), let r_e2 = find(e2) else {
            return
        }

        if level[r_e1] > level[r_e2] {
            parent[r_e2] = r_e1
        } else if level[r_e1] < level[r_e2] {
            parent[r_e1] = r_e2
        } else if level[r_e1] == level[r_e2] {
            parent[r_e1] = r_e2
            level[r_e2] = level[r_e2] + 1
        }
    }

    func find(_ e: Int) -> Int? {
        if !isValid(e) {
            return nil
        }

        return find_compress_path_1(e)
    }

    func find_compress_path_2(_ e: Int) -> Int {
        if e == parent[e] {
            return e
        }
        parent[e] = find_compress_path_2(e)
        return parent[e]
    }

    func find_compress_path_1(_ e: Int) -> Int {
        while e != parent[e] {
            parent[e] = parent[parent[e]]
        }
        return parent[e]
    }

    func isValid(_ i: Int) -> Bool {
        return i >= 0 && i < data.count
    }
}
