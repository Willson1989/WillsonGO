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
        from = INFINITY
        to = INFINITY
        weight = 0.0
    }
    
    //指定一个顶点，返回与之连接的另一个顶点
    public func other(_ v : Int) -> Int {
        if v == from {
            return to
        } else {
            return from
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





