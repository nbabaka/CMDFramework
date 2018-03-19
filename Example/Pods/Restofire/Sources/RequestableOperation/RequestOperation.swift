//
//  RequestOperation.swift
//  Restofire
//
//  Created by Rahul Katariya on 28/01/18.
//  Copyright © 2018 AarKay. All rights reserved.
//

import Foundation

/// An NSOperation that executes the `Requestable` asynchronously.
public class RequestOperation<R: Requestable>: AOperation<R> {
    
    let requestable: R
    let dataRequest: () -> DataRequest
    let completionHandler: ((DataResponse<R.Response>) -> Void)?
    
    /// Intializes an request operation.
    ///
    /// - Parameters:
    ///   - requestable: The `Requestable`.
    ///   - request: The request closure.
    ///   - completionHandler: The async completion handler called
    ///     when the request is completed
    public init(requestable: R, request: @escaping () -> DataRequest, completionHandler: ((DataResponse<R.Response>) -> Void)?) {
        self.requestable = requestable
        self.dataRequest = request
        self.completionHandler = completionHandler
        super.init(configurable: requestable, request: request)
    }
    
    override func handleDataResponse(_ response: DefaultDataResponse) {
        let request = self.request as! DataRequest
        request.response(
            queue: requestable.queue,
            responseSerializer: requestable.responseSerializer
        ) { ( response: (DataResponse<R.Response>)) in
            self.completionHandler?(response)
            if let error = response.error {
                self.requestable.request(self, didFailWithError: error)
                self.isFinished = true
            } else {
                self.requestable.request(self, didCompleteWithValue: response.value!)
                self.isFinished = true
            }
        }
    }
    
    /// Creates a copy of self
    open override func copy() -> AOperation<R> {
        return RequestOperation(
            requestable: requestable,
            request: dataRequest,
            completionHandler: completionHandler
        )
    }
    
}
