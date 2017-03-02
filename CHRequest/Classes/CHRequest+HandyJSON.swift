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

//public final class Handyer<ResultType:HandyJSON>:Simpler<ResultType>{
//    public typealias HandyCompletion = (_ result: Result<HandyResponse<R>,Error>) -> ()
//    
//    @discardableResult
//    open func requestJSON(_ completion: @escaping HandyCompletion) -> DataRequest{
//        let dataRequest =  self.requestNormal(self.target) { (result) in
//            if case let .success(response) = result{
//                let r = HandyResponse<R>(statusCode: response.statusCode, data: response.data ?? Data(), request: response.request, response: response.response,requestParm:response.requestParm)
//                completion(.success(r))
//            }
//            if case let .failure(error) = result{
//                completion(.failure(error))
//            }
//        }
//        return  dataRequest
//    }
//    
//    
//}
extension CHRequestable where Self:SimplerConfigable{
    func requestJSON(_ completion: @escaping  Completion) -> DataRequest{
        let dataRequest = self.request { result in
            
        }
        return  dataRequest

    }
}
//public final class HandyResponse<Type:HandyJSON>:Response{
//    public var jsonModel: Type?{
//        get{
//            guard let obj = Type.deserialize(from: self.jsonString) else {
//                return nil
//            }
//            return obj
//            
//        }
//    }
//
//}

