//
//  SplashService.swift
//  WiFi-Map-Test
//
//  Created by Dima Bazhaniuk on 16.06.2022.
//

import Foundation

protocol SplashServiceProtocol {
    func getCSVData(completion: @escaping([CoordinateModel]?) -> Void)
}

class SplashService: SplashServiceProtocol {
    
    private var api: ParsingSRVServiceProtocol

    init(api: ParsingSRVServiceProtocol = ParsingSRVService()) {
        self.api = api
    }
    
    func getCSVData(completion: @escaping([CoordinateModel]?) -> Void)  {
        api.getCSVData { models in
            completion(models)
        }
    }

}
