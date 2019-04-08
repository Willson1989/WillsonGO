//
//  MusicListViewController.swift
//  Learning
//
//  Created by 郑毅 on 2019/3/5.
//  Copyright © 2019 ZhengYi. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MusicListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tableView : UITableView?
    var viewModel = MusicViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        placeTableView()
        
        let m = Father()
        let f = Family()
        f.mem = m
        let mmm = f.map { (m) -> Int in
            return m.makeMoney()
        }
        print("father make money : \(mmm)")
    }
    
    func placeTableView() {
        tableView = UITableView(frame: self.view.bounds)
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.rowHeight = 80
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: "musicCell")
        self.view.addSubview(tableView!)
        
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "musicCell", for: indexPath)
        let item = viewModel.data[indexPath.row]
        UITableViewCell(style: .subtitle, reuseIdentifier: "musicCell")
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = item.author
        return cell
    }
}


class MusicModel {
    var name : String = ""
    var author : String = ""
    
    init(name : String, author : String) {
        self.name = name
        self.author = author
    }
}


class MusicViewModel {
    let data = [
        MusicModel(name: "Hello", author: "Willson"),
        MusicModel(name: "World", author: "Helen"),
        MusicModel(name: "NiHao", author: "Zhengyi"),
        MusicModel(name: "Hahaha", author: "Zhujinqian"),
        ]
}


class Family {
    
    var mem : Memeber?
    
    func map<U>(f : (Memeber) -> U) -> U? {
        if mem == nil {
            return nil
        } else {
            return f(self.mem!)
        }
    }
}


protocol Memeber {
    func makeMoney() -> Int ;
}


class Father : Memeber {
    func makeMoney() -> Int {
        return 10000
    }
}

