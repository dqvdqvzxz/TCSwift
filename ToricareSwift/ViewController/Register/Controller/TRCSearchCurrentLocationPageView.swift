//
//  TRCSearchCurrentLocationPageView.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 7/17/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

protocol TRCSearchCurrentLocationPageViewDelegate: class {
    func pushCurrentLocationToSearchResult(_ mode: String)
}

class TRCSearchCurrentLocationPageView: TRCBaseViewController, GMSMapViewDelegate {

    @IBOutlet var mapView: GMSMapView!
    
    @IBOutlet weak var btnSearch: UIButton!
    
    var locationManager = CLLocationManager()
    
    let marker = GMSMarker()
    
    var delegate: TRCSearchCurrentLocationPageViewDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnSearch.buttonStyle(title: STRING_SEARCH)

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        // A minimum distance a device must move before update event generated
        locationManager.distanceFilter = 1000
        // Request permission to use location service
        locationManager.requestWhenInUseAuthorization()
        // Request permission to use location service when the app is run
        locationManager.requestAlwaysAuthorization()
        // Start the update of user's location
        locationManager.startUpdatingLocation()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        _obj.tabController.tabBar.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func tapBtnSearch(_ sender: Any) {
        UserDefaults.removeUD(SEARCH_PREFECTURE_NAME)
        UserDefaults.removeUD(SEARCH_TOWN_NAME)
        UserDefaults.removeUD(SEARCH_PREFECTURE)
        UserDefaults.removeUD(SEARCH_TOWN)
        UserDefaults.removeUD(SEARCH_KEYWORD)
        
        if(_obj.mode == MODE_MYPAGE){
            if (delegate != nil) {
                delegate.pushCurrentLocationToSearchResult(MODE_MYPAGE)
                return
            }
        }else if(_obj.mode == MODE_REGISTER){
            if (delegate != nil) {
                delegate.pushCurrentLocationToSearchResult(MODE_REGISTER)
                return
            }
        }
    }
}

extension TRCSearchCurrentLocationPageView: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if (status == .authorizedWhenInUse)
        {
            mapView.isMyLocationEnabled = true
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
            marker.position = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
            DLog("\nCurrent latitude: \(location.coordinate.latitude) \nCurrent longitude: \(location.coordinate.longitude)")
            
            UserDefaults.saveUD(location.coordinate.latitude, SEARCH_LAT)
            UserDefaults.saveUD(location.coordinate.longitude, SEARCH_LON)
            
            marker.title = "You are here !"
            marker.map = mapView
            
            locationManager.stopUpdatingLocation()
            
        }
    }
}
