//
//  SplashInteractor.swift
//  WiFi-Map-Test
//
//  Created by Dima Bazhaniuk on 16.06.2022.
//

import Foundation

protocol SplashBusinessLogic {
    func loadCoordinates(request: Splash.Something.Request)
}

class SplashInteractor: SplashBusinessLogic {
    
    let presenter: SplashPresenterLogic
    let provider: SplashProviderProtocol

    init(presenter: SplashPresenterLogic, provider: SplashProviderProtocol = SplashProvider()) {
        self.presenter = presenter
        self.provider = provider
    }
    
    func loadCoordinates(request: Splash.Something.Request) {
        provider.fetchCoordinates { models in
            let result: Splash.SplashRequestResult
            if let items = models {
                result = .successCategory(items)
            } else {
                result = .failure(.someError(message: "No Data"))
            }
            self.presenter.presentSomething(response: Splash.Something.Response(result: result))
        }
    }

}
