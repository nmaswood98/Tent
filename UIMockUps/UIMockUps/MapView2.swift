import SwiftUI
import MapKit

struct MapView2: UIViewRepresentable {
    func makeCoordinator() -> Coordinator {
        return MapView2.Coordinator()
    }
    
    @EnvironmentObject var locationService: LocationService
    var centerPosition: CLLocationCoordinate2D
    var circleRadius: Double
    var zoom: Double
    
    func getZoomLevel() -> Float{
        return (Float(zoom - log(circleRadius / 5)/log(2)));
    
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView(frame: .zero)
        mapView.delegate = context.coordinator
        
        mapView.isZoomEnabled = false
        mapView.isScrollEnabled = false
        mapView.isUserInteractionEnabled = false
        
        let circle = MKCircle(center: centerPosition, radius: circleRadius * 100)
        mapView.addOverlay(circle)
        
 
        
        return mapView
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        let coordinate = CLLocationCoordinate2D(
            latitude: centerPosition.latitude, longitude: centerPosition.longitude)
        
        let mapSize = ((circleRadius * 2) * (100 + zoom));
        
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: mapSize, longitudinalMeters: mapSize)
        view.mapType = .mutedStandard
        view.setRegion(region, animated: true)
        
        view.removeOverlays(view.overlays)
        
        view.mapType = .mutedStandard
        let circle = MKCircle(center: centerPosition, radius: circleRadius * 100)
        view.addOverlay(circle)

      
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
 
        
        @objc func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let circleRenderer = MKCircleRenderer(overlay: overlay)
            circleRenderer.strokeColor = UIColor.red
            circleRenderer.lineWidth = 1.0
            return circleRenderer
        }
    }
}


