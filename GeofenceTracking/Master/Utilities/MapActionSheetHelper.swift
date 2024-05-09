//
//  MapActionSheetHelper.swift
//  SocialMedia
//
//  Created by MultiQoS on 05/04/2021.
//  Copyright © 2021. All rights reserved.
//

import Foundation
import UIKit
import MapKit

protocol MapAppScheme {
    var label: String { get } // The label for the option in the list
    var scheme: String { get } // The URL scheme used to determine if the app is available
    var coordinate: CLLocationCoordinate2D { get set } // The coordinates (latitutde and longitude) for the location
    var url: URL? { get } // The URL to open the application with the required info
}

struct GoogleMapsScheme: MapAppScheme {
    var label: String = "Google Maps"
    var scheme: String = "comgooglemaps://" // Scheme needs to be wrapped in a URL object
    var coordinate: CLLocationCoordinate2D
    let address : String
    init(coordinate: CLLocationCoordinate2D, address : String) {
        self.coordinate = coordinate
        self.address = address
    }
    var url: URL? {
        
        // Try to use the name of the location, replacing spaces with +, otherwise use the latitude and longitude
        let strLat = self.coordinate.latitude.description
        let strLant = self.coordinate.longitude.description
        
        //let strURL =  scheme + "://?center=" + strLat + "," + strLant + "&zoom=14&views=traffic"
        let escapedAddress = address.addingPercentEncoding(withAllowedCharacters:.urlQueryAllowed) ?? ""
        let strURL =  scheme + "://?q=" + escapedAddress + "&=center=" + strLat + "," + strLant + "&zoom=14&views=traffic"
        
        AppLogs.debugPrint(strURL)
        guard let _url = URL(string: strURL) else{
            return nil
        }
        return _url
    }
}

class MapAppsHelper {
    fileprivate let mapSchemes: [MapAppScheme]
    let coordinate: CLLocationCoordinate2D
    init(coordinate: CLLocationCoordinate2D, address : String) {
        self.coordinate = coordinate
        mapSchemes = [
            GoogleMapsScheme(coordinate: coordinate, address: address)
        ]
    }
    lazy private(set) var availableMapApps: [String: URL] = {
        var availableSchemes: [String: URL] = [:]
        for scheme in mapSchemes {
            // If the app is available, add the URL to the list of available schemes
            if let schemeURL = URL(string: scheme.scheme), UIApplication.shared.canOpenURL(schemeURL), let _url = scheme.url{
                availableSchemes[scheme.label] = _url
            }
        }
        // ["Google Maps": "urlForGoogleMaps", ...]
        return availableSchemes
    }()
}

class MapActionSheetViewController: UIAlertController {
    fileprivate let mapOptions: [String: URL]
    fileprivate let coordinate: CLLocationCoordinate2D
    fileprivate let address: String
    init(mapOptions: [String: URL], coordinate: CLLocationCoordinate2D, address: String) {
        // Pass in the results from our MapAppsHelper
        self.mapOptions = mapOptions
        self.coordinate = coordinate
        self.address = address
        super.init(nibName: nil, bundle: nil)
        buildActions()
    }
    override var preferredStyle: UIAlertController.Style {
        return .actionSheet
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    fileprivate func buildActions() {
        // Add the Apple Maps option with the closure containing the logic for rendering the location in Apple Maps
        addAction(UIAlertAction(title: "Open In Map", style: .default, handler: { (action) in
            self.openMapForPlace()
        }))
        // Add one or more actions for our third-party map applications
        mapOptions.forEach { option in
            addAction(UIAlertAction(title: option.key, style: .default, handler: { (action) in
                UIApplication.shared.open(option.value, options: [:], completionHandler: nil)
            }))
        }
        // Add an option to cancel opening the location in a map application
        addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
            self.dismiss(animated: true, completion: nil)
        }))
    }
    
    func openMapForPlace() {
        
        let latitude:CLLocationDegrees =  self.coordinate.latitude
        let longitude:CLLocationDegrees =  self.coordinate.longitude
        
        let regionDistance:CLLocationDistance = 2500
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = self.address
        mapItem.openInMaps(launchOptions: options)
    }
}
