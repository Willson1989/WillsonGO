//
//  Graph_Weighted.swift
//  Play-with-Alorithms
//
//  Created by ZhengYi on 2017/6/14.
//  Copyright © 2017年 ZhengYi. All rights reserved.
//

import UIKit

// 链表实现邻接表时，顶点的数据结构
internal class Vertex {
    
    public var v : Int = -1
    public var firstArc : Edge? = nil
    
    init(vertex : Int) {
        self.v = vertex
        self.firstArc = nil
    }
}

// 有权图的边
public class Edge : Comparable , Equatable{
    
    internal var from : Int = INFINITY
    internal var to   : Int = INFINITY
    internal var weight :  Float = 0.0
    internal var next : Edge? = nil
    
    init(a : Int, b : Int, weight : Float) {
        self.from = a
        self.to = b
        self.weight = weight
    }
    
    init() {
        self.from = INFINITY
        self.to = INFINITY
        self.weight = 0.0
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
    
    public func wt() -> Float {
        return self.weight
    }
    
    public static func < (l : Edge, r : Edge) -> Bool {
        return l.weight < r.weight
    }
    
    public static func <= (l : Edge, r : Edge) -> Bool {
        return l.weight <= r.weight
    }
    
    public static func > (l : Edge, r : Edge) -> Bool {
        return l.weight > r.weight
    }
    
    public static func >= (l : Edge, r : Edge) -> Bool {
        return l.weight >= r.weight
    }
    
    public static func == (l : Edge, r : Edge) -> Bool {
        return l.weight == r.weight
    }
}

public class Graph_Weighted : Graph {

    public func addEdge(_ v : Int, _ w : Int, weight : Float) { }
}

/*
 最小生成树
 
    一个图可以生成最小生成树的前提是这个图是连通的
 切分定理：
    将一个图分成两个部分（一部分节点为蓝色，一部分节点为红色）
    连接两个部分的节点的边被称为 横切边。（即这个边的两个节点一个是红色一个是蓝色）
    在多个横切边中权值最小的边一定是这个图的最小生成树的一条边
 */
public class MST {
    
    internal var marked : [Bool] = []
    internal var mstArray : [Edge?] = []
    internal var mstTotalWeight : Float = 0.0
    internal var pq : IndexMinHeap_Map<Edge>!
    internal var capacity : Int = 0
    
    public init(capacity : Int) {
        self.capacity = capacity
        self.marked = Array(repeating: false, count: self.capacity)
        self.pq = IndexMinHeap_Map(capacity: self.capacity)
    }
    
    //Lazy Prim
    internal func GenericMST_lazyPrim() {
        //从第一个节点开始访问
        self.visit(0)
        
        while pq.isEmpty() == false {
            
            //取出最小权值的边
            let e = pq.extractMin()!
            
            //如果边的两个顶点都是红色，说明不是横切边,弃用
            if marked[e.V()] == marked[e.W()] {
                continue
            }
            
            self.mstArray.append(e)
            if marked[e.V()] == true {
                self.visit(e.W())
            } else {
                self.visit(e.V())
            }
        }
        
        //计算总权值
        for i in 0 ..< self.mstArray.count {
            if let e = self.mstArray[i] {
                self.mstTotalWeight += e.weight
            }
        }
    }
    
    //访问节点v
    internal func visit(_ v : Int) { }
    
    internal func result() -> Float {
        return mstTotalWeight
    }
    
    internal func mstEdges() -> [Edge?] {
        return mstArray
    }
    
    internal func showMST() {
        if mstArray.isEmpty {
            print("无最小生成树")
            return
        }
        print("最小生成树 ： ", separator: "", terminator: "\n")
        for i in 0 ..< mstArray.count {
            let e = mstArray[i]!
            print("[ \(e.V()) , \(e.W()) ], weight : \(e.wt())")
        }
        print("总权值 ： \(self.result())")
    }
}








