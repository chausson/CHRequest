//
//  Network+Alamofire.swift
//  Pods
//
//  Created by Chausson on 2017/3/2.
//
//

import Foundation
import Alamofire
public typealias JSONEncoding = Alamofire.JSONEncoding
public typealias HTTPMethod = Alamofire.HTTPMethod
public typealias Manager = Alamofire.SessionManager
public typealias URLEncoding = Alamofire.URLEncoding
public typealias ParameterEncoding = Alamofire.ParameterEncoding
public typealias DataRequest = Alamofire.DataRequest
public typealias DownloadRequest = Alamofire.DownloadRequest
public typealias UploadRequest = Alamofire.UploadRequest


public typealias DefaultDataResponse = Alamofire.DefaultDataResponse

public func requestNormal(
    _ url: URLConvertible,
    method: HTTPMethod = .get,
    parameters: Parameters? = nil,
    encoding: ParameterEncoding = URLEncoding.default,
    headers: HTTPHeaders? = nil)
    -> DataRequest
{
    return SessionManager.default.request(
        url,
        method: method,
        parameters: parameters,
        encoding: encoding,
        headers: headers
    )
}

public func downloadNormal(
    _ url: URLConvertible,
    method: HTTPMethod = .get,
    parameters: Parameters? = nil,
    encoding: ParameterEncoding = URLEncoding.default,
    headers: HTTPHeaders? = nil,
    fileName:String = "DefultName")
    -> DownloadRequest
{
    let destination: DownloadRequest.DownloadFileDestination = { _, _ in
        var documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        let fileURL = documentsURL.appendPathComponent(fileName)
        return (documentsURL, [.removePreviousFile, .createIntermediateDirectories])
    }
    return  SessionManager.default.download(url, method: method, parameters: parameters, encoding: encoding, headers: headers, to: destination)
}
public func uploadNormal(
    _ url: URLConvertible,
    method: HTTPMethod = .post,
    parameters: Parameters? = nil,
    encoding: ParameterEncoding = URLEncoding.default,
    headers: HTTPHeaders? = nil)
    -> DataRequest
{
    return SessionManager.default.request(
        url,
        method: method,
        parameters: parameters,
        encoding: encoding,
        headers: headers
    )
}
