//
//  CHNetwork.swift
//  CHNetwork
//
//  Created by Chausson on 2017/2/22.
//  Copyright © 2017年 Chausson. All rights reserved.
//

import Foundation
//import HandyJSON

public protocol CHRequestable{
//    /// return  Object of type
//    associatedtype R
    
    /// Request Path append path to host
    var path: String { get }
    
    /// Request Method
    var method: HTTPMethod { get }
    
    var customURL: String { get }
    
    /// - Returns: headers
    func headers() -> [String: String]
    /// - Returns: parameters
    
    func parameters() -> [String: Any]
    
    
    var encoding:ParameterEncoding { get}
    
    //    init()
    
}
public protocol CHDownloadRequestable:CHRequestable{
    var fileName: String { get }
}

public protocol CHDownloadResumeRequestable: CHDownloadRequestable {
    var resumeData: Data { get }
}
public extension CHRequestable{
    
    var method: HTTPMethod {
        return .get
    }
    var customURL: String {
        return ""
    }
    var encoding: ParameterEncoding {
        switch method {
        case .get:
            return URLEncoding.default
        default:
            return JSONEncoding.default

        }
    }
    func headers() -> [String: String] {
        return [ : ]
    }
    func parameters() -> [String: Any] {
        return [ : ]
    }
    
}


