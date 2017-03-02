//
//  Network+Alamofire.swift
//  Pods
//
//  Created by Chausson on 2017/3/2.
//
//

import Foundation
import Alamofire

public typealias HTTPMethod = Alamofire.HTTPMethod
public typealias Manager = Alamofire.SessionManager
public typealias URLEncoding = Alamofire.URLEncoding
public typealias ParameterEncoding = Alamofire.ParameterEncoding
public typealias DataRequest = Alamofire.DataRequest
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
