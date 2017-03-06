//
//  LoginRequest.swift
//  CHNetwork-Example
//
//  Created by Chausson on 2017/2/25.
//  Copyright © 2017年 Chausson. All rights reserved.
//

import Foundation
import HandyJSON
import CHRequest

struct LoginRequest<Type:HandyJSON>:CHRequestable,SimplerConfigable {
    var userName:String?
    var password:String?
    typealias R = Type

    init(userName:String,password:String) {
        self.userName = userName
        self.password = password
    }
    func parameters() -> [String : Any] {
        let parm = ["userName":userName,
                    "password":password]
        return parm
    }
//    var method: HTTPMethod = .post
    var path: String = "basic/country"
    
}

struct User:HandyJSON{
    var code:Int = 0
    var message:String?
    var data:Country?
}
struct Country:HandyJSON {
    var limit:Int = 0
}

