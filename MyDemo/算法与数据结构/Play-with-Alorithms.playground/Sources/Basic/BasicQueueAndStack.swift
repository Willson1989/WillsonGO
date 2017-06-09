import Foundation


public struct BasicQueue {
    
    fileprivate var queueArr : [Any]
    
    public init() {
        queueArr = [Any]()
    }
    
    public func front() -> Any? {
        if self.isEmpty() == true {
            return nil
        }
        return self.queueArr.first
    }
    
    public mutating func enqueue(_ obj : Any?) {
        if obj == nil {
            return
        }
        self.queueArr.append(obj!)
    }
    
    public mutating func dequeue(){
        if self.isEmpty() == true {
            return
        }
        self.queueArr.removeFirst()
    }
    
    public func isEmpty() -> Bool {
        return self.queueArr.count == 0
    }
    
    public func size() -> Int {
        return self.queueArr.count
    }
}


public struct BasicStack {
    
    fileprivate var stackArr : [Any]
    
    public init() {
        self.stackArr = [Any]()
    }
    
    public mutating func push(_ obj : Any) {
        self.stackArr.append(obj)
    }
    
    public mutating func pop() -> Any? {
        if self.stackArr.isEmpty == true {
            return nil
        }
        let last = self.stackArr.last
        self.stackArr.removeLast()
        return last
    }
    
    public func isEmpty() -> Bool {
        return self.stackArr.count == 0
    }
    
    public func size() -> Int {
        return self.stackArr.count
    }
}
