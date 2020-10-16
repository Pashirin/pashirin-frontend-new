//
//  TestMap.swift
//  pashirin-swiftui
//
//  Created by HONGHYONGGUK on 2020/10/07.
//  Copyright © 2020 HONGHYONGGUK. All rights reserved.
//

import UIKit
//import GoogleMaps
//import SwiftUI
//
//struct TestGoogleMapsView: UIViewRepresentable {
//    
// //   @ObservedObject var locationManager = LocationManager()
//    private let zoom: Float = 15.0
//    
//    func makeUIView(context: Self.Context) -> GMSMapView {
//        GMSServices.provideAPIKey("AIzaSyCcN_eYWMkF6zGAplQKXnj0dRdO7s1Leb0")
//        
//        
//        let camera = GMSCameraPosition.camera(withLatitude: locationManager.latitude, longitude: locationManager.longitude, zoom: zoom)
//        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
//        return mapView
//    }
//    
//    func updateUIView(_ mapView: GMSMapView, context: Context) {
//        //        let camera = GMSCameraPosition.camera(withLatitude: locationManager.latitude, longitude: locationManager.longitude, zoom: zoom)
//               //        mapView.camera = camera
//        mapView.animate(toLocation: CLLocationCoordinate2D(latitude: locationManager.latitude, longitude: locationManager.longitude))
//                let position = CLLocationCoordinate2D(latitude: locationManager.latitude, longitude: locationManager.longitude)
//                let marker = GMSMarker(position: position)
//        marker.icon = UIImage(named: "pashirin")
//                marker.title = "Pashirin"
//                marker.map = mapView
//    }
//}
//
//struct GoogleMapsView_Previews: PreviewProvider {
//    static var previews: some View {
//        TestGoogleMapsView()
//    }
//}
