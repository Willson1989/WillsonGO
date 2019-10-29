//
//  ViewController.swift
//  Learning
//
//  Created by 郑毅 on 2019/3/5.
//  Copyright © 2019 ZhengYi. All rights reserved.
//

import UIKit
import Curry
import RxSwift
import RxCocoa

struct Person {
    var name : String
    var age  : String
    var nick : String
    
    static func parseDicToPerson(_ dic : [String : String]) -> Result<Person> {
        let curryed = curry(Person.init) // (String) -> (String) -> (String) -> Person
        let res = curryed
            <^> Result.success(dic["name"]!)
            <*> Result.success(dic["age"]!)
            <*> Result.success(dic["nick"]!)
        
        return res
    }
}


enum MyError : Error {
    case normal
}

class ViewController: UIViewController {

    var tempSubject = PublishSubject<Int>()
    var bag = DisposeBag()
    
    override func viewDidLoad() {
        self.view.backgroundColor = .purple
        super.viewDidLoad()
        bind()
    }
    
    func bind() {
        tempSubject.subscribe(onNext: { n in
            print("the num : ",n)
        })
        .disposed(by: bag)
    }
    
    func tempReq() {
        Observable<Int>.create({ (ob) -> Disposable in
            
            let dispose = Disposables.create {
                
            }
            
            ob.onError(ZYError.init(desc: "normal error", code: -898))
            
            return dispose
            
        })
        .throttle(2.0, scheduler: MainScheduler.instance)
        .flatMapLatest { Observable<Int>.just($0) }
        .subscribe(tempSubject)
        .disposed(by: bag)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.tempSubject.onNext(99)
        self.tempReq()
        // 这里的链式调用的各个函数需要满足的条件是，当前函数的输入值类型和上一个函数的输出的上下文中包裹的关联值的类型必须一致
        // 及当前的输入是上一个的输出。
        //        let res = fetchFromDB(6) >>= requestData >>= parsToDic >>= convertToModel
        //        if let personInfo = res.value as? Person {
        //            print(personInfo)
        //        }
        //        let vc = AlamofireDemoVC()
        //        let vc = GCDDemoViewController()
        //        let vc = TextKitDemoViewController()
        //
        //        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func fetchFromDB(_ cond : Int) -> Result<String> {
        return Result.success(cond > 5 ? "1" : "2")
    }

    func requestData(_ param : String) -> Result<Int> {
        return Result.success(param == "1" ? 100 : 200)
    }

    func parsToDic(_ code : Int) -> Result<[String : String]> {
        return Result.success(["name" : "zhengyi", "age" : "22", "nick" : "hero"])
    }

    func convertToModel(_ dic : [String : String]) -> Result<Person> {
        return Person.parseDicToPerson(dic)
    }
    
    func makeDouble(_ x : Int) -> Int {
        return x * 2
    }

}


extension String : Monoid {
    static var mEmpty: String {
        return ""
    }
    func mAppend(_ w: String) -> String {
        return (self + w)
    }
}

typealias ZYWritter = Writter<Double, String>

func testWritter() -> ZYWritter {
    let res = ZYWritter.ret(9) >>- add(3) >>- add(2) >>- add(6) >>- sub(2) >>- muti(5) >>- divide(4)
    return res
}

func add(_ x : Double) -> (Double) -> ZYWritter {
    return { (other : Double) -> ZYWritter in
        let new : Double = other + x
        let rec = "added \(x)"
        return ZYWritter(data: new, record: rec)
    }
}

func sub(_ x : Double) -> (Double) -> ZYWritter {
    return {ZYWritter(data: $0 - x, record: "subed \(x)=\($0 - x) ")}
}

func muti(_ x : Double) -> (Double) -> ZYWritter {
    return {ZYWritter(data: $0 * x, record: "mutied \(x)=\($0 * x) ")}
}

func divide(_ x : Double) -> (Double) -> ZYWritter {
    return {ZYWritter(data: $0 / x, record: "divide \(x)=\($0 / x) ")}
}



