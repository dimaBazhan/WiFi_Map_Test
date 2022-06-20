//
//  SplashPresenter.swift
//  WiFi-Map-Test
//
//  Created by Dima Bazhaniuk on 16.06.2022.
//

import Foundation
protocol SplashPresenterLogic {
    func presentSomething(response: Splash.Something.Response)
}

class SplashPresenter: SplashPresenterLogic {

    private var vmResults: [CoordinateViewModel] = []
    
    weak var viewController: SplashDisplayLogic?
    
    func presentSomething(response: Splash.Something.Response) {
        var viewModel: Splash.Something.ViewModel
        switch response.result {
        case let .failure(error):
            viewModel = Splash.Something.ViewModel(state: .error(message: error.localizedDescription))
        case let .successCategory(result):
            if result.isEmpty {
                viewModel = Splash.Something.ViewModel(state: .emptyResult)
            } else {
                let vmResult = result.map { model in
                    return CoordinateViewModel(id: model.id, lat: model.lat, lng: model.lng)
                }
                vmResults = vmResult
                viewModel = Splash.Something.ViewModel(state: .resultMap(vmResults))
                
            }
        }
        viewController?.displaySomething(viewModel: viewModel)
    }
    
}
