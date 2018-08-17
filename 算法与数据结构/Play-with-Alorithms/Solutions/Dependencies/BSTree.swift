//
//  BSTree.swift
//  TempProj
//
//  Created by 朱金倩 on 2018/8/11.
//  Copyright © 2018年 ZhengYi. All rights reserved.
//

import Foundation

class TreeNode<T> {
    
    var left : TreeNode?
    var right : TreeNode?
    var value : T
    
    init( _ value : T) {
        self.value = value
    }
}

class BSTree_Int {
    
    typealias NodeType = TreeNode<Int>
    
    class Queue {
        var left = [NodeType]()
        var right = [NodeType]()
        var isEmpty : Bool {
            return self.left.isEmpty && self.right.isEmpty
        }
        
        func enqueue(_ e : NodeType?) {
            if let e = e {
                right.append(e)
            }
        }
        
        func dequeue() -> NodeType? {
            if left.isEmpty {
                left = right.reversed()
                right.removeAll()
            }
            return left.popLast()
        }
        
        func front() -> NodeType? {
            if self.isEmpty {
                return nil
            }
            return left.last
        }
    }
    
    var root : NodeType?
    
    init() {
        self.root = nil
    }
    
    convenience init (arrangeWithArray a : [Int]) {
        self.init()
        self.root = TreeNode(a[0])
        let q = Queue()
        for i in 1 ..< a.count {
            q.enqueue(TreeNode(a[i]))
        }
        func gen(_ n : NodeType) {
            while q.isEmpty == false {
                let tmp = q.dequeue()
                if n.left == nil {
                    n.left = tmp
                }
                if n.right == nil {
                    n.right = tmp
                }
                
            }
        }
    }
    
    convenience init (array : [Int]) {
        self.init()
        for i in 0 ..< array.count {
            let node = TreeNode(array[i])
            insert(node)
        }
    }
    
    func deep(_ root : NodeType?) -> Int {
        if root == nil {
            return 0
        }
        return max(deep(root?.left), deep(root?.right)) + 1
    }
    
    func insert(_ node : NodeType?) {
        if let node = node {
            self.root = _insert(root: self.root, node: node)            
        }
    }
    
    private func _insert(root : NodeType?, node : NodeType) -> NodeType?{
        
        if root == nil {
            return node
        }
        
        let r = root!
        
        if node.value < r.value {
            r.left = _insert(root: r.left, node: node)
        } else {
            r.right = _insert(root: r.right, node: node)
        }
        
        return r
    }
    
    func prevEnumTree(_ node : NodeType?) {
        if let node = node {
            print(node.value, separator: "", terminator: ", ")
            prevEnumTree(node.left)
            prevEnumTree(node.right)
        }
    }
    
    func middleEnumTree(_ node : NodeType?) {
        if let node = node {
            middleEnumTree(node.left)
            print(node.value, separator: "", terminator: ", ")
            middleEnumTree(node.right)
        }
    }
    
    func postEnumTree(_ node : NodeType?) {
        if let node = node {
            postEnumTree(node.left)
            postEnumTree(node.right)
            print(node.value, separator: "", terminator: ", ")
        }
    }
    
    func bfs(_ node : NodeType?, enumHandler:(NodeType) -> ()) {
        if let node = node {
            let q = Queue()
            q.enqueue(node)
            while q.isEmpty == false {
                
                let tmp = q.dequeue()!
                enumHandler(tmp)
                
                if let left = tmp.left {
                    q.enqueue(left)
                }
                if let right = tmp.left {
                    q.enqueue(right)
                }
                
            }
        }
    }
}




