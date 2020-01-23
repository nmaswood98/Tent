import SwiftUI
import MapKit

struct MapView2: UIViewRepresentable {
    var currentPosition: CLLocationCoordinate2D
    var circleRadius: Double
    
    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        let coordinate = CLLocationCoordinate2D(
            latitude: currentPosition.latitude, longitude: currentPosition.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 2.0, longitudeDelta: 2.0)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        view.layoutMargins.bottom = -100
        view.setRegion(region, animated: true)
    }
}


