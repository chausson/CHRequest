//
//  CHNetwork.swift
//  CHNetwork
//
//  Created by Chausson on 2017/2/22.
//  Copyright © 2017年 Chausson. All rights reserved.
//

import Foundation
import Result
import HandyJSON

public protocol CHRequestable{
    /// return  Object of type
    associatedtype R:HandyJSON
    
    /// Request Path append path to host
    var path: String { get }
    
    /// Request Method
    var method: HTTPMethod { get }
    
    var customURL: String { get }
    
    /// - Returns: headers
    func headers() -> [String: String]
    /// - Returns: parameters
    
    func parameters() -> [String: Any]
    
    var task:Task { get}
    
    var encoding:ParameterEncoding { get}
    
    //    init()
    
}
public enum Task {
    case request
    case upload
    case download
}
public extension CHRequestable{
    
    var method: HTTPMethod {
        return .get
    }
    var task: Task {
        return .request
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

public typealias ResultType = Result<Response, Error>
public typealias ResponseHandler = (DefaultDataResponse) -> Void
public typealias Completion = (_ result:ResultType)->()

public extension CHRequestable where Self:SimplerConfigable{
 
    
    @discardableResult
    func request(_ completion: @escaping  Completion) -> DataRequest {
        var url = self.baseURL+self.path
        if  self.customURL.characters.count > 0{
            url = self.customURL
        }
        if !url.hasPrefix("http://") {
            debugPrint("[Warning Request of URL is not valid]")
        }
        // 拼接Config中的基础参数
        let parms:[String :Any] = jointDic(self.parameters(),self.allParameters)
        let headFields:[String :String] = jointDic(self.headers(),self.allHttpHeaderFields) as! [String : String]
        
        let task = self.task
        let dataRequest = requestNormal(url, method: self.method, parameters: parms, encoding: self.encoding, headers: headFields)
        
        switch task {
        case .request:
            let defultResponseHandler:ResponseHandler = { defultResponse  in
                guard let completionClosure:Completion = completion else{
                    debugPrint("\n[\(url) Request Finished nothing to do]")
                    return
                }
                //返回Response 传入闭包
                let result =  serializeResponse(defultResponse.response, request: defultResponse.request, data: defultResponse.data, error: defultResponse.error,parm:parms)
                
                completionClosure(result)
                
            }
            
            dataRequest.response(completionHandler: defultResponseHandler)
            
        default:
            dataRequest.response(completionHandler: { defultResponse in
                
            })
        }
        return dataRequest
    }
}

private func jointDic(_ dic:[String:Any], _ otherDic:[String:Any]) -> [String:Any] {
    var newDic:[String :Any] = [String: String]()
    dic.forEach { (key, value) in
        newDic[key] = value
    }
    otherDic.forEach { (key, value) in
        newDic[key] = value
    }
    return newDic
    
}
private func serializeResponse(_ response: HTTPURLResponse?, request: URLRequest?, data: Data?, error: Swift.Error?,parm: [String:Any]?) ->
    ResultType{
        switch (response, data, error) {
        case let (.some(response), data, .none):
            let response = Response(statusCode: response.statusCode, data: data ?? Data(), request: request, response: response,requestParm:parm)
            return .success(response)
        case let (_, _, .some(error)):
            let error = Error.underlying(error)
            return .failure(error)
        default:
            let error = Error.underlying(NSError(domain: NSURLErrorDomain, code: NSURLErrorUnknown, userInfo: nil))
            return .failure(error)
        }
}


