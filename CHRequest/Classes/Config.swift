//
//  Config.swift
//  Pods
//
//  Created by Chausson on 2017/2/27.
//
//

import Foundation
import Alamofire
private var headerFields:[String: String]?
private var allParms:[String: Any]?

public protocol CHRequestAdapter {
    var baseURL: String { get }
    var httpHeaderFields: [String: String]{ get }
    var commonParameters: [String: Any] { get }
    var allHttpHeaderFields:[String: String] { get }
    var allParameters:[String: Any] { get }
    
    //    var commonRequestClosure:()->Void{ get }
}
public extension CHRequestAdapter{
    var allHttpHeaderFields:[String: String] {
        var newHeader = headerFields ?? [String: String]()
        self.httpHeaderFields.forEach { (key, value) in
            newHeader[key] = value
        }
        return newHeader
    }
    var allParameters:[String: Any] {
        var newParms = allParms ?? [String: Any]()
        self.commonParameters.forEach { (key, value) in
            newParms[key] = value
        }
        return newParms
    }
}
public extension CHRequestAdapter{
    @discardableResult
    func add( httpHeaderFields:[String: String]?) -> CHRequestAdapter? {
        guard let headers:[String:String] = httpHeaderFields, headers.isEmpty == false else {
            return nil
        }
        
        var newHeaders = allHttpHeaderFields
        headers.forEach { (key, value) in
            newHeaders[key] = value
        }
        self.httpHeaderFields.forEach { (key, value) in
            newHeaders[key] = value
        }
        headerFields = newHeaders
        return self
    }
    @discardableResult
    func add( parameters: [String: Any]?) -> CHRequestAdapter? {
        guard let unwrappedParameters = parameters, unwrappedParameters.isEmpty == false else {
            return nil
        }
        
        var newParameters = allParms ?? [String: Any]()
        unwrappedParameters.forEach { (key, value) in
            newParameters[key] = value
        }
        self.commonParameters.forEach { (key, value) in
            newParameters[key] = value
        }
        allParms = newParameters
        return self
    }
    func clearAll() -> Bool {
        allParms?.removeAll(keepingCapacity: false)
        headerFields?.removeAll(keepingCapacity: false)
        return (allParms?.count ?? 0)! + (headerFields?.count ?? 0)! > 0
    }
}

