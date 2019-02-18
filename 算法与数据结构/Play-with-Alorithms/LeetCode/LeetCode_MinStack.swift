//
//  LeetCode_MinStack.swift
//  Play-with-Alorithms
//
//  Created by 郑毅 on 2019/2/18.
//  Copyright © 2019 ZhengYi. All rights reserved.
//

import Foundation

/*
 设计一个支持 push，pop，top 操作，并能在常数时间内检索到最小元素的栈。
 
 push(x) -- 将元素 x 推入栈中。
 pop() -- 删除栈顶的元素。
 top() -- 获取栈顶元素。
 getMin() -- 检索栈中的最小元素。
 示例:
 
 MinStack minStack = new MinStack();
 minStack.push(-2);
 minStack.push(0);
 minStack.push(-3);
 minStack.getMin();   --> 返回 -3.
 minStack.pop();
 minStack.top();      --> 返回 0.
 minStack.getMin();   --> 返回 -2.
 */
class MinStack {
    
    fileprivate var minItems = [Int]()
    fileprivate var data = [Int]()
    
    init() {
        
    }
    
    func push(_ x: Int) {
        if data.isEmpty {
            minItems.append(x)
            data.append(x)
        } else {
            data.append(x)
            if x <= minItems.last! {
                minItems.append(x)
            }
        }
    }
    
    func pop() {
        if data.isEmpty {
            return
        }
        let last = data.last!
        let min  = minItems.last!
        if last == min {
            minItems.removeLast()
        }
        data.removeLast()
    }
    
    func top() -> Int {
        if data.isEmpty {
            return -1
        }
        return data.last!
    }
    
    func getMin() -> Int {
        if minItems.isEmpty {
            return Int.min
        }
        return minItems.last!
    }
}