typealias ScoreWritter = Writter<Int, AndBool>

func append(_ s : Int) -> (Int) -> ScoreWritter {
    return {(currS : Int) -> ScoreWritter in
        return ScoreWritter(data: currS + s, record: AndBool(s >= 60))
    }
}

func testScoreWritter() {
    let sArr = [10,90,80,67,70,99]
    let final = sArr.reduce(ScoreWritter.ret(0)) { (res, score) -> ScoreWritter in
        return res >>- append(score)
    }
    
    print("total score : \(final.data), all over than 60 : \(final.record.val)")
}


class Functor<V> {
    
    var val : V
    
    init(val : V) {
        self.val = val
    }
    
    func map<R>(_ f : (V) -> R) -> R {
        return f(self.val)
    }
}

class Applicative<V> : Functor<V> {
    
    func apply<F,R>(_ mf : F) -> R where F : Applicative<(V) -> R> {
        return self.map(mf.val)
    }
}

class Monad<V> : Functor<V> {
    func flatMap<M, R>(_ f : (V) -> M) -> M where M : Monad<R> {
        return f(self.val)
    }
    
    func bind<R>(_ f : (V) -> R) -> Monad<R> {
        let res = f(self.val)
        return Monad<R>(val: res)
    }
}

func drawPyramid(_ n : Int) {
    for i in 1 ... n {
        var s = ""
        for _ in 0 ... n-i {
            s += " "
        }
        for _ in 1 ... 2 * i - 1 {
            s += "*"
        }
        print(s)
    }
}

func myFactorial( _ n : Int) -> Int {
    return n == 1 ? 1 : n * myFactorial(n-1)
}

func myRound(_ n : Float) -> Int {
    let t = Int(n * 10)
    return (t % 5) < 5 ? Int(t) : Int(t+1)
}


protocol Initializable {
    var value : String { get }
    init()
}

protocol Skill {
    associatedtype SkillItem : Initializable
    func doSkill() -> SkillItem
}

extension Skill {
    func doSkill() -> SkillItem {
        let i = SkillItem()
        print("do skill !!! ", i.value)
        return i
    }
}

struct Gun : Initializable {
    var value: String = "This is Gun"
    
}

struct Aex : Initializable {
    var value: String = "This is Aex"

}

struct Hand : Initializable {
    var value: String = "This is Hand"

}

struct P1 : Skill {
    typealias SkillItem = Gun
}

struct P2 : Skill {
    typealias SkillItem = Aex
}

struct P3 : Skill {
    typealias SkillItem = Hand
}

struct PromiseError : Error {
    
}

class Promise<T> {
    typealias ResolveCallBack = (T) -> Void
    typealias RejectCallBack = (PromiseError) -> Void
    typealias TaskCallBack = (@escaping ResolveCallBack, @escaping RejectCallBack) -> Void
    
    private var task : TaskCallBack?
    private var resolveCallback : ResolveCallBack?
    private var rejectCallback : RejectCallBack?

    
    init(_ task : @escaping TaskCallBack) {
        self.task = task
    }
    
    func success(_ callback : @escaping ResolveCallBack) {
        self.resolveCallback = callback
        self.task?({ [weak self] res in
            guard let wself = self else { return }
            wself.resolve(res)
        },
        { [weak self]  error in
            guard let wself = self else { return }
            wself.reject(error)
        })
    }
    
    func then<U>(_ f : @escaping (T) -> Promise<U>) -> Promise<U> {
        return Promise<U> { (resolve, reject) in
            self.task?({ res in
                let wrapped = f(res)
                wrapped.success(resolve)
            },
            { error in
                reject(error)
            })
        }
    }
    
    func fail(_ callback : @escaping RejectCallBack) {
        self.rejectCallback = callback
    }
    
    private func resolve(_ res : T) {
        self.resolveCallback?(res)
    }
    
    private func reject(_ error : PromiseError) {
        self.rejectCallback?(error)
    }
}
