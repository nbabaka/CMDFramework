//
//  CMDFacebookManager.swift
//  CinemoodApp
//
//  Created by Nikolay Karataev aka Babaka on 05/05/2017.
//  Copyright © 2017 CINEMOOD. All rights reserved.
//

import Foundation
import FacebookCore
import FacebookLogin

public typealias CMDFacebookSuccessBlock = (Any) -> Void
public typealias CMDFacebookFailedBlock = (CMDFacebookError) -> Void

public enum CMDFacebookError {
    case failed
    case cancelled
}

open class CMDFacebookManager: NSObject {
    public func getCurrentToken() -> String? {
        return AccessToken.current?.authenticationToken
    }
    
    public func getCurrentUserID() -> String? {
        return AccessToken.current?.userId
    }
    
    public func getEmail(onComplete: CMDFacebookSuccessBlock?) {
        self.getField("email", onComplete: onComplete)
    }
    
    public func getPicture(onComplete: CMDFacebookSuccessBlock?) {
        self.getField("picture.type(large)", lookFor: "picture", onComplete: onComplete)
    }
    
    public func getUsername(onComplete: CMDFacebookSuccessBlock?) {
        self.getField("name", onComplete: onComplete)
    }
    
    public func getField(_ field: String, lookFor altField: String = "", onComplete: CMDFacebookSuccessBlock?) {
        let request = GraphRequest(graphPath: "me", parameters: ["fields": field], accessToken: AccessToken.current, httpMethod: .GET, apiVersion: FacebookCore.GraphAPIVersion.defaultVersion)
        request.start { (response, result) in
            switch result {
            case .success(let value):
                let dictionary = value.dictionaryValue
                let field = dictionary![altField != "" ? altField : field] as Any
                onComplete?(field)
            case .failed(let error):
                print(error)
            }
        }
    }
    
    public func login(controller: UIViewController, onComplete: CMDFacebookSuccessBlock?, onFailed: CMDFacebookFailedBlock? = nil) {
        let loginManager = LoginManager()
        loginManager.logOut()
        loginManager.logIn([.publicProfile, .email], viewController: controller) { loginResult in
            switch loginResult {
            case .failed(let error):
                print(error)
                onFailed?(.failed)
            case .cancelled:
                print("User cancelled login via facebook.")
                onFailed?(.cancelled)
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                print("User sign in with facebook successfull - permision granted \(grantedPermissions) and declined \(declinedPermissions)")
                onComplete?(accessToken.authenticationToken)
            }
        }
    }
}
