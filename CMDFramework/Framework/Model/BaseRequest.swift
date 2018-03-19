//
//  BaseRequest.swift
//  CinemoodApp
//
//  Created by Nikolay Karataev aka Babaka on 25/04/2017.
//  Copyright © 2017 CINEMOOD. All rights reserved.
//

import Restofire
import Alamofire

protocol CMNDRequstable: Requestable, HTTPConfigurable, HTTPValidatable, HTTPRetryable {}

public struct BaseRequest: CMNDRequstable {
    public typealias Response = Any
    public typealias Model = Any
    public var path: String = ""
    public var parameters: Any?
    public var headers: [String : String]?
    public var method: Alamofire.HTTPMethod = .post
    public var encoding: ParameterEncoding?
    public var queue: DispatchQueue?
    public var sessionManager: Alamofire.SessionManager = {
        let sessionConfiguration = URLSessionConfiguration.default
        var headers = Alamofire.SessionManager.defaultHTTPHeaders
        if let userAgent = headers["User-Agent"] {
            if let index = userAgent.characters.index(of: "(") {
                headers["x-install-app-id"] = UserDefaults.standard.string(forKey: "installID")
                headers["User-Agent"]  = userAgent.insert(string: "\(UIDevice.current.model); ", index: userAgent.intIndex(index) + 1)
            }
        }
        sessionConfiguration.httpAdditionalHeaders = headers
        return Alamofire.SessionManager(configuration: sessionConfiguration)
    }()
    
    public var baseURL: String = ""
    
    public init(path: String, parameters: Any?, base: String) {
        self.baseURL = base
        self.path += path
        if parameters != nil {
            self.parameters = parameters!
        }
        self.headers = ["" : ""]
        self.queue = DispatchQueue(label: "com.cinemood.apimanager", qos: .background)
        self.method = .post
        self.encoding = URLEncoding.default
    }
    
    public init(path: String, parameters: Any?, headers: [String: String]?, base: String) {
        self.init(path: path, parameters: parameters, base: base)
        self.addHeader(headers)
    }
    
    public init(path: String, parameters: Any?, isPostMethod method: Bool, base: String) {
        self.init(path: path, parameters: parameters, base: base)
        self.setMethod(isPost: method)
    }
    
    public init(path: String, parameters: Any?, isPostMethod method: Bool, headers: [String: String]?, base: String) {
        self.init(path: path, parameters: parameters, headers: headers, base: base)
        self.setMethod(isPost: method)
    }

    public mutating func setMethod(isPost method: Bool) {
        self.method = (method == true) ? .post : .get
    }
    
    public mutating func setBaseUrl(_ url: String) {
        self.baseURL = url
    }
    
    public mutating func addHeader(_ headers: [String: String]?) {
        if let header = headers {
            self.headers = self.headers?.merged(with: header)
        }
    }
}


public  protocol HTTPConfigurable: Configurable { }
public  extension HTTPConfigurable {
    public var configuration: Configuration {
        var config = Configuration()
        config.method = .post
        return config
    }
}

public protocol HTTPValidatable: Validatable { }
public extension HTTPValidatable {
    public var validation: Validation {
        var validation = Validation()
        validation.acceptableStatusCodes = Array(200..<500)
        validation.acceptableContentTypes = ["application/json"]
        return validation
    }
}

public protocol HTTPRetryable: Retryable { }
extension HTTPRetryable {
    public var retry: Retry {
        var retry = Retry()
        retry.retryErrorCodes = [.timedOut,.networkConnectionLost]
        retry.retryInterval = 5
        retry.maxRetryAttempts = 2
        return retry
    }
}

extension Restofire.DataResponseSerializable where Response == Any {
    public var responseSerializer: DataResponseSerializer<Response> {
        return DataRequest.jsonResponseSerializer()
    }
}
