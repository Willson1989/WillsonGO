//
//  SelfBalanceTree.swift
//  Play-with-Alorithms
//
//  Created by 郑毅 on 2020/9/23.
//  Copyright © 2020 ZhengYi. All rights reserved.
//

import Foundation

/*
 二叉树的搜索效率是 O(logN) ，但是当顺序插入元素之后，二叉搜索树就退化成了单链表，时间复杂度退化成了O(N)
 所以当插入和删除结点的时候，要时刻检查二叉树是否平衡，如果不平衡，要通过旋转（左旋，右旋）来调整到平衡的状态（左右子树高度差的绝对值最大为1）
 调整平衡后的二叉搜索树被称为平衡二叉树，也叫自平衡二叉搜索树（Self-Balancing Binary Search Tree）
 https://www.jianshu.com/p/655d83f9ba7b
 https://blog.csdn.net/isunbin/article/details/81707606
 */
class BalancedBinaryTree<T: Comparable> {
    typealias NodeValue = T
    typealias NodeClosure = (Node?) -> Void

    class Node {
        var val: NodeValue
        var left: Node?
        var right: Node?
        var height: Int = 1
        var size: Int = 1
        init(val: NodeValue) {
            self.val = val
        }
    }

    fileprivate var root: Node?

    // MARK: - public

    init(arr: [NodeValue]) {
        arr.forEach { insert($0) }
    }

    public func insert(_ val: NodeValue) {
        root = _insert(root, val: val)
    }

    public func delete(_ val: NodeValue) {
        root = _delete(root, val: val)
    }

    public func preOrder(_ closure: NodeClosure) {
        _preOrder(root, closure)
    }

    public func inOrder(_ closure: NodeClosure) {
        _inOrder(root, closure)
    }

    public func postOrder(_ closure: NodeClosure) {
        _postOrder(root, closure)
    }

    public func search(_ value: NodeValue) -> Node? {
        return _search(root, value)
    }

    public func contain(_ value: NodeValue) -> Bool {
        return search(value) != nil
    }

    public func size() -> Int {
        return root?.size ?? 0
    }

    public func ceil(_ val: NodeValue) -> Node? {
        return _ceil(root, val: val)
    }

    public func floor(_ val: NodeValue) -> Node? {
        return _floor(root, val: val)
    }

    // MARK: - private

    fileprivate func _insert(_ node: Node?, val: NodeValue) -> Node? {
        guard let node = node else {
            return Node(val: val)
        }
        if node.val == val {
            return node
        } else if node.val > val {
            node.left = _insert(node.left, val: val)
        } else {
            node.right = _insert(node.right, val: val)
        }
        let newNode = _checkBalance(node)
        return newNode
    }

    fileprivate func _delete(_ node: Node?, val: NodeValue) -> Node? {
        guard let node = node else {
            return nil
        }
        if val > node.val {
            node.right = _delete(node.right, val: val)
        } else if val < node.val {
            node.left = _delete(node.left, val: val)
        } else {
            if node.left == nil {
                return node.right
            }
            if node.right == nil {
                return node.left
            }
            let newNode = _findMin(node.right)
            let newRight = _deleteMin(node.right)
            newNode?.left = node.left
            newNode?.right = newRight
            _updateSize(newRight)
            _updateSize(newNode)
            return newNode
        }
        return _checkBalance(node)
    }

    fileprivate func _deleteMin(_ node: Node?) -> Node? {
        guard let node = node else {
            return nil
        }
        if node.left == nil {
            return node.right
        }
        if node.left?.left == nil {
            node.left = node.left?.right
            return _checkBalance(node)
        }
        return _deleteMin(node.left)
    }

    fileprivate func _checkBalance(_ node: Node?) -> Node? {
        guard let node = node else {
            return nil
        }
        let heightDiff = _heightDiff(node)
        if abs(heightDiff) < 2 {
            _updateHeight(node)
            _updateSize(node)
        } else if heightDiff >= 2 {
            if _heightDiff(node.left) <= -1 {
                node.left = _left_rotate(node.left)
            }
            return _right_rotate(node)
        } else if heightDiff <= -2 {
            if _heightDiff(node.right) >= 1 {
                node.right = _right_rotate(node.right)
            }
            return _left_rotate(node)
        }
        return node
    }

    fileprivate func _left_rotate(_ node: Node?) -> Node? {
        guard let node = node else {
            return nil
        }
        let right = node.right
        node.right = right?.left
        right?.left = node
        _updateHeight(node)
        _updateHeight(right)
        _updateSize(node)
        _updateSize(right)
        return right
    }

    fileprivate func _right_rotate(_ node: Node?) -> Node? {
        guard let node = node else {
            return nil
        }
        let left = node.left
        node.left = left?.right
        left?.right = node
        _updateHeight(node)
        _updateHeight(left)
        _updateSize(node)
        _updateSize(left)
        return left
    }

    fileprivate func _heightDiff(_ node: Node?) -> Int {
        guard let node = node else {
            return 0
        }
        if let left = node.left, let right = node.right {
            return left.height - right.height
        } else if let left = node.left {
            return left.height
        } else if let right = node.right {
            return -right.height
        }
        return 0
    }

    fileprivate func _updateHeight(_ node: Node?) {
        node?.height = max(node?.left?.height ?? 0, node?.right?.height ?? 0) + 1
    }

    fileprivate func _updateSize(_ node: Node?) {
        node?.size = _size(node?.left) + _size(node?.right) + 1
    }

    fileprivate func _preOrder(_ node: Node?, _ closure: NodeClosure) {
        guard let node = node else {
            return
        }
        closure(node)
        _preOrder(node.left, closure)
        _preOrder(node.right, closure)
    }

    fileprivate func _inOrder(_ node: Node?, _ closure: NodeClosure) {
        guard let node = node else {
            return
        }
        _inOrder(node.left, closure)
        closure(node)
        _inOrder(node.right, closure)
    }

    fileprivate func _postOrder(_ node: Node?, _ closure: NodeClosure) {
        guard let node = node else {
            return
        }
        _postOrder(node.left, closure)
        _postOrder(node.right, closure)
        closure(node)
    }

    fileprivate func _search(_ node: Node?, _ val: NodeValue) -> Node? {
        guard let node = node else {
            return nil
        }
        if node.val == val {
            return node
        } else if node.val < val {
            return _search(node.right, val)
        } else {
            return _search(node.left, val)
        }
    }

    fileprivate func _findMax(_ node: Node?) -> Node? {
        if node?.right == nil {
            return node
        }
        return _findMax(node?.right)
    }

    fileprivate func _findMin(_ node: Node?) -> Node? {
        if node?.left == nil {
            return node
        }
        return _findMin(node?.left)
    }

    fileprivate func _ceil(_ node: Node?, val: NodeValue) -> Node? {
        guard let node = node else {
            return nil
        }
        if node.val == val {
            return node
        } else if node.val > val {
            let res = _ceil(node.left, val: val)
            return res == nil ? node : res
        } else {
            return _ceil(node.right, val: val)
        }
    }

    fileprivate func _floor(_ node: Node?, val: NodeValue) -> Node? {
        guard let node = node else {
            return nil
        }
        if node.val == val {
            return node
        } else if node.val < val {
            let res = _floor(node.right, val: val)
            return res == nil ? node : res
        } else {
            return _floor(node.left, val: val)
        }
    }

    fileprivate func _size(_ node: Node?) -> Int {
        return node == nil ? 0 : node!.size
    }
}
