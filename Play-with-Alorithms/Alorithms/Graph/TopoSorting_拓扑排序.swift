//
//  TopoSorting_拓扑排序.swift
//  Play-with-Alorithms
//
//  Created by fn-273 on 2020/8/18.
//  Copyright © 2020 ZhengYi. All rights reserved.
//

import Foundation

/*
 拓扑排序并不是一种排序算法，它是针对有向无环图中的结点的算法。
 对一个有向无环图(Directed Acyclic Graph简称DAG)G进行拓扑排序，是将G中所有顶点排成一个线性序列，
 使得图中任意一对顶点u和v，若边<u,v> ∈ E(G)，则u在线性序列中出现在v之前。
 通常，这样的线性序列称为满足拓扑次序(Topological Order)的序列，简称拓扑序列。
 简单的说，由某个集合上的一个偏序得到该集合上的一个全序，这个操作称之为拓扑排序。
 有向无环图（DAG）才有拓扑排序，非DAG图没有拓扑排序一说。

 对于一个DAG，输出拓扑的方法如下：
 1. 从DAG中选取一个没有前驱（入度为0）的结点并输出
 2. 从图中删除该订点和所有以它为起点的有向边
 3. 重复1和2直到以下情况之一:
   (1)DAG图为空
   (2)DAG图非空，当前图中不存在无前驱的结点
    第二种情况说明图中有环路存在。
 参考:
 https://www.cnblogs.com/czc1999/p/11746142.html
 https://www.cnblogs.com/bigsai/p/11489260.html
 https://blog.csdn.net/lisonglisonglisong/article/details/45543451
 */

class TopoLogicalSorting {
    class Stack<T> {
        var data: [T] = []
        var isEmpty: Bool {
            data.isEmpty
        }

        var top: T? {
            return data.isEmpty ? nil : data.last
        }

        func push(_ e: T) {
            data.append(e)
        }

        func pop() {
            if isEmpty { return }
            data.removeLast()
        }
    }

    class Graph {
        var cap: Int = 0
        var adj: [[Bool]]
        var indegree: [Int]

        init(capacity: Int) {
            cap = capacity
            adj = Array(repeating: Array(repeating: false, count: capacity), count: capacity)
            indegree = Array(repeating: 0, count: capacity)
        }

        func addEdge(from: Int, to: Int) {
            if !isVertexValid(from) || !isVertexValid(to) || hasEdge(from: from, to: to) {
                return
            }
            adj[from][to] = true
            indegree[to] = indegree[to] + 1
        }

        func hasEdge(from: Int, to: Int) -> Bool {
            return adj[from][to] || adj[to][from]
        }

        func isVertexValid(_ v: Int) -> Bool {
            return v >= 0 && v < cap
        }

        func topologicalSort() -> [Int] {
            let stack = Stack<Int>()
            var ret : [Int] = []
            // 遍历找到入度为0的结点，入栈
            for i in 0 ..< indegree.count {
                if indegree[i] == 0 {
                    stack.push(i)
                }
            }
            if stack.isEmpty {
                return ret
            }
            var count = 0
            while !stack.isEmpty {
                let v = stack.top!
                stack.pop()
                count += 1
                ret.append(v)
                for i in 0 ..< adj[v].count {
                    if adj[v][i] == true {
                        let newEnterCount = indegree[i] - 1
                        if newEnterCount == 0 {
                            stack.push(i)
                        }
                        indegree[i] = newEnterCount
                    }
                }
            }
            return ret
        }
    }
}
