//
//  MapVC.swift
//  foursquareClone
//
//  Created by Doğan seçilmiş on 21.06.2022.
//

import UIKit
import Parse
import MapKit

class MapVC: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate {

    @IBOutlet weak var mapview: MKMapView!
    var locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(saveButtonClicked))
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "< Back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(backButtonClicked))
        
        mapview.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        let recognizer = UILongPressGestureRecognizer(target: self, action: #selector(chooseLocation(gestureRecognizer:)))
        recognizer.minimumPressDuration = 3
        mapview.addGestureRecognizer(recognizer)
    
    
    }
    
    @objc func chooseLocation (gestureRecognizer: UIGestureRecognizer) {
        
        if gestureRecognizer.state == UIGestureRecognizer.State.began{
            let touches = gestureRecognizer.location (in:self.mapview)
            let coordinates = self.mapview.convert(touches, toCoordinateFrom: self.mapview)
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinates
            annotation.title = PlaceModel.sharedInstance.placeName
            annotation.subtitle = PlaceModel.sharedInstance.placeType
            self.mapview.addAnnotation(annotation)
            PlaceModel.sharedInstance.Placelatitude = String(coordinates.latitude)
            PlaceModel.sharedInstance.Placelongtitude = String(coordinates.longitude)
            
        }
        
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude:locations[0].coordinate.longitude )
        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        let region = MKCoordinateRegion(center: location, span: span)
        mapview.setRegion(region, animated: true)
    }
    @objc func saveButtonClicked () {
        let placeModel = PlaceModel.sharedInstance
        let object = PFObject(className: "Places")
        object["name"] = placeModel.placeName
        object["type"] = placeModel.placeType
        object["atmosphere"] = placeModel.placeatmosphere
        object["latitude"] = placeModel.Placelatitude
        object["longitude"] = placeModel.Placelongtitude
        
        if let  imageData = placeModel.imageView.jpegData(compressionQuality: 0.5){
            object["image"] = PFFileObject(name: "image.jpg", data: imageData)
        }
        object.saveInBackground { success, error in
            if error != nil {
                let alert = UIAlertController(title: "Erro", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            }else{
                self.performSegue(withIdentifier: "toPlacesVC2", sender: nil)
            }
        }
        
    }
    @objc func backButtonClicked () {
        self.dismiss(animated: true, completion: nil)
        
    }
}
