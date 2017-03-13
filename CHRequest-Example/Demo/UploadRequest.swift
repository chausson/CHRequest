//
//  UploadRequest.swift
//  CHRequest-Example
//
//  Created by Chausson on 2017/3/9.
//  Copyright © 2017年 Chausson. All rights reserved.
//

import Foundation
import CHRequest

struct CHUploadImage:CHUploadDataRequestable {
    var data: Data
    
    init(_ data:Data) {
        self.data = data
    }
    var fileName: String = "image"
    
    var mimeType: String = "image/png"
        
    var customURL: String = "http://egarage.dev.sudaotech.com/platform/image"
}
