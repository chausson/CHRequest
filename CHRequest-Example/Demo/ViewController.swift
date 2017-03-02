//
//  ViewController.swift
//  CHNetwork-Example
//
//  Created by Chausson on 2017/2/21.
//  Copyright © 2017年 Chausson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let l = LoginRequest<User>(userName: "18116342840", password: "123456")

    override func viewDidLoad() {
        super.viewDidLoad()
        config.add(["password":"OOOXXXXX"])
//        normalRequest()
        jsonRequest()
    }
    func normalRequest() {
//        Simpler<User>(l).request { result in
//            if case let .success(response) = result {
//                print("\nStr = \(response.jsonString) +\nObj = \(response.json)")
//            }
//        }
    }
    func jsonRequest() {
        l.request { result in
            if case let .success(response) = result {
                print("\nStr = \(response.jsonString) \nDebug = \(response.debugDescription)")
            }

        }
//        Handyer<User>(l).requestJSON { (result) in
//            if case let .success(response) = result {
//                print("\nStr = \(response.jsonString) +\nObj = \(response.jsonModel?.code) \nDebug = \(response.debugDescription)")
//            }
//        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


