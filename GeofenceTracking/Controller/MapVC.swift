//
//  MapVC.swift
//  GeofenceTracking
//
//  Created by MQI-2 on 29/04/24.
//

import UIKit
import MapKit

class MapVC: UIViewController {
    
    @IBOutlet private weak var map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialization()
    }
    
    //MARK: - Memory management methods -
    deinit {
        print("### deinit -> \(self.className)")
    }
    
}

//MARK: - initialization -
extension MapVC {
    func initialization() {
        let location = GeofenceHelper.geofenceRegionCenter
        //Center the map on the place location
        GeofenceHelper.share.location.subscribe { [weak self] currentLocation in
            
            guard let self = self,
                  let currentLocation = currentLocation else {
                return
            }
            
            map.setCenter( currentLocation.coordinate, animated: true)
            let viewRegion = MKCoordinateRegion(center: currentLocation.coordinate, latitudinalMeters: 100, longitudinalMeters: 100)
            map.setRegion(viewRegion, animated: false)
            
        }

        map.delegate = self
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "geo"
        map.addAnnotation(annotation)
    }
}

extension MapVC: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: any MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else {
            return nil
        }
        
        let annotationView: MKAnnotationView = MKAnnotationView()
        if annotation.title == "geo" {
            annotationView.image = UIImage(named: "ic_location")
        }
        return annotationView
    }
}

//MARK: - Action Events -
extension MapVC {
    
    @IBAction private func back(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
