//
//  SplashModuleBuilder.swift
//  WiFi-Map-Test
//
//  Created by Dima Bazhaniuk on 16.06.2022.
//


import UIKit

class SplashModuleBuilder: ModuleBuilder {

    var initialState: Splash.ViewControllerState?

    func set(initialState: Splash.ViewControllerState) -> SplashModuleBuilder {
        self.initialState = initialState
        return self
    }

    func build() -> UIViewController {
        let presenter = SplashPresenter()
        let interactor = SplashInteractor(presenter: presenter)
        let controller = SplashController(interactor: interactor)

        presenter.viewController = controller
        return controller
    }

}
