//
//  SplashDataFlow.swift
//  WiFi-Map-Test
//
//  Created by Dima Bazhaniuk on 16.06.2022.
//

import UIKit

enum Splash {
    // MARK: Use cases
    enum Something {
        struct Request {
        }
        
        struct Response {
            var result: SplashRequestResult
        }
        
        struct ViewModel {
            var state: ViewControllerState
        }
        
    }
    
    enum SplashRequestResult {
        case failure(SplashError)
        case successCategory([CoordinateModel])
    }
    
    enum ViewControllerState {
        case loading
        case resultMap([CoordinateViewModel])
        case emptyResult
        case error(message: String)
    }
    enum SplashError: Error {
        case someError(message: String)
    }
}
