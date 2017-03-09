//
//  CHRequest+Extension.swift
//  Pods
//
//  Created by Chausson on 2017/3/9.
//
//

import Foundation
import Result

public typealias ResultType = Result<Response, Error>
public typealias ResponseHandler = (DefaultDataResponse) -> Void
public typealias RequestCompletion = (_ result:ResultType)->()
public typealias DownloadCompletion = (Data,URL) -> Void
public extension CHRequestable where Self:SimplerConfigable{
    
    
    @discardableResult
    func request(_ completion: @escaping  RequestCompletion) -> DataRequest {
        let baseInfo = obtainBaseInfo(target:self)
        
        let dataRequest = requestNormal(baseInfo.url, method: self.method, parameters: baseInfo.parms, encoding: self.encoding, headers: baseInfo.headFields)
        
        let defultResponseHandler:ResponseHandler = { defultResponse  in
            guard let completionClosure:RequestCompletion = completion else{
                debugPrint("\n[\(baseInfo.url) Request Finished nothing to do]")
                return
            }
            //返回Response 传入闭包
            let result =  serializeResponse(defultResponse.response, request: defultResponse.request, data: defultResponse.data, error: defultResponse.error,parm:baseInfo.parms)
            
            completionClosure(result)
            
        }
        
        dataRequest.response(completionHandler: defultResponseHandler)
        return dataRequest
    }
}
public extension CHDownloadRequestable where Self:SimplerConfigable{
        @discardableResult
        func download(_ completion: @escaping  DownloadCompletion) -> DownloadRequest {
            let baseInfo = obtainBaseInfo(target:self)
    
            let downloadRequest = downloadNormal(baseInfo.url, method: self.method, parameters: baseInfo.parms, encoding: self.encoding, headers: baseInfo.headFields, fileName: self.fileName).downloadProgress { (progress) in
                
            }.responseData { (response) in
                
                if let data = response.result.value ,let url = response.destinationURL{
                    completion(data,url)
                }
            }
    
            return downloadRequest
        }
        @discardableResult
        func download(progressClosure:@escaping (Progress) -> Void,_ completion: @escaping  DownloadCompletion) -> DownloadRequest {
            let baseInfo = obtainBaseInfo(target:self)
            
            let downloadRequest = downloadNormal(baseInfo.url, method: self.method, parameters: baseInfo.parms, encoding: self.encoding, headers: baseInfo.headFields, fileName: self.fileName).downloadProgress { (progress) in
                    if progressClosure != nil{
                        progressClosure(progress)
                    }
                }.responseData { (response) in

                    if let data = response.result.value ,let url = response.destinationURL{
                        completion(data,url)
                    }
            }
            
            return downloadRequest
        }

    
}
public extension CHUploadRequestable where Self:CHDownloadRequestable{

//    @discardableResult
//    func upload() -> UploadRequest {
//        let uploadRequest = uploadNormal()
//        return uploadRequest
//
//    }
}
private func obtainBaseInfo<T:CHRequestable&SimplerConfigable>(target:T)
    -> (url:String,parms:[String :Any],headFields:[String :String]){
        
        var url = target.baseURL+target.path
        if  target.customURL.characters.count > 0{
            url = target.customURL
        }
        if !url.hasPrefix("http://") {
            debugPrint("[Warning Request of URL is not valid]")
        }
        // 拼接Config中的基础参数
        let parms:[String :Any] = jointDic(target.parameters(),target.allParameters)
        let headFields:[String :String] = jointDic(target.headers(),target.allHttpHeaderFields) as! [String : String]
        return (url,parms,headFields)
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


