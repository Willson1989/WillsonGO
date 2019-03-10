
//
//  Monad.swift
//  Learning
//
//  Created by 郑毅 on 2019/3/7.
//  Copyright © 2019 ZhengYi. All rights reserved.
//

import Foundation


protocol Monoid {
    typealias T = Self
    static var mEmpty : T { get } // 单位元
    func mAppend(_ w : T) -> T // 二元操作
}

struct AndBool : Monoid {                 
    var val : Bool
    
    init(_ val : Bool) {
        self.val = val
    }
    
    static var mEmpty: AndBool {
        return AndBool(true)
    }
    func mAppend(_ w: AndBool) -> AndBool {
        return AndBool(self.val && w.val)
    }
}

struct OrBool : Monoid {
    var val : Bool
    
    init(_ val : Bool) {
        self.val = val
    }
    
    static var mEmpty: OrBool {
        return OrBool(false)
    }
    func mAppend(_ w: OrBool) -> OrBool {
        return OrBool(self.val || w.val)
    }
}


struct Writter<D, R> where R : Monoid {
    var data : D
    var record : R
    
    init(data : D, record : R) {
        self.data = data
        self.record = record
    }
    
    static func ret(_ data : D) -> Writter<D,R> {
        return Writter(data: data, record: R.mEmpty)
    }
    
    func bind<O>(_ op : (D) -> Writter<O , R>) -> Writter<O, R> {
        let newWritter = op(self.data)
        let newData = newWritter.data
        let newRec = self.record.mAppend(newWritter.record)
        return Writter<O, R>(data: newData, record: newRec)
    }
}

precedencegroup Bind {
    associativity : left
    higherThan : TernaryPrecedence
}

infix operator >>- : Bind

func >>- <T, O, R>(lhs : Writter<T, R>, rhs : (T) -> Writter<O , R>) -> Writter<O ,R> {
    return lhs.bind(rhs)
}


enum Result<T>{
    case success(T)
    case fail(Error)
    
    func map<U>(_ f : (T) -> U) -> Result<U> {
        switch self {
        case .success(let x):
            return .success(f(x))
        case .fail(let err):
            return .fail(err)
        }
    }
    
    func apply<O>(_ R : Result<(T) -> O>) -> Result<O> {
        switch R {
        case .success(let function):
            return self.map(function)
        case .fail(let err):
            return .fail(err)
        }
    }
    
    func flatMap<O>(_ mapper : (T) -> Result<O>) -> Result<O> {
        switch self {
        case .success(let val):
            return mapper(val)
        case .fail(let err) :
            return  .fail(err)
        }
    }
    
    var value : Any {
        switch self {
        case .success(let val):
            return val
        case .fail(let err):
            return err
        }
    }
}


precedencegroup ChainingPrecedence {
    associativity: left
    higherThan: TernaryPrecedence
}
infix operator <^> : ChainingPrecedence
infix operator <*> : ChainingPrecedence
infix operator >>= : ChainingPrecedence

//// For Result
func <^> <T, O>(lhs : (T) -> O, rhs : Result<T>) -> Result<O> {
    return rhs.map(lhs)
}

func <*> <T,O>(lhs : Result<(T) -> O>, rhs : Result<T>) -> Result<O> {
    return rhs.apply(lhs)
}

func >>= <T, O>(lhs : Result<T>, rhs : (T) -> Result<O>) -> Result<O> {
    return lhs.flatMap(rhs)
}
