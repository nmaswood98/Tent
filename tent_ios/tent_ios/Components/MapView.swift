//
//  MapView.swift
//  tent_ios
//
//  Created by Nabhan Maswood on 11/9/19.
//  Copyright © 2019 Nabhan Maswood. All rights reserved.
//

import SwiftUI
import GoogleMaps

struct MapView: UIViewRepresentable {
    var currentPosition: CLLocationCoordinate2D
    var circleRadius: Double
    var circle : GMSCircle = GMSCircle()

    func makeUIView(context: Context) -> GMSMapView {
        
        let camera = GMSCameraPosition.camera(withLatitude: currentPosition.latitude, longitude: currentPosition.longitude, zoom: 15.00)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.settings.scrollGestures = true
        mapView.settings.zoomGestures = false
        mapView.moveCamera(GMSCameraUpdate.setCamera(GMSCameraPosition.camera(withLatitude: currentPosition.latitude, longitude: currentPosition.longitude, zoom: 15.00)))
        return mapView
    }
    

    
    func updateUIView(_ mapView: GMSMapView, context: Self.Context) {
        mapView.moveCamera(GMSCameraUpdate.setCamera(GMSCameraPosition.camera(withLatitude: currentPosition.latitude, longitude: currentPosition.longitude, zoom: 15.00)))

        mapView.clear()
        circle.radius = 100 * circleRadius
        
        circle.position = currentPosition
        circle.map = mapView
    }

}


