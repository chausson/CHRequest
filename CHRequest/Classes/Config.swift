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

open class CHRequestAdapter: RequestAdapter {
    open  static let instance = CHRequestAdapter()
    open  var configuration:CHConfigableAdapter?
    /// Inspects and adapts the specified `URLRequest` in some manner if necessary and returns the result.
    ///
    /// - parameter urlRequest: The URL request to adapt.
    ///
    /// - throws: An `Error` if the adaptation encounters an error.
    ///
    /// - returns: The adapted `URLRequest`.
    public func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        if let url = urlRequest.url?.absoluteString, !url.hasPrefix("http://"){
                debugPrint("[Warning Request of URL is not valid]")

        }

        if let urlString = urlRequest.url?.absoluteString{
            for (key, value) in self.allHttpHeaderFields {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }
   
        return urlRequest
    }
    @discardableResult
    public func add(httpHeaderFields:[String: String]) -> Bool {
        guard let headers:[String:String] = httpHeaderFields, headers.isEmpty == false else {
            return false
        }
        
        var newHeaders = allHttpHeaderFields ?? [String: String]()
        headers.forEach { (key, value) in
            newHeaders[key] = value
        }
        if let configuration = self.configuration {
            configuration.httpHeaderFields.forEach { (key, value) in
                newHeaders[key] = value
            }
        }
      
        headerFields = newHeaders
        return allHttpHeaderFields != nil
    }
    @discardableResult
    public func add(parameters: [String: Any]?) -> Bool? {
        guard let unwrappedParameters = parameters, unwrappedParameters.isEmpty == false else {
            return false
        }
        
        var newParameters = allParms ?? [String: Any]()
        unwrappedParameters.forEach { (key, value) in
            newParameters[key] = value
        }
        if let configuration = self.configuration {
            configuration.commonParameters.forEach { (key, value) in
                newParameters[key] = value
            }
        }
        allParms = newParameters
        return allParms != nil
    }
    public func clearAll() -> Bool {
        allParms?.removeAll(keepingCapacity: false)
        headerFields?.removeAll(keepingCapacity: false)
        return (allParms?.count ?? 0)! + (headerFields?.count ?? 0)! > 0
    }

}

public protocol CHConfigableAdapter {
    var baseURL: String { get }
    var httpHeaderFields: [String: String]{ get }
    var commonParameters: [String: Any] { get }
//    var commonRequestClosure:()->Void{ get }
}
public extension CHRequestAdapter{
    var allHttpHeaderFields:[String: String] {
        var newHeaders = headerFields ?? [String: String]()
        if let configuration = self.configuration {
            configuration.httpHeaderFields.forEach { (key, value) in
                newHeaders[key] = value
            }
        }
        return newHeaders
    }
    var allParameters:[String: Any] {
        var newParms = allParms ?? [String: Any]()
        if let configuration = self.configuration {
            configuration.commonParameters.forEach { (key, value) in
                newParms[key] = value
            }
        }
        return newParms
    }
}
