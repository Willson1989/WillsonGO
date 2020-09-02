//
//  BasicGraph.swift
//  Play-with-Alorithms
//
//  Created by fn-273 on 2020/8/28.
//  Copyright © 2020 ZhengYi. All rights reserved.
//

import Foundation

class BasicGraph<T: Hashable> {
    typealias ValueType = T

    let UNCONNECT: Int = 0
    let CONNECTED: Int = 1
    let NOEDGE: Int = 2

    var parent: [Int] = []
    var data: [Node]
    var size: Int { data.count }
    var adj: [[Int]]
    var isDirect: Bool

    init(nodes: [Node], isDirectGraph: Bool = false) {
        adj = Array(repeating: Array(repeating: UNCONNECT, count: nodes.count), count: nodes.count)
        isDirect = isDirectGraph
        data = nodes
        for i in 0 ..< nodes.count {
            let n = nodes[i]
            n.isDirect = isDirectGraph
            n.index = i
            parent.append(i)
        }
    }

    func connect(from: Node, to: Node) {
        let i_from = from.index, i_to = to.index
        if isDirect {
            adj[i_from][i_to] = CONNECTED
            from.outDegree += 1
            to.inDegree += 1
        } else {
            adj[i_from][i_to] = CONNECTED
            adj[i_to][i_from] = CONNECTED
            from.degree += 1
            to.degree += 1
        }
        union(from: from, to: to)
    }

    /*
     https://blog.csdn.net/mmk27_word/article/details/90081551?utm_medium=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-2.channel_param&depth_1-utm_source=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-2.channel_param
     
     有向图：
        欧拉路径的条件：
            1.连通的
            2.所有结点入度=出度 或者 存在且仅存在两个点，这两个点的入度和出度不相等，其中入度 < 出度的结点是起点、入度 > 出度的结点是终点
        欧拉回路的条件：
            1.连通的
            2.所有结点的入度=出度

     无向图：
        欧拉路径的条件：
            1.连通的
            2.所有结点度数为偶数，存在且仅存在两个点，这两个点分别为起点和终点
        欧拉回路的条件：
            1.连通的
            2.所有结点的度数为偶数
     */
    func eulerType() -> (EulerType, Node) {
        var degree = 0
        var cnt = 0
        var start: Node = data.first!
        for n in data {
            if parent[n.index] == n.index {
                // 在一个连通图中，最多存在一个结点，
                // 这个结点在并查集中自己是自己的父节点(parent[n.index] == n.index)
                // 如果存在大于1个的这样的结点，说明这个图至少有两个连通分量即不是连通图
                cnt += 1
            }
            if isDirect {
                if n.inDegree != n.outDegree {
                    degree += 1
                    // 出度大的为起点，入度大的为终点
                    if n.outDegree > n.inDegree {
                        start = n
                    }
                }
            } else {
                if n.totalDegree % 2 != 0 {
                    degree += 1
                    start = n
                }
            }
        }
        if cnt > 1 || (degree != 0 && degree != 2) {
            return (.none, start)
        } else {
            return (degree == 0 ? .circuit : .path, start)
        }
    }

    // 输出欧拉路径
    // https://www.cnblogs.com/KasenBob/p/10458518.html
    func eulerPath() -> [Node] { // Fleury 佛罗莱算法输出欧拉路径
        var ret = [Node]()
        var stack = [Int]()

        func dfs(_ x: Int) {
            stack.append(x)
            for i in 0 ..< adj[x].count {
                if adj[x][i] == CONNECTED {
                    // 如果 x 和 i 之间有边, 则去掉这条边(这条路线已经走过了)
                    // 接着从结点进行深度优先搜索
                    adj[x][i] = NOEDGE
                    if !isDirect {
                        adj[i][x] = NOEDGE
                    }
                    dfs(i)
                    // 找到一条通路，不需要再走其他路线，break
                    break
                }
            }
        }

        let eulerRes = eulerType()
        if eulerRes.0 == .none {
            return ret
        }
        // 存在欧拉路径，则从起始点开始遍历打印路径的结点
        let startIndex = eulerRes.1.index
        stack.append(startIndex)
        while stack.isEmpty == false {
            let a = stack.last!
            var hasEdge = false
            // 选择一条从a出发还没有走过的路径
            for i in 0 ..< adj[a].count {
                if adj[a][i] == CONNECTED {
                    hasEdge = true
                    break
                }
            }
            if hasEdge {
                // 如果有边，则从这个点开始深度优先遍历
                stack.removeLast()
                dfs(a)
            } else {
                // 如果和a点相邻的边都没有了，说明a一定是欧拉路径中的一个点了，输出
                stack.removeLast()
                ret.append(data[a])
            }
        }
        return ret
    }

    fileprivate func isGraphConnected() -> Bool {
        var cnt: Int = 0
        var visited = Array(repeating: 0, count: size)
        func dfs(_ i: Int) {
            if visited[i] == 1 {
                return
            }
            cnt += 1
            visited[i] = 1
            for n in adj[i] {
                dfs(n)
            }
        }
        dfs(data[0].index)
        let ret = cnt == size
        return ret
    }

    fileprivate func union(from: Node, to: Node) {
        let i_from = find(n: from.index), i_to = find(n: to.index)
        if i_from == i_to {
            return
        }
        parent[i_from] = i_to
    }

    fileprivate func find(n: Int) -> Int {
        if parent.isEmpty {
            return n
        }
        var p = n
        while p != parent[p] {
            p = parent[p]
        }
        return p
    }
}

extension BasicGraph {
    enum EulerType {
        case path // 半欧拉图（存在欧拉路径，但是不存在欧拉回路）
        case circuit // 欧拉图（存在欧拉回路）
        case none // 非不是欧拉图
    }

    class Node: Hashable {
        fileprivate var index: Int = -1

        var val: ValueType
        var isDirect: Bool = false
        var inDegree: Int = 0
        var outDegree: Int = 0
        var degree: Int = 0
        var totalDegree: Int {
            if isDirect {
                return inDegree + outDegree
            } else {
                return degree
            }
        }

        init(val: ValueType) {
            self.val = val
        }

        static func == (lhs: BasicGraph.Node, rhs: BasicGraph.Node) -> Bool {
            return lhs.val == rhs.val
        }

        func hash(into hasher: inout Hasher) {
            hasher.combine(val)
        }
    }
}
