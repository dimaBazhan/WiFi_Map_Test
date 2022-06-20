//
//  SplashProvider.swift
//  WiFi-Map-Test
//
//  Created by Dima Bazhaniuk on 16.06.2022.
//

import Foundation

protocol SplashProviderProtocol {
    func fetchCoordinates(completion: @escaping([CoordinateModel]?) -> Void)
}

class SplashProvider: SplashProviderProtocol {
    
    let service: SplashServiceProtocol

    init(service: SplashServiceProtocol = SplashService()) {
        self.service = service
    }
    
    func fetchCoordinates(completion: @escaping([CoordinateModel]?) -> Void) {
        service.getCSVData { models in
            completion(models)
        }
    }

}
