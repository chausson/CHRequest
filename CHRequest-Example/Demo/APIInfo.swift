//
//  CHHost.swift
//  CHNetwork-Example
//
//  Created by Chausson on 2017/2/27.
//  Copyright © 2017年 Chausson. All rights reserved.
//

import Foundation
import CHRequest

let config = Config()
struct Config:SimplerConfigable {
    
}

extension SimplerConfigable {
    var baseURL:String{
        return "http://egarage.dev.sudaotech.com/platform/"
    }
    var httpHeaderFields:[String :String]{
        return ["token":"XXX"]
    }
    var commonParameters:[String :Any]{
        return ["":""]
    }
}


