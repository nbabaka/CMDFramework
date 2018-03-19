//
//  CMDBaseAPIManager.swift
//  CINEMOOD Sales Club
//
//  Created by Nikolay Karataev aka Babaka on 04.09.17.
//  Copyright © 2017 CINEMOOD Trendsetters Co. All rights reserved.
//

import Restofire
import Alamofire
import SwiftyJSON

public typealias APIResponse = (Int, JSON?) -> Void
public typealias APIResponseElementary = (JSON) -> Void

open class CMDBaseAPIManager: NSObject {
    open var baseUrl: String?
    open var authPrefix: String = "Bearer "
    open var authToken: String?
    
    open func getAuthRequest(path: String, parameters: Any?, advanceUrlParametr: String?, block: APIResponse?) {
        getRequest(path: path, parameters: parameters, advanceUrlParametr: advanceUrlParametr, isAuth: true, block: block)
    }
    
    open func postAuthRequest(path: String, parameters: Any?, advanceUrlParametr: String?, block: APIResponse?) {
        postRequest(path: path, parameters: parameters, advanceUrlParametr: advanceUrlParametr, isAuth: true, block: block)
    }
    
    open func getRequest(path: String, parameters: Any?, advanceUrlParametr: String?, isAuth: Bool, block: APIResponse?) {
        request(path: path, parameters: parameters, advanceUrlParametr: advanceUrlParametr, method: .get, isAuth: isAuth, block: block)
    }
    
    open func postRequest(path: String, parameters: Any?, advanceUrlParametr: String?, isAuth: Bool, block: APIResponse?) {
        request(path: path, parameters: parameters, advanceUrlParametr: advanceUrlParametr, method: .post, isAuth: isAuth, block: block)
    }
    
    open func request(path: String, parameters: Any?, advanceUrlParametr: String?, method: HTTPMethod, isAuth: Bool, block: APIResponse?) {
        let url = advanceUrlParametr == nil ? path : getUrl(main: path, option: advanceUrlParametr)
        var request = isAuth ? authRequest(path: url, parameters: parameters) : BaseRequest(path: url, parameters: parameters, base: self.baseUrl ?? "")
        request.method = method
        sendRequest(request, onCompleteBlock: block)
    }
    
    open func authRequest(path: String, parameters: Any?) -> BaseRequest {
        guard let token = self.authToken else {
            return BaseRequest(path: path, parameters: parameters, base: self.baseUrl ?? "")
        }
        return BaseRequest(path: path, parameters: parameters, headers: ["Authorization": self.authPrefix + token], base: self.baseUrl ?? "")
    }
    
    open func sendRequest(_ request: BaseRequest, onCompleteBlock: APIResponse?) {
        request.execute() { [weak self] in
            self?.checkResponseAndComplete(response: $0, onComplete: onCompleteBlock)
        }
    }
    
    open func cancelOperation(request: AOperation<BaseRequest>) {
        request.cancel()
    }
    
    open func checkResponseAndComplete(response: Alamofire.DataResponse<Any>, onComplete: APIResponse?) {
        guard let code = response.response?.statusCode else {
            inMain(block: onComplete, withCode: 0, andJson: nil)
            return
        }
        let json = JSON(response.result.value ?? "")
        inMain(block: onComplete, withCode: code, andJson: json)
    }
    
    open func inMain(block: APIResponse?, withCode: Int, andJson: JSON?) {
        main {
            block?(withCode, andJson)
        }
    }
    
    open func getUrl(main: String, option: String?) -> String {
        return String(format: main, option ?? "")
    }
}
