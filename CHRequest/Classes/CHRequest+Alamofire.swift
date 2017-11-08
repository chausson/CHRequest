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
public typealias MultipartFormData = Alamofire.MultipartFormData
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
        
        _ = documentsURL.appendPathComponent(fileName)
        return (documentsURL, [.removePreviousFile, .createIntermediateDirectories])
    }
    return  SessionManager.default.download(url, method: method, parameters: parameters, encoding: encoding, headers: headers, to: destination)
}
public func uploadNormal(
    _ data:Data,
    to url: URLConvertible,
    method: HTTPMethod = .post,
    encoding: ParameterEncoding = URLEncoding.default,
    headers: HTTPHeaders? = nil)
    -> UploadRequest
{
    var _: (MultipartFormData) -> Void = { multipartFormData in
        multipartFormData.append(data, withName: "name", fileName: "fileName", mimeType: "image/png")
        
    }
    return SessionManager.default.upload(data, to: url, method: method, headers: headers)
}
public func uploadNormal(
    _ fielURL:URL,
    to url: URLConvertible,
    method: HTTPMethod = .post,
    encoding: ParameterEncoding = URLEncoding.default,
    headers: HTTPHeaders? = nil)
    -> UploadRequest
{
    return SessionManager.default.upload(fielURL, to: url, method: method, headers: headers )
}
public func uploadNormal(
    _ stream:InputStream,
    to url: URLConvertible,
    method: HTTPMethod = .post,
    encoding: ParameterEncoding = URLEncoding.default,
    headers: HTTPHeaders? = nil)
    -> UploadRequest
{
    
    return SessionManager.default.upload(stream, to: url, method: method, headers: headers)
}
public func uploadNormal(
    _ multipartFormData:@escaping (MultipartFormData) -> Void,
    to url: URLConvertible,
    encodingMemoryThreshold:UInt64,
    method: HTTPMethod = .post,
    encoding: ParameterEncoding = URLEncoding.default,
    headers: HTTPHeaders? = nil,
    completion: ((UploadRequest) -> Void)?)
{
    SessionManager.default.upload(multipartFormData: multipartFormData, usingThreshold: encodingMemoryThreshold, to: url, method:method, headers: headers, encodingCompletion: { (encodingResult) in
        switch encodingResult {
        case .success(let upload, _, _):
            completion?(upload)
            
            break
        case .failure(let encodingError):
            debugPrint(encodingError)
            break
        }
    })
}
