//
//  MapView.swift
//  pashirin-swiftui
//
//  Created by HONGHYONGGUK on 2020/10/27.
//  Copyright © 2020 HONGHYONGGUK. All rights reserved.
//
//パシリの位置と目的地を動的に表示するMapView
//初期値としてパシリの位置情報と目的地を親Viewから渡す
//

import SwiftUI
import MapKit
import CoreLocation
import UIKit
import FirebaseFirestore

struct MapView: UIViewRepresentable {
    @Binding var timeToAlive: String
    //var pashiriLocation: CLLocationCoordinate2D
    var mapView = MKMapView()
    class Coordinator: NSObject, MKMapViewDelegate, CLLocationManagerDelegate{
        var parent: MapView
        
        init(_ parent: MapView) {
            self.parent = parent
        }
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            let longtitude = 35.6804
            let latitude = 139.7690
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longtitude), latitudinalMeters: 20000, longitudinalMeters: 20000)
            
            self.parent.mapView.region = region
        }
        //mapが動くたびに座標が表示される
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            print(mapView.centerCoordinate)
        }
        
        
        //MKMapViewDelegateのfanc:特定のアノテーションのオブジェクトを返す
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            
            if annotation.isKind(of: MKUserLocation.self){
                return nil
            } else {
                let identifier: String = "CunstomViewAnnotation"
                
                var annotView =
                    mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? AnnotationView
                
                if let annotationView = annotView {
                    return annotationView
                    
                } else {
                    if annotation.title == "Namaken place" {
                        annotView = AnnotationView(annotation: annotation, reuseIdentifier: identifier)
                        
                        let pinIcon = UIImage(named: "house")
                        annotView?.btnInfo = UIButton()
                        annotView?.frame = CGRect(x: 0, y:0, width: pinIcon!.size.width, height: pinIcon!.size.height)
                        annotView?.btnInfo?.frame = annotView?.frame ?? CGRect.zero
                        annotView?.btnInfo?.setBackgroundImage(pinIcon, for: .normal)
                        annotView?.addSubview(annotView?.btnInfo ?? UIButton())
                        
                        return annotView
                    } else {
                        annotView = AnnotationView(annotation: annotation, reuseIdentifier: identifier)
                        
                        let pinIcon = UIImage(named: "run")
                        annotView?.btnInfo = UIButton()
                        annotView?.frame = CGRect(x: 0, y:0, width: pinIcon!.size.width, height: pinIcon!.size.height)
                        annotView?.btnInfo?.frame = annotView?.frame ?? CGRect.zero
                        annotView?.btnInfo?.setBackgroundImage(pinIcon, for: .normal)
                        annotView?.addSubview(annotView?.btnInfo ?? UIButton())
                        
                        return annotView
                    }
                }
            }
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let over = MKPolylineRenderer(overlay: overlay)
            over.strokeColor = .systemBlue
            over.lineWidth = 5
            return over
        }
    }
    //UIViwRepresentableに従うよう、makeCoordinatorを設置
    func makeCoordinator() -> Coordinator {
        return MapView.Coordinator(self)
    }
    
    
    func makeUIView(context: Context) -> MKMapView {
        //Coordinatorのインスタンスとmapを関連づける
        mapView.delegate = context.coordinator
        return mapView
    }
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
        //        print(uiView.annotations)
        //        if uiView.annotations.count > 0  {
        //            uiView.removeAnnotations(uiView.annotations)
        //        }
        updateAnnotation(uiView)
        //        print("只今updateUIですよん", pashiriLocation)
        //
        //        var pashirinAnnotation = MapAnnotation(coordinate: pashiriLocation)
        //
        //        var point = MKPointAnnotation()
        //        point.coordinate = CLLocationCoordinate2D(latitude: 35.658104, longitude: 139.727545)
        //        uiView.addAnnotation(pashirinAnnotation)
        //
        //        pashirinAnnotation.title = "パシリん"
        
    }
    
    //    class Coordinator : NSObject,MKMapViewDelegate,CLLocationManagerDelegate {
    //    }
    func updateAnnotation(_ uiView: MKMapView){
        
        //MARK: -ロケーションを便宜上練馬に設定してあるのでパシリの現在地にする
        var newLocation = CLLocationCoordinate2D(latitude: 35.737841, longitude: 139.653912)
        var oldLocation = CLLocationCoordinate2D(latitude: 35.737841, longitude: 139.653912)
        var truncate = 6
        let db = Firestore.firestore()
        var pashirinAnnotation = MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: 35.737841, longitude: 139.653912))
        //MARK:- destinationを取得する今は仮でコードクリサリス
        
        let destination = CLLocationCoordinate2D(latitude: 35.7352923, longitude: 139.6447856)
        let goalAnnotation = MKPointAnnotation()
        goalAnnotation.coordinate = destination
        goalAnnotation.title = "Namaken place"
        uiView.addAnnotation(goalAnnotation)
        
        
        
        db.collection("users").document("r43zdHZpeyD4RRzmKT3Z").addSnapshotListener { (documentSnapshot, error) in
            guard let document = documentSnapshot else {
                print("No documents")
                return
            }
            guard let data = document.data() else {
                print("Document data was empty.")
                return
            }
           
            let location = (data["location"])! as! GeoPoint
            newLocation = CLLocationCoordinate2D(latitude: location.latitude.truncate(places: truncate), longitude: location.longitude.truncate(places: truncate))
//            uiView.setRegion(MKCoordinateRegion(center: newLocation, latitudinalMeters: 200, longitudinalMeters: 200), animated: true)
            
            //MARK: -経路の情報を取得
            let req = MKDirections.Request()
            req.source = MKMapItem(placemark: MKPlacemark(coordinate: newLocation))
            req.destination = MKMapItem(placemark: MKPlacemark(coordinate: destination))
            let direction = MKDirections(request: req)
            direction.calculate { (dir, err) in
                if err != nil {
                    print((err?.localizedDescription)!)
                    return
                }
                let polyline = dir?.routes[0].polyline
                
                let dis = dir?.routes[0].distance as! Double
                let distance = String(format: "%.1f", dis/1000)
                
                //時間
                let time = dir?.routes[0].expectedTravelTime as! Double
                let timeByHour = String(Int(round(time / 60)))
                self.timeToAlive = timeByHour
                print("あと \(timeByHour)分で到着")
                
                //線を描く
                uiView.removeOverlays(uiView.overlays)
                //新しいのを描く
                uiView.addOverlay(polyline!)
                //地図を上塗り
                uiView.setRegion(MKCoordinateRegion(polyline!.boundingMapRect), animated: true)
                uiView.showAnnotations(uiView.annotations, animated: true)
            }
            
            let getAngle = self.angleFromCoordinate(firstCoordinate: oldLocation, secondCoordinate: newLocation)
            print("これが角度じゃ＝＝＝＝＝＝", getAngle)
            
            uiView.addAnnotation(pashirinAnnotation)
            
            UIView.animate(withDuration: 1, delay: 0, options: .allowUserInteraction, animations: { pashirinAnnotation.coordinate = newLocation
                print(pashirinAnnotation.coordinate,"これはnilではない")

                //ここで問題発生

                let annotationView = uiView.view(for: pashirinAnnotation) as! AnnotationView
                
//                annotationView.transform = CGAffineTransform(rotationAngle: CGFloat(2))
//                annotationView.transform = CGAffineTransform.identity
            })
        }
    }
    
    func angleFromCoordinate(firstCoordinate: CLLocationCoordinate2D, secondCoordinate: CLLocationCoordinate2D) -> Double {
        
        let deltaLongitude: Double = secondCoordinate.longitude - firstCoordinate.longitude
        let deltaLatitude: Double = secondCoordinate.latitude - firstCoordinate.latitude
        let angle = (Double.pi * 0.5) - atan(deltaLatitude / deltaLongitude)
        
        if (deltaLongitude > 0) {
            return angle
        } else if (deltaLongitude < 0) {
            return angle + Double.pi
        } else if (deltaLatitude < 0) {
            return Double.pi
        } else {
            return 0.0
        }
    }
    
}
extension MKPointAnnotation {
    static var example: MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.title = "You"
        //テストデータ
        //https://www.google.com/maps/@35.6580405,139.727568,21z
        annotation.coordinate = CLLocationCoordinate2D(latitude: 35.6580405, longitude: 139.727568)
        return annotation
    }
}

