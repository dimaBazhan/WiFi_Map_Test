//
//  ClusterView.swift
//  WiFi-Map-Test
//
//  Created by Dima Bazhaniuk on 19.06.2022.
//

import UIKit
import MapboxMaps
import CoreLocation

class ClusterView: UIView {
    
    var mapViewMapBox: MapView?
    private var feature1 = [Feature]()
    
    override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)
        applyAppearance()
        addMap()
    }

    required init?(coder: NSCoder) {
        fatalError("required init?(coder: NSCoder) not implemented")
    }
    
    private func addMap() {
        ResourceOptionsManager.default.resourceOptions.accessToken = "pk.eyJ1IjoiZGVtb241MDAzIiwiYSI6ImNreGh2N2hkeDBjYzQyeHBlMGU3cGJvNWMifQ.SxXHg1luksIrU9ExOsdHJw"
        
        mapViewMapBox = MapView(frame: bounds)
        guard let mapViewMapBox = mapViewMapBox else {
            return
        }
        addSubview(mapViewMapBox)
        mapViewMapBox.mapboxMap.onNext(.styleLoaded) { _ in
            self.addPointClusters()
        }
    }
    
    func addPointClusters() {
        guard let mapViewMapBox = mapViewMapBox else {
            return
        }
        let style = mapViewMapBox.mapboxMap.style
        var source = GeoJSONSource()
        source.data = .featureCollection(FeatureCollection(features: feature1))
        source.cluster = true
        source.clusterRadius = 50
        source.clusterMaxZoom = 14
        let sourceID = "earthquake-source"
        var clusteredLayer = createClusteredLayer()
        clusteredLayer.source = sourceID
        var unclusteredLayer = createUnclusteredLayer()
        unclusteredLayer.source = sourceID
        var clusterCountLayer = createNumberLayer()
        clusterCountLayer.source = sourceID
        try? style.addSource(source, id: sourceID)
        try? style.addLayer(clusteredLayer)
        try? style.addLayer(unclusteredLayer, layerPosition: .below(clusteredLayer.id))
        try? style.addLayer(clusterCountLayer)
    }
    
    func createClusteredLayer() -> CircleLayer {
            var clusteredLayer = CircleLayer(id: "clustered-earthquake-layer")
            clusteredLayer.filter = Exp(.has) { "point_count" }
            clusteredLayer.circleColor =  .expression(Exp(.step) {
                Exp(.get) { "point_count" }
                UIColor(red: 0.32, green: 0.73, blue: 0.84, alpha: 1.00)
                100
                UIColor(red: 0.95, green: 0.94, blue: 0.46, alpha: 1.00)
                750
                UIColor(red: 0.95, green: 0.55, blue: 0.69, alpha: 1.00)
            })

            clusteredLayer.circleRadius = .expression(Exp(.step) {
                Exp(.get) { "point_count" }
                20
                100
                30
                750
                40
            })

            return clusteredLayer
        }

        func createUnclusteredLayer() -> CircleLayer {
            var unclusteredLayer = CircleLayer(id: "unclusteredPointLayer")
            unclusteredLayer.filter = Exp(.not) {
            Exp(.has) { "point_count" }
            }
            unclusteredLayer.circleColor = .constant(StyleColor(UIColor(red: 0.07, green: 0.71, blue: 0.85, alpha: 1.00)))
            unclusteredLayer.circleRadius = .constant(4)
            unclusteredLayer.circleStrokeWidth = .constant(1)
            unclusteredLayer.circleStrokeColor = .constant(StyleColor(.black))
            return unclusteredLayer
        }

        func createNumberLayer() -> SymbolLayer {
            var numberLayer = SymbolLayer(id: "cluster-count-layer")
            numberLayer.filter = Exp(.has) { "point_count" }
            numberLayer.textField = .expression(Exp(.get) { "point_count" })
            numberLayer.textSize = .constant(12)
            return numberLayer
        }
    
    func setupPoint(coordinates: [CoordinateViewModel]) {
        for item in coordinates {
            guard let lat = Double(item.lat) else {return}
            guard let lng = Double(item.lng) else {return}
            let centerCoordinate1 = CLLocationCoordinate2D(latitude: lat, longitude: lng)
            let point = Point(centerCoordinate1)
            addFeature(at: point, item: item)
        }
    }
    
    func addFeature(at point: Point, item: CoordinateViewModel) {
        let featureId = item.id
        var feature = Feature(geometry: Geometry.point(point))
        feature.identifier = .string(featureId)
        feature1.append(feature)
    }
    
    private func applyAppearance() {
        self.backgroundColor = .white
    }

    
}
