//
//  SuggestionsViewController.swift
//  Learning
//
//  Created by 郑毅 on 2019/3/5.
//  Copyright © 2019 ZhengYi. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class SuggestionsViewController: UIViewController {
    
    var disposeBag = DisposeBag()
    
    lazy var label : UILabel = {
        let lb = UILabel()
        lb.backgroundColor = .orange
        lb.textColor = .black
        self.view.addSubview(lb)
        return lb
    }()
    
    lazy var textField : UITextField = {
        let tf = UITextField()
        self.view.addSubview(tf)
        tf.backgroundColor = .lightGray
        return tf
    }()
    
    lazy var textField_new : UITextField = {
        let tf = UITextField()
        self.view.addSubview(tf)
        tf.backgroundColor = .lightGray
        return tf
    }()
    
    lazy var button1 : UIButton = {
        let btn = UIButton(type: .custom)
        btn.backgroundColor = .blue
        btn.setTitle("默认", for: UIControl.State.normal)
        btn.setTitle("选中", for: UIControl.State.selected)
        self.view.addSubview(btn)
        return btn
    }()
    
    lazy var button2 : UIButton = {
        let btn = UIButton(type: .custom)
        btn.backgroundColor = .blue
        btn.setTitle("默认", for: UIControl.State.normal)
        btn.setTitle("选中", for: UIControl.State.selected)
        self.view.addSubview(btn)
        return btn
    }()
    
    lazy var button3 : UIButton = {
        let btn = UIButton(type: .custom)
        btn.backgroundColor = .blue
        btn.setTitle("默认", for: UIControl.State.normal)
        btn.setTitle("选中", for: UIControl.State.selected)
        self.view.addSubview(btn)
        return btn
    }()
    
    lazy var tempSwitch : UISwitch = {
        let swt = UISwitch()
        self.view.addSubview(swt)
        return swt
    }()
    
    class UserViewModel {
        
        var userName = BehaviorRelay<String>(value: "")
        var userNameDispose : Disposable?
        
        
        init() {
            self.userNameDispose = self.userName.subscribe { (event) in
                print("user name did changed : ",event.element ?? "null")
            }
        }
        
        deinit {
            self.userNameDispose?.dispose()
        }
    }
    
    var vm = UserViewModel()

    override func viewDidLoad() {
        
        print("========== SuggestionsViewController view did load")
        super.viewDidLoad()
        self.view.backgroundColor = .purple
        self.placeViews()
        
        Observable<Int>.create { (ob) -> Disposable in
            return Disposables.create()
        }
        
//        let txt = self.textField.rx.text.orEmpty
//        txt.bind(to: vm.userName).disposed(by: self.disposeBag)
//        vm.userName.bind(to: self.textField.rx.text).disposed(by: self.disposeBag)
//        vm.userName.bind(to: self.label.rx.text).disposed(by: self.disposeBag)
//        let ob = self.button1.rx.tap.asObservable().flatMap { Observable<String>.just("") }
//        let newOb = ob.withLatestFrom(vm.userName.asObservable())
//        newOb.bind(to: self.textField_new.rx.text).disposed(by: self.disposeBag)
//
//        let button3Tap = self.button3.rx.tap
//        button3Tap.subscribe { [weak self](_) in
//            guard let wself = self else { return }
//            let vc = RXSearchListVC()//RXTableViewDemoVC()
//            wself.navigationController?.pushViewController(vc, animated: true)
//        }.disposed(by: self.disposeBag)
        
//        let txt = self.textField.rx.text.orEmpty
//        txt.bind(to: self.label.rx.text).disposed(by: self.disposeBag)
//        txt.asDriver().drive(self.label.rx.text).disposed(by: self.disposeBag)
//        self.button.rx.controlEvent([UIControlEvents.touchDown, UIControlEvents.touchUpInside])
//        .subscribe { (e) in
//                print("aaa")
//        }.disposed(by: self.disposeBag)
        
//        let ob = Observable.combineLatest([self.textField.rx.text.orEmpty.asObservable(),
//                                           self.textField_new.rx.text.orEmpty.asObservable()])
//        ob.map { (txtArr) -> String in
//            return "\(txtArr[0].count + txtArr[1].count)"
//        }
//        .bind(to: self.label.rx.text)
//        .disposed(by: self.disposeBag)
//        button1.isSelected = true
//        let buttons : [UIButton] = [button1, button2, button3]
//        let ob = Observable.from(buttons).flatMap { (btn) -> Observable<UIButton> in
//            print("flat map ", btn)
//            let res = btn.rx.tap.map({ (_) -> UIButton in
//                print("tap map ", btn)
//                return btn
//            })
//            return res
//        }.share(replay: 1, scope: .forever)
//
//        for button in buttons {
//            ob.map { (btn) -> Bool in
//                print("ob map ", button)
//                return btn == button
//            }
//            .bind(to: button.rx.isSelected)
//            .disposed(by: self.disposeBag)
//        }
//
//        let isOn = self.tempSwitch.rx.isOn.asObservable()
//        //UIApplication.shared.rx.isNetworkActivityIndicatorVisible
//        isOn.bind(to: self.button2.rx.isSelected).disposed(by: self.disposeBag)
//        isOn.bind(to: UIApplication.shared.rx.isNetworkActivityIndicatorVisible).disposed(by: self.disposeBag)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //self.untilNotifier.onNext(299)
//        self.cutDownConnectOb?.subscribe({ (eee) in
//            print("cut down ob : ", eee)
//        }).disposed(by: self.disposeBag)
        Observable<Int>.interval(1, scheduler: MainScheduler.instance).subscribe(onNext: {
            [unowned self] (elem) in
            self.testTimeoutOb.onNext(elem)
        }).disposed(by: self.disposeBag)
    }
    
    // 条件和布尔操作符（Conditional and Boolean Operators）
    var untilNotifier = PublishSubject<Int>()
    
    func delay(_ delay : Double, clouser : @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            clouser()
        }
    }
    
    typealias ablock = (_ a : Int) -> Int
    typealias bblock = (_ block : @escaping ablock) -> Int
    enum TempError : Error {
        case someError
    }
    
    // MARK: - 特征序列4：subscribeOn 与 observeOn
    func testObservable_15() {
        
        /*
         subscribeOn 决定数据序列的构建函数在哪个 Scheduler 上运行。
         如下面代码创建Observable的create方法里面的block就是运行在子线程里面的，
         因为subscribeOn指定了ConcurrentDispatchQueueScheduler。
         
         observeOn 决定在哪个 Scheduler 上监听这个数据序列。
         比如下面调用了 observeOn(MainScheduler.instance) 之后的subscribe方法的block就是运行在主线程里面的。
         还有需要注意的是，如果在map之前调用了 observeOn 指定了线程A，那么map里面的方法就运行在线程A里面
         如果在map之后调用了observeOn，那么map里面的方法就运行在subscribeOn指定的线程里面。
         
         */
        let ob = Observable<Int>.create { (ob) -> Disposable in
            print(" ob create ", Thread.current)
            for i in 0 ..< 1
            {
                ob.onNext(i)
            }
            return Disposables.create()
        }
        ob
        .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .userInitiated))
        .observeOn(MainScheduler.instance)
        .map { (n) -> Int in
            print("map : ", Thread.current)
            return n * 2
        }
        .subscribe { (e) in
            print("subscribe : ", Thread.current)
            print(e)
        }
        .disposed(by: self.disposeBag)
    }

    // MARK: - 特征序列3：ControlProperty、ControlEvent
    func testObservable_14() {
        
        /*
         ControlProperty 通常描述一个控件的属性，如 self.textField.rx.text
         ControlEvent 通常描述一个控件的事件，如点击事件，比方说UIButton的self.button.rx.tap即使UIButton的touchUpInside
         ControlProperty 和 ControlEvent 的特征和Driver类似：
         1. 不会发送error事件
         2. 在主线程订阅、在主线程监听
         3. 状态共享
         */
        func test_ControlProperty() {
            let cp = self.textField.rx.text
            //cp.subscribe(self.label.rx.text).disposed(by: self.disposeBag)
            cp.bind(to: self.label.rx.text).disposed(by: self.disposeBag)
        }
        
        func test_ControlEvent() {
            let ce = self.button1.rx.tap
            ce.map { (_) -> UIColor in
                let r = CGFloat((arc4random() % 255)) / 255.0
                let g = CGFloat((arc4random() % 255)) / 255.0
                let b = CGFloat((arc4random() % 255)) / 255.0
                return UIColor(displayP3Red: r, green: g, blue: b, alpha: 1.0)
            }.bind(to: self.label.rx.cus_backgroundColor).disposed(by: self.disposeBag)
        }
        
        //test_ControlProperty()
        test_ControlEvent()
    }
    
    // MARK: - 特征序列2：Driver
    func testObservable_13() {
        
        let ob = self.button1.rx.tap
        ob.map { (elem) -> UIColor in
            let r = CGFloat((arc4random() % 255)) / 255.0
            let g = CGFloat((arc4random() % 255)) / 255.0
            let b = CGFloat((arc4random() % 255)) / 255.0
            return UIColor(displayP3Red: r, green: g, blue: b, alpha: 1.0)
        }.bind(to: self.label.rx_backgroundColor)
        .disposed(by: self.disposeBag)
        
    
        func test() {
            //let ob = Observable<Int>.of(1,2,3,4)
            let ob = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
            .map { (elem) -> Int in
                print("map func")
                return elem + 2
            }.share(replay: 1, scope: .forever)

            ob.subscribe { (e) in
                print("aaa " , e)
            }.disposed(by: disposeBag)
            
            ob.subscribe { (e) in
                print("bbb " , e)
            }.disposed(by: disposeBag)
        }
        
        func test_driver() {
            
            let ob = self.textField.rx.text
            let res = ob.asDriver()
            .throttle(0.3)
            .map { (t) -> Int in
                return t == nil ? 0 : t!.count
            }
            .flatMapLatest { (count) -> SharedSequence<DriverSharingStrategy, String> in
                let ob = Observable<String>.create({ (observer) -> Disposable in
                    let interval = Double(arc4random() % 5)
                    self.delay(interval, clouser: {
                        observer.onNext("txt count - \(count)")
                    })
                    return Disposables.create()
                })
                return ob.asDriver(onErrorJustReturn: "txt count - 0")
            }
            
        
            
            res.drive(self.label.rx.text).disposed(by: self.disposeBag)
            res.map { (_) -> UIColor in
                let r = CGFloat((arc4random() % 255)) / 255.0
                let g = CGFloat((arc4random() % 255)) / 255.0
                let b = CGFloat((arc4random() % 255)) / 255.0
                return UIColor(displayP3Red: r, green: g, blue: b, alpha: 1.0)
            }.drive(self.label.rx.cus_backgroundColor)
            .disposed(by: self.disposeBag)
        }
        
        func test_shareReplay() {
            let srcOb = Observable<Int>.of(1,2,3,4,5,6,7)
            let ob = srcOb.map { (elem) -> Int in
                print("map : \(elem)")
                return elem * 2
                }.share(replay: 3, scope: .forever)
            
            ob.subscribe { (e) in
                print("subscribe 1 : ", e)
                }.disposed(by: disposeBag)
            
            
            ob.subscribe { (e) in
                print("subscribe 2 : ", e)
                }.disposed(by: disposeBag)
        }
        //test()
        //test_shareReplay()
        test_driver()
    }
    
    
    // MARK: - 特征序列1：Single、Completable、Maybe
    func testObservable_12() {
        
        func test_Maybe() {
            /*
             Maybe 同样是Observable的变体，它结余Completable（completed事件或者error事件）和Single（success事件或者error事件）
             Maybe 也是只能发送一个元素，它要么发送success事件，要么是completed事件，要么是一个error事件
             */
            
            func test_Maybe_AsMaybe() {
                /*
                 普通的Observable可以通过asMaybe方法生成一个Maybe序列，但是如果Observable里面包含多个事件元素，或者Observable是定时发送事件的序列。
                 那么这个生成的Maybe序列只会发出一个error事件。
                 */
                let ob = Observable<Int>.of(1)
                //let ob = Observable<Int>.interval(0.5, scheduler: MainScheduler.instance).single()
                ob.subscribe { (e) in
                    print("before asMaybe : ",e)
                }.disposed(by: disposeBag)
                
                ob.asMaybe().subscribe { (me) in
                    print("after asMaybe : ",me)
                }.disposed(by: disposeBag)
            }
            
            func test_Maybe_create() {
                
                let maybe = Maybe<Int>.create(){ maybeBlock in
                    
                    let status = Int(arc4random() % 10)
                    if status >= 6 {
                        maybeBlock(MaybeEvent.success(status))
                    }
                    else if status >= 3 {
                        maybeBlock(MaybeEvent.completed)
                    }
                    else {
                        maybeBlock(MaybeEvent.error(TempError.someError))
                    }
                    return Disposables.create()
                }
                
                
                maybe.subscribe { (maybeEvent) in
                    print("Maybe : ", maybeEvent)
                }.disposed(by: self.disposeBag)
            }
            
            test_Maybe_AsMaybe()
            //test_Maybe_create()
        }
        
        /*
         Completable 和Single都是Observable的变体，
         但是Completable不会发送任何next事件的元素，它要么发送一个completed事件要么发送一个error事件。
         所以Completable适合那种只需要知道任务是否成功的情况，而不关心任务返回的数据。
         */
        func test_completable() {
            
            let comp = Completable.create() { completable in
                let success = (arc4random() % 4) % 2 == 0
                if success {
                    completable(CompletableEvent.completed)
                } else {
                    completable(CompletableEvent.error(TempError.someError))
                }
                return Disposables.create()
            }
            
            comp.subscribe { (compEvent) in
                print("completable : ", compEvent)
            }.disposed(by: self.disposeBag)
        }
        
        
        func test_Single() {
            /*
             Single是Observable的变体，只能发出一个元素，要么是一个next事件要么是一个error事件。
             如果一个Observable里面包含多个事件，如下面的 Observable<Int>.of(1,2,3,4)
             那么它调用asSingle之后，订阅者会直接收到一个error事件
             */
            func test_Single_asSingle() {
                let ob = Observable<Int>.of(14)
                ob.subscribe { (e) in
                    print("before as single : ",e)
                    }.disposed(by: self.disposeBag)
                
                
                ob.asSingle().subscribe { (singleEvent) in
                    print("after single : ", singleEvent)
                    }.disposed(by: self.disposeBag)
            }
            
            func test_Single_getChannelInfo(_ channel : String ) {
                let netWork = Single<[String : Any]>.create(){
                    singleEventBlock in
                    //let url = URL(string: "https://api.github.com/users")!
                    let url = URL(string:"https://douban.fm/j/mine/playlist?" + "type=n&channel=\(channel)&from=mainsite")!
                    let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                        if let error = error {
                            singleEventBlock(SingleEvent.error(error))
                            return
                        }
                        
                        guard let data = data ,
                            let json = try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves),
                            let result = json as? [String : Any] else {
                                singleEventBlock(SingleEvent.error(DataError.cannotParseJson))
                                return
                        }
                        singleEventBlock(SingleEvent.success(result))
                    })
                    
                    task.resume()
                    
                    return Disposables.create {
                        task.cancel()
                    }
                }
                
                netWork.subscribe { (responseResult) in
                    print("response : ", responseResult)
                    }.disposed(by: disposeBag)
            }
            
            enum DataError : Error {
                case requestError
                case cannotParseJson
            }
            
            test_Single_asSingle()
            //test_Single_getChannelInfo("1")
        }
        test_Maybe()
        //test_completable()
        //test_Single()
    }
    
    // MARK: - delay  delaySubscription  timout 等
    var testTimeoutOb = PublishSubject<Int>()
    func testObservable_11() {
        
        func test_timeout() {
            // 超过指定时间不发送事件的话，就发送一个error事件
            testTimeoutOb
            .timeout(3, scheduler: MainScheduler.instance)
            .subscribe({ (e) in
                print("timout : ", e)
            })
            .disposed(by: self.disposeBag)
        }
        
        func test_Delay() {
            // 延时几秒开始发送事件
            let ob = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
                .delay(2, scheduler: MainScheduler.instance)
            ob.subscribe { (e) in
                print("delay to on next : ", e)
            }.disposed(by: self.disposeBag)
            
        }
        
        func test_DelaySubscription() {
            // 延时几秒之后开始订阅
            let ob = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
                .delaySubscription(2, scheduler: MainScheduler.instance)
            ob.subscribe { (e) in
                print("delaySubscription to on next : ", e)
            }.disposed(by: self.disposeBag)
        }
        
        func test_materialize() {
            /*
             materialize : 使具体化
             这个方法会将原始Observable序列中的Event关联值再包裹一层Event之后发送给订阅者。
             Event<Int>  ===>  Event<Event<Int>>
             */
            //Observable<Int>
            let ob = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
            //Observable<Event<Int>>
            let materializedOb = ob.materialize()
            materializedOb.subscribe { (eventIncludingEvent) in  //Event<Event<Int>>
                print("materialize : ", eventIncludingEvent)
                }.disposed(by: self.disposeBag)
        }
        
        func test_dematerialize() {
            /*
             只有关联值为Event的Observable才可以调用dematerialize方法，如Observable<Event<Int>>
             而 Observable<Int>.of(1，2，3) 生成的这种Observable是调用不了dematerialize方法的，
             因为它的事件不是Event嵌套的。
             */
            let ob = Observable<Event<Int>>.of(Event.next(1), Event.next(2), Event.next(3))
            let dematerializedOb = ob.dematerialize()
            dematerializedOb.subscribe { (event) in
                print("dematerialize : ", event)
            }.disposed(by: self.disposeBag)
        }

        //test_Delay()
        //test_DelaySubscription()
        //test_materialize()
        //test_dematerialize()
        test_timeout()
    }
    
    // MARK: - 连接操作（Connectable Observable Operators）可连接序列
    var cutDownConnectOb : Observable<Int>?
    func testObservable_10(){
        
        func test_ShareReplay() {
            
            /*
             下面例子中‘222’的订阅者是在4秒之后收到事件的，然后4秒之前‘111’的订阅者已经收到多条消息了，
             如果不调用share方法，那么222的订阅者收到的事件的关联值是从1开始的。
             如果调用了share方法，代表两个订阅者共享这个序列里面的时间，所以222和111收到的事件是同步的。
             */
            func test_ShareReplay_Interval() {
                let ob = Observable<Int>.interval(1, scheduler: MainScheduler.instance).share(replay: 2, scope: SubjectLifetimeScope.forever)
                ob.subscribe { (e) in
                    print("111 : ", e)
                    }.disposed(by: self.disposeBag)
                
                delay(4) { [unowned self] in
                    ob.subscribe({ (e) in
                        print("222 : ", e)
                    }).disposed(by: self.disposeBag)
                }
            }
            
            func test_ShareReplay_Subject() {
                let subj = PublishSubject<Int>()
                let ob = subj.share(replay: 3, scope: .forever)
            
                ob.subscribe { (e) in
                    print("1111 : ", e)
                }.disposed(by: self.disposeBag)
                
                
                subj.onNext(1)
                subj.onNext(2)
                subj.onNext(3)
                subj.onNext(4)
                
                ob.subscribe { (e) in
                    print("2222 : ", e)
                }.disposed(by: self.disposeBag)
                
                subj.onNext(5)
                subj.onNext(6)
                subj.onNext(7)
                subj.onNext(8)
            }
            test_ShareReplay_Interval()
            //test_ShareReplay_Subject()
        }
        
        func test_RefCount() {
            /*
             refCount 方法可以使ConnectableObservable（connectOb）转换回Observable（reSrcOb）。
             如下面的例子，如果reSrcOb没有被订阅，则必须要connectOb调用connect方法之后，订阅者才能收到事件（4秒以后）。
             如果reSrcOb被订阅了，那么connectOb无需再调用connect方法就可以s让其的订阅者和reSrcOb的订阅者收到事件（delay 4 秒也没有效果了，会马上收到事件）
             所以refCount相当于起到了断开连接的作用。
             */
            let srcOb = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
            
            let connectOb = srcOb.publish()
            
            
            let reSrcOb = connectOb.refCount()
            self.cutDownConnectOb = reSrcOb
            
//            reSrcOb.subscribe { (e) in
//                print("re source ob : ", e)
//            }.disposed(by: disposeBag)

            connectOb.subscribe { (e) in
                print("connect ob 111 : ", e)
            }.disposed(by: disposeBag)
            
            delay(24) {
                _ = connectOb.connect()
            }

        }
        
        func test_ConnectObsevable_Muticast() {
            /*
             muticast 指定的序列（这里是subject）在源序列connect之后，
             原序列发送事件时，不仅源序列的订阅者会收到事件，subject的订阅者也会相应地收到，并且关联值是一样的。
             */
            let subj = PublishSubject<Int>()
            
            subj.subscribe { (e) in
                print("subject : ",e)
            }.disposed(by: disposeBag)
            
            let ob = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
            
            let connectOb = ob.multicast { () -> ReplaySubject<Int> in
                return ReplaySubject<Int>.create(bufferSize: 3)
            }
            
            /*
             replay 内部也是调用的muticast，并指定了一个ReplaySubject。
             */
            // let connectOb1 = ob.replay(3)

            connectOb.subscribe { (e) in
                print("connect one : ",e)
            }.disposed(by: disposeBag)
            
            delay(2) {
                _ = connectOb.connect()
            }
            
            delay(7) { [unowned self] in
                connectOb.subscribe({ (e) in
                    print("connect two : ",e)
                }).disposed(by: self.disposeBag)
            }
            
        }
        
        func test_ConnectObsevable_Replay() {
            
            func test_ConnectObsevable_Replay_Timer() {
                let ob = Observable<Int>.interval(1, scheduler: MainScheduler.instance).replay(4)
                
                ob.subscribe { (e) in
                    print("first : ", e)
                    }.disposed(by: disposeBag)
                
                delay(2) {
                    _ = ob.connect()
                }
                
                delay(9) { [unowned self] in
                    ob.subscribe({ (e) in
                        print("delay : ", e)
                    }).disposed(by: self.disposeBag)
                }
            }
            
            func test_ConnectObsevable_Replay_Subject() {
                let subject = PublishSubject<Int>()
                let connectable = subject.replay(3)
                connectable.subscribe { (e) in
                    print("first : ", e)
                }.disposed(by: disposeBag)
                // 在connect之前发送的事件，订阅者都收不到
                subject.onNext(1)
                subject.onNext(2)
                subject.onNext(3)
                subject.onNext(4)
                _ = connectable.connect()
                subject.onNext(5)
                subject.onNext(6)
                subject.onNext(7)
                subject.onNext(8)
                connectable.subscribe { (e) in
                    print("after : ", e)
                }.disposed(by: disposeBag)
                subject.onNext(9)
                subject.onNext(10)
            }
            
            //test_ConnectObsevable_Replay_Subject()
            test_ConnectObsevable_Replay_Timer()
        }
        
        func test_ConnectObsevable_Publish() {
            
            func normalOb() {
                let ob = Observable<Int>.interval(0.5, scheduler: MainScheduler.instance)
                
                ob.subscribe { (event) in
                    print("first subscribe : ", event)
                }.disposed(by: disposeBag)
                
                /*
                 需要注意的是，如果使用timer或者interval定时发送事件，
                 延时订阅之后订阅者收到的事件关联值还是从1开始的。
                 */
                delay(2) { [weak self] in
                    guard let wself = self else { return }
                    
                    ob.subscribe({ (eee) in
                        print("delay subscribe : ", eee)
                    }).disposed(by: wself.disposeBag)
                }
            }
            
            /*
             可连接Observalble - ConnectableObservable
             调用 publish 可以将普通的 Observable 转换成 ConnectableObservable 。
             如果ConnectableObservable不调用connect方法，有多少个订阅者是都收不到事件的。
             只有调用了connect之后，它的订阅者才能收到序列中的事件。
            */
            func connectOb() {
                // 调用 publish 之后，普通的Observable就变成了ConnectableObservable了
                // 只有调用了connect方法之后，所有的订阅者才能接收到事件
                let ob = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
                let connectOb = ob.publish()
                
                connectOb.subscribe { (event) in
                    print("first subscribe : ", event)
                }.disposed(by: disposeBag)
                
                delay(2) {
                    _ = connectOb.connect()
                }
                
                delay(7) { [unowned self] in
                    connectOb.subscribe({ (eee) in
                        print("delay subscribe : ", eee)
                    }).disposed(by: self.disposeBag)
                }
            }
            
            connectOb()
            //normalOb()
            
        }
        
        test_ShareReplay()
        //test_RefCount()
        //test_ConnectObsevable_Muticast()
        //test_ConnectObsevable_Replay()
        //test_ConnectObsevable_Publish()
    }
    
    // MARK: - 算数&聚合操作符：toArray、reduce、concat
    func testObservable_9() {
        let ob = Observable<Int>.interval(0.5, scheduler: MainScheduler.instance)
        ob.toArray().subscribe { (e) in
            print("toArray : ", e)
        }.disposed(by: disposeBag)
        
        func test_concat() {
            /*
             concat 操作必须保证concat的各个Observable的关联值类型是一样的。
             如下面的例子，subj1 和 subj2，只有在 subj1 发送了completed事件之后，
             subj2发送的事件才能被订阅者收到，在completed之前的subj2的事件是收不到的。
             */
            let ob1 = Observable.of(1,2,3,4)
            let ob2 = Observable.of(6,7,8,9)
            
            Observable.concat(ob1,ob2).subscribe { (e) in
                print("concat : ", e)
            }.disposed(by: disposeBag)
            
            let subj1 = PublishSubject<Int>()
            let subj2 = PublishSubject<Int>()

            Observable.concat(subj1, subj2).subscribe { (e) in
                print("subjc concat : ", e)
            }.disposed(by: disposeBag)

            subj1.onNext(1)
            subj2.onNext(199)
            subj2.onNext(299)
            subj1.onNext(2)
            subj1.onNext(3)
            subj2.onNext(399)
            subj1.onCompleted()
            subj2.onNext(499)
            subj1.onNext(4)
            subj2.onNext(599)
            
        }
        
        test_concat()
    }
    
    // MARK: - 结合操作符：startWith、merge、zip等
    func testObservable_8(){
        
        func test_withLatestFrom() {
            /*
             如下面的例子，mainSubj调用withLatestFrom方法要获取subject中最新的事件，
             然后通过withLatestFrom提供的闭包来讲mainSubj和subject中的关联值进行操作并生产新值，最后发送给订阅者。
             所以要想订阅者收到事件，需要保证subject中至少有一个事件。
             */
            let mainSubj = PublishSubject<String>()
            let subject = PublishSubject<Int>()

            mainSubj.withLatestFrom(subject) { (a, b) -> String in
                return "ob event : \(a) + \(b)"
            }.subscribe { (event) in
                print("withLatestFrom event : ", event)
            }.disposed(by: disposeBag)
            
            mainSubj.onNext("AAA")
            subject.onNext(111)
            subject.onNext(222)
            subject.onNext(333)
            mainSubj.onNext("BBB")
            mainSubj.onNext("CCC")

        }
        
        func test_CombineLatest() {
            /*
             当一个Observable发送事件时，它会将他的事件和另一个队列的最新的事件合并之后发送给订阅者。
             如果只有一个Observable发送事件，订阅者是收不到事件的。
             也就是说必须要保证每一个observable中至少有一个事件，这样订阅者才能收到。
             */
            let subj1 = PublishSubject<Int>()
            let subj2 = PublishSubject<String>()
            
            Observable.combineLatest(subj1, subj2) { (intElem, strElem) -> String in
                return "subj1 : \(intElem), subj2 : \(strElem)"
            }.subscribe { (e) in
                print("combineLatest : ", e)
            }.disposed(by: disposeBag)
            
            subj1.onNext(111)
            subj2.onNext("AAA")
            subj2.onNext("BBB")
            subj1.onNext(222)
            subj1.onNext(333)
            subj2.onNext("CCC")
            subj2.onNext("DDD")

        }
        
        func test_Zip() {
            /*
             该方法可以将多个（两个或两个以上的）Observable 序列压缩成一个 Observable 序列。
             而且它会等到每个 Observable 事件一一对应地凑齐之后再合并。
             下面的ob1是0.5秒发一次，ob2是1.5秒发一次，但是由于调用zip操作后，
             不管ob1的间隔多短，它刚刚要发出的事件都要等ob2发出一个事件时，两者合并之后订阅者才会收到。
             可以理解为以‘慢的’那个为准。
             */
            let ob1 = Observable<Int>.interval(0.5, scheduler: MainScheduler.instance)
            let ob2 = Observable<Int>.interval(1.5, scheduler: MainScheduler.instance)
            Observable.zip(ob1, ob2) { (elem1, elem2) -> String in
                return "ob1 : \(elem1), ob2 : \(elem2)"
            }.subscribe { (e) in
                print("zip : ", e)
            }.disposed(by: disposeBag)
        }
        
        func test_Merge() {
            
            /*
             需要注意的是，只有Observable发送的事件关联值为另一个ObservableType时才能调用merge方法。
             因为只有多个Observable或者subject才能做merge操作。
             而且合并的多个Observable的关联值的类型都必须是一致的。
             */
            // let subj1 = PublishSubject<Int>()
            // let subj2 = PublishSubject<Int>()
            // let subj3 = PublishSubject<Int>()
            // let ob = Observable.of(subj1, subj2, subj3)
            // ob.merge()
            // .subscribe { (e) in
            //     print("merge : ",e)
            // }
            // .disposed(by: disposeBag)
            //
            // subj1.onNext(1)
            // subj2.onNext(10)
            // subj1.onNext(2)
            // subj2.onNext(20)
            // subj1.onNext(3)
            // subj2.onNext(30)
            // subj1.onNext(4)
            // subj3.onNext(999)
            // subj3.onNext(888)
            
            let ob1 = Observable<Int>.interval(0.5, scheduler: MainScheduler.instance)
            let ob2 = Observable<Int>.of(111,222,333,444,555).delay(3, scheduler: MainScheduler.instance)
            // Observable.of(ob1, ob2).merge() 和 Observable.merge([ob1, ob2]) 效果是一样的
            Observable.merge([ob1, ob2]).subscribe { (event) in
                print("merge : ",event)
            }.disposed(by: disposeBag)
        }
        
        func test_StartWith() {
            Observable<Int>.of(1,2,3,4,5,6)
                .startWith(199)
                .startWith(299)
                .startWith(399)
                .subscribe { (event) in
                    print("start with : ", event)
                }
                .disposed(by: disposeBag)
        }
        
        test_withLatestFrom()
        //test_CombineLatest()
        //test_Zip()
        //test_Merge()
        //test_StartWith()
    }
    
    // MARK: - 条件和布尔操作符：amb、takeWhile、skipWhile等
    func testObservable_7() {
        
        func test_SkipUntil() {
            
            
            /*
             skipUntil会指定一个Observable作为notifier，源Observable的序列事件会默认一直被忽略，
             当notifier发送next或者completed事件的时候，订阅者才会收到源Observable的事件。
             */
            Observable<Int>.interval(0.5, scheduler: MainScheduler.instance)
            .skipUntil(self.untilNotifier)
            .subscribe { (event) in
                print("skip until : ",event)
            }
            .disposed(by: disposeBag)
        }
        
        func test_TakeUntil() {
            // 当一个Observable（source）使用 takeUntil操作时，会指定一个Observable作为一个notifier，
            // 在notifier发送事件之前，source可以正常发送事件，但是当notifier发送一个事件之后，
            // source 会立即发送completed事件并结束，所以takeUntil指定的Observable相当于充当了一个停止发送的通知者身份。
            Observable<Int>.interval(0.5, scheduler: MainScheduler.instance)
            .takeUntil(self.untilNotifier)
            .subscribe { (event) in
                print("takeUntil : ",event)
            }
            .disposed(by: disposeBag)
        }
        
        func test_TakeWhile() {
            // 只要碰到第一个不满足takeWhile提供的条件的事件，该Observable就直接发送completed事件。
            Observable<Int>.of(1,2,3,4,5,6,7,8,9,10)
            .takeWhile { (elem) -> Bool in
                return elem <= 5
            }
            .subscribe { (event) in
                print("takeWhile : ",event)
            }
            .disposed(by: disposeBag)
        }
        
        func test_amb() {
            /*
             使用amb的时候会传入一个Observable，当多次调用amb的时候响应地要指定多个Observable。
             amb操作会获取这些Observable(包括调用amb操作的那个Observable)中第一个发送消息的那一个，
             并且之后只会关注这个Observable，忽略其他的。
             */
            let subj1 = PublishSubject<String>()
            let subj2 = PublishSubject<String>()
            let subj3 = PublishSubject<String>()
            
            subj1.amb(subj2).amb(subj3)
            .subscribe { (event) in
                print("amb : ",event)
            }.disposed(by: disposeBag)
            
            
            subj3.onNext("subj3 --- AAA")
            subj1.onNext("subj1 --- 111")
            subj2.onNext("subj2 --- OOO")
            subj1.onNext("subj1 --- 222")
            subj3.onNext("subj3 --- BBB")
            subj1.onNext("subj1 --- 333")
            subj2.onNext("subj2 --- PPP")

        }
        test_SkipUntil()
        //test_TakeUntil()
        //test_TakeWhile()
        //test_amb()
    }
    
    // MARK: - 过滤操作符：filter、take、skip、sample等
    func testObservable_6() {
        
        func test_debounce() {
            let ttt = self.textField.rx.text
            ttt.debounce(0.5, scheduler: MainScheduler.instance)
                .subscribe { (event) in
                    if let text = event.element {
                        print("text : ", text ?? "nil")
                    }
                }.disposed(by: self.disposeBag)
            
        }
        
        func test_Sample() {
            /*
             sample操作除了订阅源Observable(source)之外，还会让另一个Observable成为通知者(notifier)
             如果source直接发送事件，订阅者是收不到的，只有在这之后有notifier发送事件，
             订阅者才会收到source最新发送的事件。
             */
            let src = ReplaySubject<Int>.create(bufferSize: 2)
            let noti = PublishSubject<String>()
            
            src.sample(noti)
            .subscribe { (event) in
                print(event)
            }.disposed(by: self.disposeBag)
            
            noti.onNext("a")
            src.onNext(111)
            src.onNext(222)
            
            // 在notifier发送 'b' 事件之前，source发送了222事件，这个是source最新的事件。
            // 所以在notifier之后，订阅者才会收到’222‘事件
            noti.onNext("b")
        }
        
        
        func test() {
            
            Observable<Int> .from([1,1,1,2,2,3,4,5,6,7,8,9,9,10])
            .distinctUntilChanged()
            .filter { (elem) -> Bool in
                return elem % 2 == 0
            }
            .take(3)
            .elementAt(1)
            .ignoreElements()
            .subscribe { (e) in
                print(e)
            }
            .disposed(by: self.disposeBag)
        }
        //test()
        //test_Sample()
    }
    
    // MARK: - 变换操作符：buffer、map、flatMap（已废弃->改用compactMap）、scan等
    func testObservable_5() {
        
        func test_GroupBy() {
            /*
             groupBy 操作会将最开始的Observable中每个Event中的关联值（element）取出来并分组
             分组的key由groupBy方法中的block参数指定。
             分组之后的会将这些组放到一个GroupObservable里面，然后通过event发送给订阅者。
             订阅者收到之后可以将GroupObservable取出来并对其展开订阅。
             */
            
            let ob = Observable<Int>.from([1,2,3,4,5,6,7,8,9,10])
            ob.groupBy { (elem) -> String in
                if elem <= 3 {
                    return "sml"
                } else if elem <= 7 {
                    return "mid"
                } else {
                    return "big"
                }
            }
            .subscribe { [weak self] (groupObEvent) in
                guard let wself = self, let groupOb = groupObEvent.element else {
                    return
                }
                groupOb.subscribe({ (event) in
                    print("grouped ob subscribtion : ", event.element ?? "empty")
                }).disposed(by: wself.disposeBag)
                
            }.disposed(by: self.disposeBag)
            
        }
        
        func test_Scan() {
            // scan的功能和数组的reduce很相似。
            let ob = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
            ob.scan("start ") { (acum, num) -> String in
                return acum + "\(num) "
            }
            .subscribe { (event) in
                print("scan subscribe : ", event.element ?? "empty")
            }
            .disposed(by: self.disposeBag)
        }
        
        func test_ConcatMap() {
            let subj1 = BehaviorSubject(value: "111")
            let subj2 = BehaviorSubject(value: "AAA")
            
            let vvv = Variable(subj1)
            
            vvv.asObservable()
            .concatMap { (subject) -> BehaviorSubject<String> in
                return subject
            }
            .subscribe { (event) in
                print("concatMap : ", event.element ?? "empty")
            }
            .disposed(by: self.disposeBag)
            
            /*
             尽管 Variable 的value 已经从subj1变为了subj2，
             但是下面的 subj2 的 'BBB' 事件订阅者都收不到，但是’CCC‘事件可以被接收到。
             
             concatMap操作的含义是：
             只有当前Observable的事件发送完毕之后(只有completed，不包括error)，
             下一个Observable发送的事件其订阅者才能接收到。
             */
            vvv.value = subj2
            subj2.onNext("BBB")
            subj1.onNext("222")
            subj1.onNext("333")
            //subj1.onCompleted()
            subj1.onError(ZYError(desc: "", code: 199))
            subj2.onNext("CCC")
        }
        
        func test_FlatMapLatest() {
            
            // flatMapLatest 与 flatMap 的唯一区别是：flatMapLatest只会接收最新的value 事件。
            let subj1 = BehaviorSubject(value: "111")
            let subj2 = BehaviorSubject(value: "AAA")
            
            let vvv = Variable(subj1)
            vvv.asObservable().flatMapLatest { (subject) -> BehaviorSubject<String> in
                return subject
            }
            .subscribe { (event) in
                print("flatMapLatest : ", event.element!)
            }
            .disposed(by: self.disposeBag)
            
            subj1.onNext("222")
            subj1.onNext("333")
            
            vvv.value = subj2
            subj2.onNext("BBB")
            /*
             下面的 444 555 的next事件虽然发出了，但是订阅者不会收到它们。
             由于 Variable 的value已经从subj1变成了subj2，
             而 flatMapLatest 只会接收最新的 value事件即subj2的事件，
             所以使用flatMapLatest之后，旧的value不管发送多少个事件，订阅者都收不到了。
             */
            subj1.onNext("444")
            subj1.onNext("555")
        }
        
        func test_FlatMap() {
            let subj1 = BehaviorSubject(value: "111")
            let subj2 = BehaviorSubject(value: "AAA")
            let vvv = Variable(subj1)
            /*
             Observable嵌套Ob1（Ob2）的情况下，如果Ob1不使用flatMap来获取内层的Ob2，而是直接订阅，
             那么这个订阅者其实是针对Ob1的，所以不管Ob2发送多少个事件，这个订阅者都收不到。
             */
            // vvv.asObservable().subscribe { [weak self](event) in //Event<BehaviorSubject<String>>
            //     guard let wself = self, let behaviorSubject = event.element else { return }
            //     print("111 vvv subscribe : ", behaviorSubject)
            //     behaviorSubject.subscribe({ (e) in
            //         print("111 behaviorSubject subscribe : ", e.element!)
            //     }).disposed(by: wself.disposeBag)
            // }.disposed(by: self.disposeBag)
            
            /*
             Observable嵌套Ob1（Ob2）的情况下，Ob1通过flatMap操作获取内层的Ob2之后，
             此时订阅的话，订阅者其实是针对内层的Ob2的做的订阅，那么之后如果Ob2发送各种事件的话，
             这个订阅者就会收到这些事件并处理。
             所以flatMap是用来处理map操作所不能处理的‘升维’的情况的。
             当出现Observable嵌套的情况，并且还想订阅内层Observable的事件时，
             需要使用flatMap操作将这个中嵌套关系‘铺平’。
             */
            vvv.asObservable()
            //.flatMap{$0}
            .flatMap { (subject) -> BehaviorSubject<String> in
                return subject
            }
            .subscribe { (event) in
                print("222 flatmap : ", event.element!)
            }.disposed(by: self.disposeBag)
            
            subj1.onNext("222")
            subj1.onNext("333")
            vvv.value = subj2
            /*
             虽然value值从subj1改为了subj2，但是前一个value，即subj1 发送的事件订阅者还是能收到的。
             */
            subj1.onNext("444")
            subj2.onNext("bbb")
        }
        
        func test_Window() {
            let subj = PublishSubject<Int>()
            /*
             window方法每收集到一个event，会将even中的关联值放到一个新的Observable中，
             然后将这个新的Observable放到Event中再次发送给订阅者，和buffer不同的是，
             window不会等收集完成之后统一发给订阅者，而是实时地一个一个地发送，当发送的个数等于count之后，
             它会紧跟着发送一个completed 事件用来说明本次收集完成。
             */
            subj
            .window(timeSpan: 1, count: 4, scheduler: MainScheduler.instance)
            .subscribe { [weak self] (event) in //Event<Observable<Int>>
                guard let wself = self, let elem = event.element else { return }
                elem.subscribe({ (e) in //Event<Int>
                    print("element : ",e)
                }).disposed(by: wself.disposeBag)
                
                
            }.disposed(by: self.disposeBag)
            
            subj.onNext(1)
            subj.onNext(2)
            subj.onNext(3)
            subj.onNext(4)
            subj.onNext(5)
            subj.onNext(6)
            subj.onNext(7)
            subj.onNext(8)

        }
        
        func test_Buffer() {
            
            let subj = ReplaySubject<Int>.create(bufferSize: 3)
            /*
             buffer 会在指定timeSpan中收集count个数的event，当到时间或者收集齐了时，
             会将这些event中的关联值抽出来放到一个集合里面，并把这个集合作为新的关联值放到一个新的Event中发给订阅者。
             */
            subj
            .buffer(timeSpan: 1, count: 4, scheduler: MainScheduler.instance)
            .subscribe { (event) in // Event<[Int]>
                print("buffered event : ", event)
            }
            .disposed(by: self.disposeBag)
            
            
            subj.onNext(1)
            subj.onNext(2)
            subj.onNext(3)
            subj.onNext(4)
            subj.onNext(5)
            subj.onNext(6)
            subj.onNext(7)
            
            subj.subscribe { (e) in
                print("bbbbb : ",e)
            }.disposed(by: self.disposeBag)
            
        }
            
            
        //test_Buffer()
        test_Window()
        //test_FlatMap()
        //test_FlatMapLatest()
        //test_ConcatMap()
        //test_Scan()
        //test_GroupBy()
    }
    
    //MARK: - Subject 和 Variable
    func testObservable_4() {
        
        func testVariable() {
            // 相当于对 BehaviorSubject 的封装，所以初始化的时候也需要传一个默认值。
            // 但是使用起来和BehaviorSubjecty略有不同，Variable 会把当前发送的值当做状态自己保存起来。
            // 它有一个value属性就是用来保存状态值的，当改变value属性的值时，
            // 就相当于subject调用onNext方法来把value的值放到Event中并发送出去。
            let vvv = Variable("111")
            vvv.asObservable().subscribe { (event) in
                print("aaaa : ", event)
                }.disposed(by: self.disposeBag)
            
            vvv.value = "222"
            
            vvv.asObservable().subscribe { (e) in
                print("bbbb : ", e)
            }.disposed(by: self.disposeBag)
            
            vvv.value = "333"
            vvv.asObservable().subscribe { (e) in
                print("cccc : ", e)
            }.disposed(by: self.disposeBag)
        }
        
        func testPublishSubject() {
            let subject = PublishSubject<String>()
            
            subject.onNext("111")
            
            subject.subscribe { (e) in
                print("aaaa : ",e)
            }.disposed(by: self.disposeBag)
            
            subject.onNext("222")
            
            subject.subscribe { (e) in
                print("bbbb : ", e)
            }.disposed(by: self.disposeBag)
            
            subject.onNext("444")
            subject.onCompleted()
            
            subject.subscribe { (e) in
                print("cccc : ",e)
            }.disposed(by: self.disposeBag)
            
        }
        
        func testBehaviorSubject() {
            // 初始化时需要默认值，当有订阅者出现时，
            // 订阅者会最先收到它上一个发送的event， 包括completed和error event。
            // 如果没法过event，则会收到包含着默认值的event
            let subject = BehaviorSubject<String>(value: "111")
            subject.onNext("222")
            subject.subscribe { (e) in
                print("aaaa : ", e)
            }.disposed(by: disposeBag)
            
            subject.onNext("333")
            subject.subscribe { (e) in
                print("bbbb : ",e)
            }.disposed(by: disposeBag)
            
            subject.subscribe { (e) in
                print("cccc : ", e)
            }.disposed(by: disposeBag)
            subject.onCompleted()
        }
        
        func testReplaySubject() {
            // ReplaySubject 初始化的时候会指定一个bufferSize，
            // 用来缓存最近发送的几个event(不包括complete和error事件)
            // 等到有新的订阅者出现的时候，这几个缓存的event会立即发送给订阅者
            let subject = ReplaySubject<String>.create(bufferSize: 2)
            subject.subscribe { (e) in
                print("aaaa : ",e)
            }.disposed(by: disposeBag)
            
            subject.onNext("111")
            subject.onNext("222")
            subject.onNext("333")
            subject.onCompleted()

            subject.subscribe { (e) in
                print("bbbb : ",e)
            }.disposed(by: disposeBag)
        }
    
        testReplaySubject()
        //testBehaviorSubject()
        //testPublishSubject()
    }
    
    //MARK: - 自定义可绑定属性
    func testObservable_3() {
        self.label.text = "Hello"
        let ob = Observable<Int>.timer(0.5, period: 0.6, scheduler: MainScheduler.instance)
//        ob.map { (elem) -> CGFloat in
//            return CGFloat(elem)
//        }
//        .bind(to: self.label.rx_fontSize)
//        .disposed(by: self.disposeBag)
//
//        ob.map { (elem) -> UIColor in
//            let r = CGFloat((arc4random() % 255)) / 255.0
//            let g = CGFloat((arc4random() % 255)) / 255.0
//            let b = CGFloat((arc4random() % 255)) / 255.0
//            return UIColor(displayP3Red: r, green: g, blue: b, alpha: 1.0)
//        }
//        .bind(to: self.label.rx_backgroundColor)
//        .disposed(by: disposeBag)
        
//        ob.map { (elem) -> CGFloat in
//            return CGFloat(elem)
//        }
//        .bind(to: self.label.rx.cus_fontSize)
//        .disposed(by: self.disposeBag)
//
//        ob.map { (elem) -> UIColor in
//            let r = CGFloat((arc4random() % 255)) / 255.0
//            let g = CGFloat((arc4random() % 255)) / 255.0
//            let b = CGFloat((arc4random() % 255)) / 255.0
//            return UIColor(displayP3Red: r, green: g, blue: b, alpha: 1.0)
//        }
//        .bind(to: self.label.rx.cus_backgroundColor)
//        .disposed(by: disposeBag)
        
        // 直接使用RxSwift已经定义好的可绑定属性来改变label的文本
        ob.map({"content \($0)"}).bind(to: self.label.rx.text).disposed(by: disposeBag)
    }
    
    //MARK: - 观察者： AnyObserver、Binder
    func testObservable_2() {
        let ob = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
//        let ob1 = ob.map { (eventElement) -> String in
//            return "eventElement - \(eventElement)"
//        }
//        ob1.bind(onNext: { [weak self] (text) in
//            guard let wself = self else { return }
//            wself.label.text = text
//        }).disposed(by: self.disposeBag)
//
//        ob1.subscribe {Int
//            print("disposed")
//        }.disposed(by: self.disposeBag)
        // 创建一个观察者 并通过subscribe订阅
//        let observer = AnyObserver<Int> { [weak self](event) in
//            guard let wself = self else { return }
//            wself.label.text = "content : \(event.element!)"
//            print(event)
//        }
//        ob.subscribe(observer)
//        .disposed(by: self.disposeBag)
        
//        // 创建观察者，并通过bind产生订阅
//        let observer = AnyObserver<String> {[weak self] (ev) in
//            guard let wself = self else { return }
//            wself.label.text = ev.element
//        }
//        ob.map { (elem) -> String in
//            return "content \(elem)"
//        }
//        .bind(to: observer)
//        .disposed(by: self.disposeBag)
        
        
        // 创建Binder, Binder 是 RxCocoa库里面的继承于ObserverType的结构体，
        // 主要用于将视图控件与特定属性进行绑定并产生订阅关系
//        let binder = Binder<String>(self.label, scheduler: MainScheduler.instance) { (lb, text) in
//            lb.text = text
//        }
//
//        ob.map { (elem) -> String in
//            return "content \(elem)"
//        }
//        .bind(to: binder)
//        .disposed(by: self.disposeBag)
    

        
    }
    
    //MARK: - Observable订阅、事件监听、订阅销毁
    func testObservable_1() {
     
        //        let ob = Observable<Int>.just(5)
        
        //        let ob = Observable<Int>.empty()
        
        //        let ob = Observable.of(1,2,3,4,5)
        
        //        let ob = Observable.from([1,2,3,4,5])
        
        //        let ob = Observable<Int>.create { (observer) -> Disposable in
        //
        //            observer.on(Event.next(19))
        //            observer.onNext(20)
        //            // 发送Error 或者 Completed 时间之后，
        //            // 这个Observable 就不具备再发送时间的能力了
        //            //observer.onError(ZYError(desc: "tempError", code: 199))
        //            observer.onCompleted()
        //            observer.onNext(77)
        //            return Disposables.create()
        //        }
        
        //        let ob = Observable.repeatElement(9)
        
        //        var flag : Bool = false
        //        let ob = Observable<Int>.deferred { () -> Observable<Int> in
        //            // 每一次的subscribe方法都会调用这个block
        //            flag = !flag
        //            if flag {
        //                return Observable.from([1,3,5])
        //            } else {
        //                return Observable.from([2,4,6])
        //            }
        //        }
        
        //        // interval 只允许发送包含遵守了FixedWidthInteger协议类型数据的event
        //        // 如整型Int、Int8、Int32等等
        //        let ob = Observable<Int>.interval(0.5, scheduler: MainScheduler.instance)
        //        let ob = Observable<Int32>.timer(3, scheduler: ConcurrentMainScheduler.instance)
        //        // 在经历了1秒之后每隔5秒（period）发送一次event
        //        let ob = Observable<Int>.timer(1, period: 5, scheduler: MainScheduler.instance)
        
        
        // just 在发送完当前的消息之后紧接着就会发送completed 时间，之后就被销毁了（dispose）
        //        let ob = Observable<String>.just("Hello")
        
        // create 的block中，只有调用了onError 或者 onCompleted 之后才会被销毁（dispose）
        let ob = Observable<Int>.create { (o) -> Disposable in
            o.onNext(10)
            o.onNext(99)
            //o.onError(ZYError(desc: "finish", code: 200))
            return Disposables.create()
        }
        
        //        let _ = ob.subscribe { (event) in
        //            //print("subscribe event : ",event)
        //            switch event {
        //            case .next(let elem) :
        //                print("next event : \(elem)")
        //            case .error(let err) :
        //                print("error event : \(err.localizedDescription)")
        //            case .completed:
        //                print("completed event")
        //            }
        //        }
        
        ob.do(onNext: { (elem) in
            print("do on next : \(elem)")
            
        }, onError: { (err) in
            print("do on error : \(err)")
            
        }, onCompleted: {
            print("do on Completed )")
            
        }, onSubscribe: {
            print("do on Subscribe")
            
        }, onSubscribed: {
            print("do on Subscribedddd")
            
        }, onDispose: {
            print("do on Dispose")
        })
            .subscribe(onNext: { (elem) in
                print("subscribe on next : \(elem)")
                
            }, onError: { (err) in
                print("subscribe on error : \(err)")
                
            }, onCompleted: {
                print("subscribe on Completed )")
                
            }, onDisposed: {
                print("subscribe on Disposed )")
            })
            .disposed(by: self.disposeBag)
        // 如果调用了 disposed(by：) 将dispose放到disposebag里面
        // 那么disposebag释放（dealloc）时，会把bag里面的所有的订阅行为都dispose掉
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    func placeViews() {
        self.label.frame = CGRect(x: 50, y: 200, width: 150, height: 30)
        self.textField.frame = CGRect(x: 50, y: 300, width: 250, height: 40)
        self.textField_new.frame = CGRect(x: 50, y: 350, width: 250, height: 40)
        let btnW : CGFloat = 100
        self.button1.frame = CGRect(x: 50,  y: 500, width: btnW, height: 30)
        self.button2.frame = CGRect(x: self.button1.frame.maxX + 10, y: 500, width: btnW, height: 30)
        self.button3.frame = CGRect(x: self.button2.frame.maxX + 10, y: 500, width: btnW, height: 30)
        self.tempSwitch.frame = CGRect(x: 50, y: self.button3.frame.maxY + 20 , width: btnW, height: 30)
    }
}

