//
//  MapTableViewCell.swift
//  FinalProject
//
//  Created by Tinh Bui T. VN.Danang on 6/17/22.
//  Copyright © 2022 Asiantech. All rights reserved.
//

import UIKit
import MapKit

final class MapTableViewCell: UITableViewCell {

    // MARK: - IBOutlet
    @IBOutlet private weak var mapView: MKMapView!

    // MARK: - Properties
    var lat: Double = 0.0
    var lon: Double = 0.0
    var viewModel: MapTableViewcellViewModel? {
        didSet {
            updateView()
            configMapView()
        }
    }

    // MARK: - Private functions
    private func configMapView() {
        let eiffelTowerLocation = CLLocation(latitude: lat, longitude: lon)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: eiffelTowerLocation.coordinate, span: span)
        mapView.region = region
    }

    private func updateView() {
        guard let viewModel = viewModel,
              let latDouble = viewModel.mainApi?.lat,
              let lonDouble = viewModel.mainApi?.lon
        else { return }
        lat = latDouble
        lon = lonDouble
    }
}
