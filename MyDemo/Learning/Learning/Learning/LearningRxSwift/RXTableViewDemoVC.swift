//
//  RXTableViewDemoVC.swift
//  Learning
//
//  Created by WillHelen on 2019/3/18.
//  Copyright © 2019年 ZhengYi. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class RXTableViewDemoVC: UIViewController, UITableViewDelegate {
    let bag = DisposeBag()
    lazy var tableView : UITableView = {
        let tb = UITableView(frame: .zero, style: UITableView.Style.plain)
        tb.separatorStyle = .none
        tb.backgroundColor = UIColor.white
        self.view.addSubview(tb)
        return tb
    }()
    
    private func registerCells() {
        self.tableView.register(UINib(nibName: "ImageCell", bundle: nil), forCellReuseIdentifier: "ImageCell")
        self.tableView.register(UINib(nibName: "DetailCell", bundle: nil), forCellReuseIdentifier: "DetailCell")
        self.tableView.register(UINib(nibName: "TitleCell", bundle: nil), forCellReuseIdentifier: "TitleCell")
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellid")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.registerCells()
        self.tableView.frame = self.view.bounds
        dataSource_2()
    }
    
    func dataSource_2() {
        typealias SSS = SectionModel<String, String>
        let sectionModel = SSS(model: "section 0",
                               items: ["ImageCell","DetailCell","TitleCell"])
        
        let ds = RxTableViewSectionedReloadDataSource<SSS>(configureCell: {
            (ds, tb, ip, item) in
            let cellid = ds.sectionModels[0].items[ip.item]
            let cell = tb.dequeueReusableCell(withIdentifier: cellid)!
            switch cellid {
            case "DetailCell":
                if let dCell = cell as? DetailCell {
                    dCell.descLb.text = "this is desc"
                }
            case "TitleCell":
                if let tCell = cell as? TitleCell {
                    tCell.ageLb.text = "29"
                    tCell.nameLb.text = "willson"
                    tCell.genderLb.text = "female"
                }
            default:break
            }
            return cell
        })
        let ob = Observable.just([sectionModel])
        ob.bind(to: tableView.rx.items(dataSource: ds)).disposed(by: self.bag)
    }
    
    func dataSource_1() {
        typealias SSS = SectionModel<String, String>
        let sectionModel = SSS(model: "section 0",
                               items: ["Willson",
                                       "Helen",
                                       "Zhengyi",
                                       "ZhuJinqian",
                                       "nuannuan"])

        let ds = RxTableViewSectionedReloadDataSource<SSS>(configureCell: {
            (ds, tb, ip, item) in
            let cell = tb.dequeueReusableCell(withIdentifier: "cellid")!
            cell.textLabel?.text = ds.sectionModels[0].items[ip.item]
            return cell
        })
        let ob = Observable.just([sectionModel])
        ob.bind(to: tableView.rx.items(dataSource: ds)).disposed(by: self.bag)
    }
    
    
    func normal() {
        let dataArray = [
            "Willson",
            "Helen",
            "Zhengyi",
            "ZhuJinqian",
            "nuannuan"
        ]
        let itemsOB = Observable.just(dataArray)
        
        itemsOB.bind(to: self.tableView.rx.items, curriedArgument: {(tb, item, elem) in
            let cell = tb.dequeueReusableCell(withIdentifier: "cellid")!
            cell.textLabel?.text = elem
            return  cell
        })
            .disposed(by: self.bag)
        
        self.tableView.rx.itemSelected.subscribe { (event) in
            guard let ip = event.element else {
                return
            }
            print("tb did selected : \(dataArray[ip.item])")
            }.disposed(by: self.bag)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.item == 0 {
            return 201
        }
        if indexPath.item == 1 {
            return 174
        }
        return 140
    }

}