// MARK: - 为控件创建自定义可观察属性 - 扩展指定控件
extension UILabel {
    public var rx_fontSize : Binder<CGFloat> {
        return Binder<CGFloat>(self, binding: { (label, fontSize) in
            label.font = UIFont.systemFont(ofSize: fontSize)
        })
    }
    public var rx_backgroundColor : Binder<UIColor> {
        return Binder(self, binding: { (lb, color) in
            lb.backgroundColor = color
        })
    }
}

// MARK: - 为控件创建自定义可观察属性 - 扩展Reactive类
// 使用这种方式的话，在绑定的时候必须要调用rx.cusfontSize
extension Reactive where Base : UILabel {
    public var cus_fontSize : Binder<CGFloat> {
        return Binder<CGFloat>(self.base, binding: { (label, fontSize) in
            label.font = UIFont.systemFont(ofSize: fontSize)
        })
    }
    
    public var cus_backgroundColor : Binder<UIColor> {
        return Binder<UIColor>(self.base, binding:{ (label, color) in
            label.backgroundColor = color
        })
    }
    
}



struct ZYError : Error {
    var desc : String
    var code : Int
    init(desc : String , code : Int) {
        self.desc = desc
        self.code = code
    }
    
    var localizedDescription: String {
        return "ZYError , code : \(self.code), desc : \(self.desc)."
        
    }
}



