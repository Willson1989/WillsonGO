//
//  Graph_Weighted.swift
//  Play-with-Alorithms
//
//  Created by ZhengYi on 2017/6/14.
//  Copyright © 2017年 ZhengYi. All rights reserved.
//

import UIKit

public typealias EdgeWeight = Comparable & Equatable

//public typealias iteratorBlock_Weighted = (_ v : Int, _ weight : EdgeWeight) -> ()

// 链表实现邻接表时，顶点的数据结构
internal class Vertex<T : EdgeWeight> {
    
    public var v : Int = -1
    public var firstArc : Edge<T>? = nil
    
    init(vertex : Int) {
        self.v = vertex
        self.firstArc = nil
    }
}

// 有权图的边
public class Edge<T : EdgeWeight> {
    
    public var from : Int = INFINITY
    public var to   : Int = INFINITY
    public var weight : T? = nil
    public var next : Edge<T>? = nil
    
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
}

class Graph_Weighted<T : EdgeWeight> : Graph {

    public func addEdge(_ v : Int, _ w : Int, weight : T) {}
    
}









