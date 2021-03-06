//
//  MapView.swift
//  tent_ios
//
//  Created by Nabhan Maswood on 11/9/19.
//  Copyright © 2019 Nabhan Maswood. All rights reserved.
//

import SwiftUI
import GoogleMaps
import CoreLocation

extension GMSCircle {
    func bounds () -> GMSCoordinateBounds {
        func locationMinMax(positive : Bool) -> CLLocationCoordinate2D {
            let sign:Double = positive ? 1 : -1
            let dx = sign * self.radius  / 6378000 * (180 / .pi)
            let lat = position.latitude + dx
            let lon = position.longitude + dx / cos(position.latitude * .pi/180)
            return CLLocationCoordinate2D(latitude: lat, longitude: lon)
        }
        
        return GMSCoordinateBounds(coordinate: locationMinMax(positive: true),
                                   coordinate: locationMinMax(positive: false))
    }
}

struct MapViewGoogleMaps: UIViewRepresentable {
    @EnvironmentObject var locationService: LocationService
    var centerPosition: CLLocationCoordinate2D
    var circleRadius: Double
    var zoom: Double
    var circle : GMSCircle = GMSCircle()
    let marker = GMSMarker()
    let markerImage = UIImage(named: "locationMarker")


    
    func getZoomLevel() -> Float{
        return (Float(zoom - log(circleRadius / 5)/log(2)));
    }
    
    func makeUIView(context: Context) -> GMSMapView {
        
        let camera = GMSCameraPosition.camera(withLatitude: centerPosition.latitude, longitude: centerPosition.longitude, zoom: getZoomLevel())
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        

        mapView.settings.scrollGestures = false
        mapView.settings.zoomGestures = false
        mapView.settings.consumesGesturesInView = false
        mapView.moveCamera(GMSCameraUpdate.setCamera(GMSCameraPosition.camera(withLatitude: centerPosition.latitude, longitude: centerPosition.longitude, zoom: getZoomLevel())))

        

        
        return mapView
    }
    
    
    
    func updateUIView(_ mapView: GMSMapView, context: Self.Context) {
        mapView.moveCamera(GMSCameraUpdate.setCamera(GMSCameraPosition.camera(withLatitude: centerPosition.latitude, longitude: centerPosition.longitude, zoom: getZoomLevel())))
        
        mapView.clear()
        circle.radius = 100 * circleRadius
        
        circle.position = centerPosition
        circle.map = mapView
        
        marker.position = self.locationService.currentLocation
        marker.icon = self.markerImage
        marker.map = mapView
        
        
    }
    
}


