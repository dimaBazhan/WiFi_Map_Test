//
//  MapService.swift
//  WiFi-Map-Test
//
//  Created by Dima Bazhaniuk on 16.06.2022.
//

import Foundation
import CSV
import UIKit

protocol ParsingSRVServiceProtocol {
    func getCSVData(completion: @escaping([CoordinateModel]?) -> Void)
}

class ParsingSRVService: ParsingSRVServiceProtocol {
    
    func getCSVData(completion: @escaping([CoordinateModel]?) -> Void) {
        do {
            guard let path = Bundle.main.path(forResource: "hotspots", ofType: "csv") else {
                return
            }
            let content = try String(contentsOfFile: path)
            let csv = try! CSVReader(string: content, hasHeaderRow: true)
            var models = [CoordinateModel]()
            while let _ = csv.next() {
                let id = "\(csv["id"] ?? "")"
                let lat = "\(csv["lat"] ?? "")"
                let lng = "\(csv["lng"] ?? "")"
                let model = CoordinateModel(id: id, lat: lat, lng: lng)
                models.append(model)
            }
            completion(models)
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
