//
//  DownloadRequest.swift
//  CHRequest-Example
//
//  Created by Chausson on 2017/3/9.
//  Copyright © 2017年 Chausson. All rights reserved.
//

import Foundation
import CHRequest

struct ImageDownloadAPI:CHDownloadRequestable,SimplerConfigable {
    var path: String = ""
    var customURL: String = "http://img.tuku.com/upload/picture/2015/02/6Y8NxyJ.jpg"
    var fileName: String = "image.jpg"
}
