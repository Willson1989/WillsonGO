//
//  Solution_06.swift
//  Play-with-Alorithms
//
//  Created by 郑毅 on 2019/2/19.
//  Copyright © 2019 ZhengYi. All rights reserved.
//

import Foundation

/*
 二叉树的遍历
 参考：https://www.cnblogs.com/llguanli/p/7363657.html
 */
extension Solution {
    
    typealias NodeType = TreeNode<Int>
    // MARK: -------------- 二叉树的前序遍历 leetCode #144
    /*
     https://leetcode-cn.com/problems/binary-tree-preorder-traversal/
     */
    func preorderTraversal(_ root: NodeType?) -> [Int] {
        return _preorderTraversal_iteratoration(root)
    }
    
    // MARK: 前序遍历 非递归解法
    func _preorderTraversal_iteratoration(_ root: NodeType?) -> [Int] {
        var res = [Int]()
        let stk = BasicStack<NodeType>()
        var pNode : NodeType? = root
        while pNode != nil || !stk.isEmpty() {
            if let p = pNode {
                res.append(p.val)
                stk.push(p)
                pNode = p.left
                
            } else {
                let topNode = stk.top()!
                stk.pop()
                pNode = topNode.right
            }
        }
        return res
    }
    
    // MARK: 前序遍历 递归解法
    func _preorderTraversal_recursion(_ root: NodeType?) -> [Int] {
        var res = [Int]()
        __preorderTraversal_recursion(root, res: &res)
        return res
    }
    
    private func __preorderTraversal_recursion(_ node : NodeType?, res : inout [Int]) {
        if node == nil {
            return
        }
        res.append(node!.val)
        __preorderTraversal_recursion(node?.left, res: &res)
        __preorderTraversal_recursion(node?.right, res: &res)
    }
    
    // MARK: -------------- 二叉树的中序遍历 leetCode #94
    /*
     https://leetcode-cn.com/problems/binary-tree-inorder-traversal/
     */
    func inorderTraversal(_ root: NodeType?) -> [Int] {
        return _inorderTraversal_recursion(root)
    }
    
    // MARK: 中序遍历 非递归解法
    private func _inorderTraversal_iteratoration(_ root : NodeType?) -> [Int] {
        guard let root = root else { return [] }
        var pNode : NodeType? = root
        let stk = BasicStack<NodeType>()
        var res = [Int]()
        while pNode != nil || !stk.isEmpty() {
            if let p = pNode {
                stk.push(p)
                pNode = p.left
                
            } else { // pNode == nil
                let topNode = stk.top()!
                stk.pop()
                res.append(topNode.val)
                pNode = topNode.right
            }
        }        
        return res
    }
    
    // MARK: 中序遍历 递归解法
    private func _inorderTraversal_recursion(_ root : NodeType?) -> [Int] {
        var res = [Int]()
        __inorderTraversal_recursion(root, res: &res)
        return res
    }
    
    private func __inorderTraversal_recursion(_ node : NodeType?, res : inout [Int]) {
        if node == nil {
            return
        }
        __inorderTraversal_recursion(node!.left, res: &res)
        res.append(node!.val)
        __inorderTraversal_recursion(node!.right, res: &res)
    }
    
    
    // MARK: -------------- 二叉树的后序遍历 leetCode #145
    /*
     https://leetcode-cn.com/problems/binary-tree-postorder-traversal/
     */
    func postorderTraversal(_ root: NodeType?) -> [Int] {
        //return _postorderTraversal_recursion(root)
        return _postorderTraversal_iteratoration(root)
    }
    
    // MARK: 后序遍历 非递归解法：
    /*
     对于后序遍历，需要注意的一点是：对于一个结点p，要保证它的左子树和右子树都被访问过之后才能访问结点它自己，并且左子树是要先于右子树被访问的。
     对于先左后右的顺序，这里可以使用栈的数据结构来解决。还有对于当前的结点p，会有有以下几种处理情况：
        1. 结点p的左子树和右子树都没访问过，那么以右子树，左子树的顺序入栈
        2. 结点p是叶子结点，那么直接输出结点p
        3. 结点p的子树都被访问过了，输出结点p
     如何确定结点p的左右子树都被访问过呢？
     这里可以使用一个last变量来保存最后访问过的结点，
     那么如果 p.right == nil && last == p.left 或者 last == p.right 那么这个结点p的左右子树就都一定被访问过了。
     这里对上面的判断条件进行一下说明（假设p结点的左右子树都已经被访问过，并且last是最后被访问过的结点）：
        如果p的右子树不为nil，那么p的右子树一定是last（last == p.right）。
        如果p的右子树为nil，那么最后被访问过的结点就一定是左子树。
     参考：
     https://www.cnblogs.com/rain-lei/p/3705680.html
     */
    private func _postorderTraversal_iteratoration(_ root: NodeType?) -> [Int] {
        guard let root = root else {
            return []
        }
        var res = [Int]()
        let stk = BasicStack<NodeType>()
        var pNode = root
        var last = root
        stk.push(pNode)
        while !stk.isEmpty() {
            pNode = stk.top()!
            if ( pNode.left == nil && pNode.right == nil ) || // p是叶子结点
               ( pNode.right == nil && pNode.left === last ) || pNode.right === last  // p的左右子树都被访问过了
            {
                res.append(pNode.val)
                last = pNode
                stk.pop()
                
            } else {
                // p 不是叶子结点，并且p的左右子树都没有被访问过，**那么以右子树，左子树的顺序入栈**
                if let right = pNode.right {
                    stk.push(right)
                }
                if let left = pNode.left {
                    stk.push(left)
                }
            }
        }
        return res
    }
    
    // MARK: 后序遍历 递归解法：
    private func _postorderTraversal_recursion(_ root: NodeType?) -> [Int] {
        var res = [Int]()
        __postorderTraversal_recursion(root, res: &res)
        return res
    }
    
    private func __postorderTraversal_recursion(_ node : NodeType?, res : inout [Int]) {
        guard let node = node else {
            return
        }
        __postorderTraversal_recursion(node.left, res: &res)
        __postorderTraversal_recursion(node.right, res: &res)
        res.append(node.val)
    }
    

}



