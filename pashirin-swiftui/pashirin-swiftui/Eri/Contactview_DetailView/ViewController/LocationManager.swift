//
//  LocationManager.swift
//  pashirin-swiftui
//
//  Created by HONGHYONGGUK on 2020/10/07.
//  Copyright © 2020 HONGHYONGGUK. All rights reserved.
//

import Combine
import CoreLocation

class LocationManager: NSObject, ObservableObject {
    private let locationManager = CLLocationManager()
    
    @Published var location: CLLocation? {
        willSet {
            objectWillChange.send()
        }
    }
    
    // 2
    var latitude: CLLocationDegrees {
        return location?.coordinate.latitude ?? 0
    }
    
    var longitude: CLLocationDegrees {
        return location?.coordinate.longitude ?? 0
    }
    
    // 3
    override init() {
      super.init()
    //現在地のuploadを受け取るオブジェクト
      locationManager.delegate = self
   //位置情報の正確レベルを最高に指定
      locationManager.desiredAccuracy = kCLLocationAccuracyBest
   //位置情報の使用を許可
      locationManager.requestWhenInUseAuthorization()
    //ユーザーの位置追跡をスタートする
      locationManager.startUpdatingLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
  // 4
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.location = location
    }
}
