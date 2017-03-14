//
//  Network+HandyJSON.swift
//  Pods
//
//  Created by Chausson on 2017/2/28.
//
//

import Foundation
import HandyJSON
import Result

public protocol CHHandyRequestable:CHRequestable,CHRequestAdapter{
    associatedtype R:HandyJSON
    
}
public final class HandyResponse<Type:HandyJSON>:Response{
    public var jsonModel: Type?{
        get{
            guard let obj = Type.deserialize(from: self.jsonString) else {
                return nil
            }
            return obj
            
        }
    }
    
}
public extension CHHandyRequestable where Self:CHRequestAdapter{
    @discardableResult
    func requestJSON(_ completion: @escaping (_ result:R?)->()) -> DataRequest{
        let dataRequest = self.request { result in
            if case let .success(response) = result{
            let r = HandyResponse<R>(statusCode: response.statusCode, data: response.data, request: response.request, response: response.response,requestParm:response.requestParm)
                if let model = r.jsonModel{
                    completion(model)
                }else{
                    debugPrint("RequestJSON Error Reason is :\(r.debugDescription)")
                    completion(nil)

                }
            }
            if case let .failure(error) = result{
                debugPrint("RequestJSON Error Reason is :\(error)")
                completion(nil)
            }
        }
        return  dataRequest

    }
}


