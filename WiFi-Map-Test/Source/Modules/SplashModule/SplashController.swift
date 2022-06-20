//
//  SplashController.swift
//  WiFi-Map-Test
//
//  Created by Dima Bazhaniuk on 16.06.2022.
//

import UIKit
import CSV
import CoreLocation

protocol SplashDisplayLogic: AnyObject {
    func displaySomething(viewModel: Splash.Something.ViewModel)
}

final class SplashController: UIViewController {

    var state: Splash.ViewControllerState
    let interactor: SplashBusinessLogic
    
    var customView: SplashViewMain? { view as? SplashViewMain }
    var coordinates = [CLLocationCoordinate2D]()
    let clusterMapController = ClusterMapController()
    
    init(interactor: SplashBusinessLogic,
         initialState: Splash.ViewControllerState = .loading) {
        self.interactor = interactor
        self.state = initialState
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View lifecycle
    override func loadView() {
        let view = SplashViewMain(frame: UIScreen.main.bounds)
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let request = Splash.Something.Request()
        DispatchQueue.global(qos: .userInitiated).async {
            self.interactor.loadCoordinates(request: request)
        }
    }

}

extension SplashController: SplashDisplayLogic {
    func displaySomething(viewModel: Splash.Something.ViewModel) {
        display(newState: viewModel.state)
    }
    
    func display(newState: Splash.ViewControllerState) {
        state = newState
        switch state {
        case .loading:
            print("loading...")
        case let .error(message):
            print("error \(message)")
        case let .resultMap(items):
            DispatchQueue.main.async {
                self.clusterMapController.coordinates = items
                self.navigationController?.pushViewController(self.clusterMapController, animated: true)
            }
        case .emptyResult:
            print("empty result")
        }
    }
    
}
