//
//  ViewController.swift
//  HaritaOrnek
//
//  Created by Dilan Öztürk on 19.02.2023.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    /* <key>NSLocationAlwaysUsageDescription</key>
     <string>Kullanıcının yerini saptayacaksak </string>
     <key>NSLocationWhenInUseUsageDescription</key>
     <string>Kullanıcının sadece uygulamayı kullandığı zaman aktif olur </string>
     
     info ya yukarıdakiler eklenir
     */

    
    @IBOutlet weak var harita: MKMapView!
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self // location manager ın yaptığı işlemlerden self diyerek view controller ın haberdar olması sağlanır
        locationManager.desiredAccuracy = kCLLocationAccuracyBest //location manager ın hassaslık ölçüleriyle ilgili bazı parametreler gönderilir. yani en hassas ölçüleri getirmesiyle ilgili
        locationManager.requestWhenInUseAuthorization() // bu uygulama sizin lokasyonunuza erişmek istiyor
        locationManager.startUpdatingLocation() // kişi hareket ettikçe lokasyonunu güncelleme
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) { // lokasyon bilgilerini verir
        let userLocation : CLLocation = locations[0] // enlem boylam bilgilerini almak için bir değişken oluşturulur
        let enlem = userLocation.coordinate.latitude
        let boylam = userLocation.coordinate.longitude
        
        let enlemDelta : CLLocationDegrees = 0.05 // hassaslık
        let boylamDelta : CLLocationDegrees = 0.05
        
        let span = MKCoordinateSpan(latitudeDelta: enlemDelta, longitudeDelta: boylamDelta)
        let location = CLLocationCoordinate2D(latitude: enlem, longitude: boylam)
        let coordinates = CLLocationCoordinate2D(latitude: enlem, longitude: boylam)
        let region = MKCoordinateRegion(center: location, span: span) // haritada bir alan oluşturur lokasyonun merkezine göre
        self.harita.setRegion(region, animated: true)
        let pin = MKPointAnnotation() // kırmızı pin
        pin.title = "Lokasyon"
        pin.subtitle = "Bulunduğunuz Yer!"
        pin.coordinate = coordinates
        self.harita.addAnnotation(pin)
    }


}

