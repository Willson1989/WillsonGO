//
//  Graph_Weighted.swift
//  Play-with-Alorithms
//
//  Created by ZhengYi on 2017/6/14.
//  Copyright © 2017年 ZhengYi. All rights reserved.
//

import UIKit

public protocol GraphWeight : Equatable, Comparable{
    
    var wID : Int { get set }
  
    static func addWeight<T>(_ w1 : T, _ w2 : T) -> T where T : GraphWeight

}

//public typealias EdgeWeight = GraphWeight
//public typealias iteratorBlock_Weighted = (_ v : Int, _ weight : EdgeWeight) -> ()

// 链表实现邻接表时，顶点的数据结构
internal class Vertex<T : GraphWeight> {
    
    public var v : Int = -1
    public var firstArc : Edge<T>? = nil
    
    init(vertex : Int) {
        self.v = vertex
        self.firstArc = nil
    }
}

// 有权图的边
public class Edge<T : GraphWeight> {
    
    internal var from : Int = INFINITY
    internal var to   : Int = INFINITY
    internal var weight : T? = nil
    internal var next : Edge<T>? = nil
    
    init(a : Int, b : Int, weight : T?) {
        self.from = a
        self.to = b
        self.weight = weight
    }
    
    init() {
        self.from = INFINITY
        self.to = INFINITY
        self.weight = nil
    }
    
    //指定一个顶点，返回与之连接的另一个顶点
    public func other(_ v : Int) -> Int {
        if v == self.from {
            return self.to
        } else {
            return self.from
        }
    }
    
    public func V() -> Int {
        return self.from
    }
    
    public func W() -> Int {
        return self.to
    }
    
    public func wt() -> T? {
        return self.weight
    }
}

class Graph_Weighted<T : GraphWeight> : Graph {

    public func addEdge(_ v : Int, _ w : Int, weight : T) { }
    
    
    
}

/*
 最小生成树
 一个图可以生成最小生成树的前提是这个图是连通的
 切分定理：
 将一个图分成两个部分（一部分节点为蓝色，一部分节点为红色）
 连接两个部分的节点的边被称为 横切边。（即这个边的两个节点一个是红色一个是蓝色）
 在多个横切边中权值最小的边一定是这个图的最小生成树的一条边
 */
class MST<T : GraphWeight> {
    
    internal var marked : [Bool] = []
    internal var mst : [Edge<T>] = []
    
    //访问节点v
    internal func visit(_ v : Int) { }
    
}








