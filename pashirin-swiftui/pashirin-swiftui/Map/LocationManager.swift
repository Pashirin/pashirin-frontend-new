//
//  LocationManager.swift
//  pashirin-swiftui
//
//  Created by HONGHYONGGUK on 2020/10/26.
//  Copyright © 2020 HONGHYONGGUK. All rights reserved.
//

import Foundation
import CoreLocation
import Combine
import Firebase
import MapKit
//クラスはどうやって同期しているのか
class LocationManager: NSObject, ObservableObject {
    var notificationCount: Int = 0
    //MARK:- 目的地を取得したものと仮定する
    var destination: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 35.7352923, longitude: 139.6447856)
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.startUpdatingLocation()
        self.locationManager.startUpdatingLocation()
        self.locationManager.startMonitoringSignificantLocationChanges()
        self.locationManager.allowsBackgroundLocationUpdates = true
    }
    //変化の直前の位置情報許可の状態を送る
    @Published var locationStatus: CLAuthorizationStatus? {
        willSet {
            objectWillChange.send()
        }
    }
    //変化の直前の位置情報を送る
    @Published var lastLocation: CLLocation? {
        willSet {
            objectWillChange.send()
        }
    }

    var statusString: String {
        
        //locationStatusがnilなら unknown を返し、　そうでないならそれぞれのステイタスを返す
        guard let status = locationStatus else {
            return "unknown"
        }

        switch status {
        case .notDetermined: return "notDetermined"
        case .authorizedWhenInUse: return "authorizedWhenInUse"
        case .authorizedAlways: return "authorizedAlways"
        case .restricted: return "restricted"
        case .denied: return "denied"
        default: return "unknown"
        }

    }

    let objectWillChange = PassthroughSubject<Void, Never>()

    private let locationManager = CLLocationManager()
}

extension LocationManager: CLLocationManagerDelegate {
    //権限の状態をデリゲイトに伝えて、変更された時も伝える
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.locationStatus = status
        //print(#function, statusString)
    }

    
    //最新の位置情報を取得しデータベース送信しつづ付る
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.lastLocation = location
        
        //fireStoreに情報を送信する
        let db = Firestore.firestore()
        db.collection("users").document("r43zdHZpeyD4RRzmKT3Z").setData([
            "location": GeoPoint(latitude: self.lastLocation!.coordinate.latitude, longitude: self.lastLocation!.coordinate.longitude)
        ])
        print("firebase に送ったよ。from locationmanager")
        
        //MARK: -保留　通知センター
        
//        let destinationLocation = CLLocation(latitude: self.destination.latitude, longitude: self.destination.longitude)
//               if self.lastLocation != nil{
//                   let distance = destinationLocation.distance(from: self.lastLocation!)
//                   if distance < 500 {
//                       if notificationCount == 0 {
//                           NotificationCenter.default.post(name: .notifyName, object: nil)
//                       }
//                   }
//
//               }
//               print(#function, location)
    }

}
