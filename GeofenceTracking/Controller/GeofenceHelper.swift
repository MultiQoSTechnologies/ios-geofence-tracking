//
//  GeofenceHelper.swift
//  GeofenceTracking
//
//  Created by MQI-2 on 29/04/24.
//

import UIKit
import CoreLocation

class GeofenceHelper: NSObject {
    
    static let share: GeofenceHelper = GeofenceHelper()
    //set lat long of geofence location
    static let geofenceRegionCenter =  CLLocationCoordinate2DMake(23.0494, 72.5249)
    private var locationManager: CLLocationManager = CLLocationManager()
    private var notificationCenter: UNUserNotificationCenter?
    private var enterTime: Double = 0
    private var exitTime: Double = 0
    //Update current location callback
    var location: DataBind<CLLocation?> = DataBind<CLLocation?>(nil)
    
    override init() {
        super.init()
        
    }
    
    func locationSetup() {
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
    }
    
    func stratMonitoring() {
        
        let geofenceRegion = CLCircularRegion(center: GeofenceHelper.geofenceRegionCenter,
                                              radius: 100,
                                              identifier: "UniqueIdentifier")
        
        geofenceRegion.notifyOnEntry = true
        geofenceRegion.notifyOnExit = true
        
        self.locationManager.startMonitoring(for: geofenceRegion)
        self.locationManager.startUpdatingLocation()
        
        
        // get the singleton object
        self.notificationCenter = UNUserNotificationCenter.current()
        
        // register as it's delegate
        notificationCenter?.delegate = self
        
        // define what do you need permission to use
        let options: UNAuthorizationOptions = [.alert, .sound]
        
        // request permission
        notificationCenter?.requestAuthorization(options: options) { (granted, error) in
            if !granted {
                print("Permission not granted")
            }
        }
    }
}

extension GeofenceHelper: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways:
            self.stratMonitoring()
                
        case .authorizedWhenInUse:
            self.locationManager.requestAlwaysAuthorization()
            self.stratMonitoring()
            
            
        case .denied:
            var rootViewController = UIApplication.shared.keyWindow?.rootViewController
            let alert = UIAlertController(title: "", message: "Please enable location permissions in settings.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            rootViewController?.present(alert, animated: true)
            
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.location.value = manager.location
    }
    
    // called when user Exits a monitored region
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        if region is CLCircularRegion {
            // Do what you want if this information
            self.exitTime = Date().timeIntervalSince1970
            
            if enterTime == 0, let val = UserDefaults.value(forKey: "enterTime") {
                enterTime = val as? Double ?? 0
            }
            
            let diff = findDateDiff(time1Str: enterTime, time2Str: exitTime)
            
            //Application active that time present the popup.
            if UIApplication.shared.applicationState == .active {
                var rootViewController = UIApplication.shared.keyWindow?.rootViewController
                let alert = UIAlertController(title: "", message: "You stayed for \(diff) in the geofence area", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                rootViewController?.present(alert, animated: true)
            }
            
            self.exitTime = 0
            self.enterTime = 0
            UserDefaults.standard.setValue(0, forKey: "enterTime")
            UserDefaults().synchronize()
            self.handleEvent(forRegion: region, message: "You stayed for \(diff) in the geofence area")
        }
    }
    
    // called when user Enters a monitored region
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        if region is CLCircularRegion {
            // Do what you want if this information
            self.enterTime = Date().timeIntervalSince1970
            
            UserDefaults.standard.setValue(enterTime, forKey: "enterTime")
            UserDefaults().synchronize()
            self.handleEvent(forRegion: region, message: "You have entered in a geofence area")
        }
    }
    
    
    func handleEvent(forRegion region: CLRegion!, message: String) {
        
        // customiz your notification content
        let content = UNMutableNotificationContent()
        content.title = "Geofence Tracking"
        content.body = message
        content.sound = UNNotificationSound.default
        
        // when the notification will be triggered
        let timeInSeconds: TimeInterval = 1
        
        // the actual trigger object
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInSeconds,
                                                        repeats: false)
        
        // notification unique identifier, for this example, same as the region to avoid duplicate notifications
        let identifier = region.identifier
        
        // the notification request object
        let request = UNNotificationRequest(identifier: identifier,
                                            content: content,
                                            trigger: trigger)
        
        // trying to add the notification request to notification center
        notificationCenter?.add(request, withCompletionHandler: { (error) in
            if error != nil {
                print("Error adding notification with identifier: \(identifier)")
            }
        })
    }
    
    func findDateDiff(time1Str: Double, time2Str: Double) -> String {
        
        let date1 = Date(timeIntervalSince1970: time1Str)
        let date2 = Date(timeIntervalSince1970: time2Str)
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute, .second], from: date1, to: date2)
        
        let hours = components.hour ?? 0
        let minutes = components.minute ?? 0
        let seconds = components.second ?? 0
        
        return "\(Int(hours)) Hours \(Int(minutes)) Minutes \(Int(seconds)) Second"
    }
}

extension GeofenceHelper: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // when app is open and in foreground
        completionHandler(.alert)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
    
}

