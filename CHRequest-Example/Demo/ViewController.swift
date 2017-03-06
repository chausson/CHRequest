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
    }
    @IBAction func normalRequest(_ sender: UIButton) {
        l.request { result in
            if case let .success(response) = result {
                print("\nStr = \(response.jsonString)")
            }
            if case let .failure(error) = result{
                print("\nDebug = \(error.response.debugDescription)")
            }
            
        }
    }
    @IBAction func jsonRequest(_ sender: UIButton) {
        l.requestJSON { user in
            print("\nUser = \(user)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


