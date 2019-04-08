//
//  GItListViewController.swift
//  Learning
//
//  Created by WillHelen on 2019/4/7.
//  Copyright © 2019年 ZhengYi. All rights reserved.
//

import UIKit
import Alamofire
import RxSwift
import RxCocoa

class GitListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}

class RepoModel {
    
}


enum NetworkPath : URLConvertible {
    
    case repoList([RepoModel])
    
    var path : String {
        get {
            switch self {
            case .repoList(_):
                return "/search/repositories"
            }
        }
    }
    
    func asURL() throws -> URL {
        guard let url = URL(string: path) else {
            throw AFError.invalidURL(url: self)
        }
        return url
    }
    
}

struct GitNetManager {
    
    var baseUrlString : String {
        return "https://api.github.com"
    }
    
    public func request(_ path : NetworkPath) {
        guard let url = try? path.asURL() else {
            return
        }
        
        request(url, method: .post, parameters: <#T##Parameters?#>, encoding: <#T##ParameterEncoding#>, headers: <#T##HTTPHeaders?#>)
        
    }
}


