//
//  ClusterMapController.swift
//  WiFi-Map-Test
//
//  Created by Dima Bazhaniuk on 19.06.2022.
//

import UIKit
import MapboxMaps
import CoreLocation

final class ClusterMapController: UIViewController {
    
    var customView: ClusterView? { view as? ClusterView }
    
    var coordinates = [CoordinateViewModel]()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View lifecycle
    override func loadView() {
        let view = ClusterView(frame: UIScreen.main.bounds)
        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        customView?.setupPoint(coordinates: coordinates)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

}
