//
//  LeetCode_MyCircularQueue.swift
//  Play-with-Alorithms
//
//  Created by 郑毅 on 2019/2/14.
//  Copyright © 2019 ZhengYi. All rights reserved.
//

import Foundation

// MARK: -------------- 设计循环队列 leetCode #622
/*
 https://leetcode-cn.com/problems/design-circular-queue/
 设计你的循环队列实现。 循环队列是一种线性数据结构，其操作表现基于 FIFO（先进先出）原则并且队尾被连接在队首之后以形成一个循环。
 它也被称为“环形缓冲器”。
 
 循环队列的一个好处是我们可以利用这个队列之前用过的空间。在一个普通队列里，一旦一个队列满了，我们就不能插入下一个元素，即使在队列前面仍有空间。
 但是使用循环队列，我们能使用这些空间去存储新的值。
 
 你的实现应该支持如下操作：
    MyCircularQueue(k): 构造器，设置队列长度为 k 。
    Front: 从队首获取元素。如果队列为空，返回 -1 。
    Rear: 获取队尾元素。如果队列为空，返回 -1 。
    enQueue(value): 向循环队列插入一个元素。如果成功插入则返回真。
    deQueue(): 从循环队列中删除一个元素。如果成功删除则返回真。
    isEmpty(): 检查循环队列是否为空。
    isFull(): 检查循环队列是否已满。
 
    MyCircularQueue circularQueue = new MycircularQueue(3); // 设置长度为 3
    circularQueue.enQueue(1);  // 返回 true
    circularQueue.enQueue(2);  // 返回 true
    circularQueue.enQueue(3);  // 返回 true
    circularQueue.enQueue(4);  // 返回 false，队列已满
    circularQueue.Rear();      // 返回 3
    circularQueue.isFull();    // 返回 true
    circularQueue.deQueue();   // 返回 true
    circularQueue.enQueue(4);  // 返回 true
    circularQueue.Rear();      // 返回 4
 
 演示 ： https://leetcode-cn.com/explore/learn/card/queue-stack/216/queue-first-in-first-out-data-structure/864/
 */

class MyCircularQueue {
    
    fileprivate var EmptyElem : Int = -1
    fileprivate var data   : [Int]
    fileprivate var p_head : Int = -1
    fileprivate var p_tail : Int = -1
    fileprivate var count  : Int = 0
    
    /** Initialize your data structure here. Set the size of the queue to be k. */
    init(_ k: Int) {
        data = Array(repeating: EmptyElem, count: k)
        count = 0
        p_head = -1
        p_tail = -1
    }
    
    /** Insert an element into the circular queue. Return true if the operation is successful. */
    func enQueue(_ value: Int) -> Bool {
        if isFull() {
            print("en queue : \(value), queue is full")
            return false
        }
        if isEmpty() {
            p_head = 0
            p_tail = 0
        } else {
            p_tail += 1
            if p_tail >= data.count {
                p_tail = 0
            }
        }
        data[p_tail] = value
        count += 1
        return true
    }
    
    /** Delete an element from the circular queue. Return true if the operation is successful. */
    func deQueue() -> Bool {
        if isEmpty() {
            print("dequeue , queue is already empty")
            return false
        }
        data[p_head] = EmptyElem
        count -= 1
        if count == 0 {
            print("dequeue to empty")

            p_head = -1
            p_tail = -1
        } else {
            p_head += 1
            if p_head >= data.count {
                p_head = 0
            }
        }
        return true
    }
    
    /** Get the front item from the queue. */
    func Front() -> Int {
        if isEmpty() {
            return -1
        }
        return data[p_head]
    }
    
    /** Get the last item from the queue. */
    func Rear() -> Int {
        if isEmpty() {
            return -1
        }
        return data[p_tail]
    }
    
    /** Checks whether the circular queue is empty or not. */
    func isEmpty() -> Bool {
        return count == 0
    }
    
    /** Checks whether the circular queue is full or not. */
    func isFull() -> Bool {
        return count == data.count
    }
}

class MyCircularQueue_LeetCodeSolution {
    
    fileprivate var EmptyElem : Int = -1
    fileprivate var data  : [Int]
    fileprivate var head  : Int = -1
    fileprivate var tail  : Int = -1
    fileprivate var count : Int = 0
    fileprivate var size  : Int = 0
    
    /** Initialize your data structure here. Set the size of the queue to be k. */
    init(_ k: Int) {
        data  = Array(repeating: EmptyElem, count: k)
        count = 0
        size  = k
        head  = -1
        tail  = -1
    }
    
    /** Insert an element into the circular queue. Return true if the operation is successful. */
    func enQueue(_ value: Int) -> Bool {
        if isFull() {
            print("en queue : \(value), queue is full")
            return false
        }
        if isEmpty() {
            head = 0
        }
        tail = (tail + 1) % size
        data[tail] = value
        count += 1
        return true
    }
    
    /** Delete an element from the circular queue. Return true if the operation is successful. */
    func deQueue() -> Bool {
        if isEmpty() {
            print("dequeue , queue is already empty")
            return false
        }
        if head == tail {
            head = -1
            tail = -1
            return true
        }
        head = (head + 1) % size
        count = max(0 , count - 1)
        return true
    }
    
    /** Get the front item from the queue. */
    func Front() -> Int {
        if isEmpty() {
            return -1
        }
        return data[head]
    }
    
    /** Get the last item from the queue. */
    func Rear() -> Int {
        if isEmpty() {
            return -1
        }
        return data[tail]
    }
    
    /** Checks whether the circular queue is empty or not. */
    func isEmpty() -> Bool {
        return head == -1
    }
    
    /** Checks whether the circular queue is full or not. */
    func isFull() -> Bool {
        return ((tail + 1) % size) == head
    }
}


/**
 * Your MyCircularQueue object will be instantiated and called as such:
 * let obj = MyCircularQueue(k)
 * let ret_1: Bool = obj.enQueue(value)
 * let ret_2: Bool = obj.deQueue()
 * let ret_3: Int = obj.Front()
 * let ret_4: Int = obj.Rear()
 * let ret_5: Bool = obj.isEmpty()
 * let ret_6: Bool = obj.isFull()
 */

