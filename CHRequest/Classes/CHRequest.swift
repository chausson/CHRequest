//
//  CHNetwork.swift
//  CHNetwork
//
//  Created by Chausson on 2017/2/22.
//  Copyright © 2017年 Chausson. All rights reserved.
//

import Foundation

/// Request Protocol
public protocol CHRequestable{
    
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
/// Download Protocol
public protocol CHDownloadRequestable:CHRequestable{
    var fileName: String { get }
}
public protocol CHDownloadResumeRequestable: CHDownloadRequestable {
    var resumeData: Data { get }
}
/// Upload Protocol
public protocol CHUploadRequestable:CHRequestable{
}
public extension CHUploadRequestable{
    var method: HTTPMethod {
        return .post
    }
    var encoding: ParameterEncoding {
        return URLEncoding.default
    }
}
public protocol CHUploadDataRequestable:CHUploadRequestable{
    
    var fileName: String { get }

    var mimeType: String { get }

    var encodingMemoryThreshold: UInt64 { get }
    
    var data: Data { get }
    
}

public extension CHUploadDataRequestable {
    var encodingMemoryThreshold: UInt64 {
        return 10_000_000
    }
    var fileName: String {
        return "defaultFileName"
    }
    var mimeType: String {
        return "image/png"
    }
    var path: String {
        return ""
    }
}
public protocol CHUploadFileRequest: CHUploadRequestable {
    var fileURL: URL { get }
}

/// Conforming to this protocol to create an upload form that contains a stream object
public protocol CHUploadStreamRequestable: CHUploadRequestable {
    var stream: InputStream { get }
}





