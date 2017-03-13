//
//  CHHost.swift
//  CHNetwork-Example
//
//  Created by Chausson on 2017/2/27.
//  Copyright © 2017年 Chausson. All rights reserved.
//

import Foundation
import CHRequest
struct CHAdapter:CHConfigableAdapter {
    var baseURL:String{
        return "http://egarage.dev.sudaotech.com/platform/"
    }
    var httpHeaderFields: [String: String] {
        return [:]
    }
    var commonParameters: [String: Any] {
        return ["key":"OOXX"]
    }
}

