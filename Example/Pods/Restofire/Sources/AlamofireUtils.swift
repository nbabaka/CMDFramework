//
//  AlamofireRequest.swift
//  Restofire
//
//  Created by Rahul Katariya on 19/04/16.
//  Copyright © 2016 AarKay. All rights reserved.
//

import Alamofire

class AlamofireUtils {
    
    static func alamofireDataRequestFromRequestable<R: Requestable>(_ requestable: R) -> Alamofire.DataRequest {
        
        var request = requestable.sessionManager.request(requestable.baseURL + requestable.path, method: requestable.method, parameters: requestable.parameters as? [String: Any], encoding: requestable.encoding, headers: requestable.headers + requestable.configuration.headers)
        
        if let parameters = requestable.parameters as? [Any] {
            do {
                let encodedURLRequest = try encode(request.request!, parameters: parameters, encoding: requestable.encoding)
                request = Alamofire.request(encodedURLRequest)
            } catch {
                fatalError("Parameters cannot be of type [Any]. If you think it is an issue, please create one or send a pull request if you can solve it at http://github.com/Restofire/Restofire.")
            }
        }
        
        authenticateRequest(request, usingCredential: requestable.credential)
        validateRequest(request, forAcceptableContentTypes: requestable.acceptableContentTypes)
        validateRequest(request, forAcceptableStatusCodes: requestable.acceptableStatusCodes)
        validateRequest(request, forValidation: requestable.validationBlock)
        
        return request
        
    }
    
    fileprivate static func authenticateRequest(_ request: Alamofire.DataRequest, usingCredential credential:URLCredential?) {
        guard let credential = credential else { return }
        request.authenticate(usingCredential: credential)
    }
    
    fileprivate static func validateRequest(_ request: Alamofire.DataRequest, forAcceptableContentTypes contentTypes:[String]?) {
        guard let contentTypes = contentTypes else { return }
        request.validate(contentType: contentTypes)
    }
    
    fileprivate static func validateRequest(_ request: Alamofire.DataRequest, forAcceptableStatusCodes statusCodes:[Int]?) {
        guard let statusCodes = statusCodes else { return }
        request.validate(statusCode: statusCodes)

    }
    
    fileprivate static func validateRequest(_ request: Alamofire.DataRequest, forValidation validation:Alamofire.DataRequest.Validation?) {
        guard let validation = validation else { return }
        request.validate(validation)
    }
    
    fileprivate static func encode(_ urlRequest: URLRequestConvertible, parameters: [Any]?, encoding: ParameterEncoding) throws -> URLRequest {
        var urlRequest = try urlRequest.asURLRequest()
        
        guard let parameters = parameters , !parameters.isEmpty else {
            return urlRequest
        }
        
        switch encoding {
        case let enc as JSONEncoding:
            do {
                let data = try JSONSerialization.data(withJSONObject: parameters, options: enc.options)
                
                if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                    urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
                }
                
                urlRequest.httpBody = data
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
            return urlRequest
        case let enc as PropertyListEncoding:
            do {
                let data = try PropertyListSerialization.data(
                    fromPropertyList: parameters,
                    format: enc.format,
                    options: enc.options
                )
                
                if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                    urlRequest.setValue("application/x-plist", forHTTPHeaderField: "Content-Type")
                }
                
                urlRequest.httpBody = data
            } catch {
                throw AFError.parameterEncodingFailed(reason: .propertyListEncodingFailed(error: error))
            }
            return urlRequest
        default:
            fatalError("Parameters as array are only implemented in .JSON and .Propertylist parameter encoding. If you think it is an issue, please create one or send a pull request if you can solve it at http://github.com/Restofire/Restofire.")
        }
        
    }
    
}

extension AlamofireUtils {
    
    static func castAnyResultToRequestableModel<M>(result: Result<Any>) -> Result<M> {
        if let error = result.error {
            return .failure(error)
        } else if let value = result.value as? M {
            return .success(value)
        } else {
            fatalError("ResponseSerializer failed to serialize the response to Requestable Model of type \(M.self)")
        }
    }
    
}
