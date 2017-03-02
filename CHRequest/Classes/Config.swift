//
//  Config.swift
//  Pods
//
//  Created by Chausson on 2017/2/27.
//
//

import Foundation

private var headerFields:[String: String]?
private var allParms:[String: Any]?

public protocol SimplerConfigable {
    var baseURL: String { get }
    var httpHeaderFields: [String: String]{ get }
    var commonParameters: [String: Any] { get }
    var allHttpHeaderFields:[String: String] { get }
    var allParameters:[String: Any] { get }

//    var commonRequestClosure:()->Void{ get }
}
public extension SimplerConfigable{
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
public extension SimplerConfigable{
    @discardableResult
    func add(_ httpHeaderFields:[String: String]) -> Bool {
        guard let headers:[String:String] = httpHeaderFields, headers.isEmpty == false else {
            return false
        }

        var newHeaders = allHttpHeaderFields ?? [String: String]()
        headers.forEach { (key, value) in
            newHeaders[key] = value
        }
        self.httpHeaderFields.forEach { (key, value) in
            newHeaders[key] = value
        }
        headerFields = newHeaders
        return allHttpHeaderFields != nil
    }
    @discardableResult
    func add(_ parameters: [String: Any]?) -> Bool? {
        guard let unwrappedParameters = parameters, unwrappedParameters.isEmpty == false else {
            return false
        }
        
        var newParameters = allParms ?? [String: Any]()
        unwrappedParameters.forEach { (key, value) in
            newParameters[key] = value
        }
        self.commonParameters.forEach { (key, value) in
            newParameters[key] = value
        }
        allParms = newParameters
        return allParms != nil
    }
    func clearAll() -> Bool {
        allParms?.removeAll(keepingCapacity: false)
        headerFields?.removeAll(keepingCapacity: false)
        return (allParms?.count ?? 0)! + (headerFields?.count ?? 0)! > 0
    }
}
