//
//  ViewController.swift
//  Learning
//
//  Created by 郑毅 on 2019/3/5.
//  Copyright © 2019 ZhengYi. All rights reserved.
//

import UIKit
import Curry

struct Person {
    var name : String
    var age : String
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

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .orange
//        let info = ["name" : "willson", "age" : "22", "nick" : "hero"]
        
//        if let res = Person.parseDicToPerson(info).value as? Person {
//            print(res)
//        }
//
//        let res = Result.success(3).map(makeDouble)
//
//        let tempa = [true, true ,true, true]
//
//        let res1 = tempa.map(AndBool.init).reduce(AndBool.mEmpty) { (res, item) -> AndBool in
//            return res.mAppend(item)
//        }
//        print("res1 : \(res1.val)")
        let w = testWritter()
        print("testWritter res : \(w.data), log : \(w.record)")
        
        testScoreWritter()
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 这里的链式调用的各个函数需要满足的条件是，当前函数的输入值类型和上一个函数的输出的上下文中包裹的关联值的类型必须一致
        // 及当前的输入是上一个的输出。
//        let res = fetchFromDB(6) >>= requestData >>= parsToDic >>= convertToModel
//        if let personInfo = res.value as? Person {
//            print(personInfo)
//        }
        let vc = SuggestionsViewController()
        self.navigationController?.pushViewController(vc, animated: true)
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
