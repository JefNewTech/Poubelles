//
//  CarteController.swift
//  Poubelles
//
//  Created by Jean-François Coquerelle on 17/06/18.
//  Copyright © 2018 Jean-François Coquerelle. All rights reserved.
//

import UIKit
import MapKit


class CarteController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var carte: MKMapView!
    @IBOutlet weak var maPositionBouton: UIButton!
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var pickerView: UIPickerView!
    
    var urlString = ""
    var locationManager = CLLocationManager()
    var poubelles: Poubelles?
    
    var labelNames: [String] = Array()
    var selected = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
        
        carte.showsUserLocation = true
        carte.showsScale = true
        carte.showsCompass = true
        
        carte.register(AnnotationVue.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        
        miseEnPlace()
        obtenirDonneesDepuisJSON()
        
        labelNames.append("Poubelles publique")
        labelNames.append("Ecart poubelle du Mardi")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        pickerView.selectRow(0, inComponent: 0, animated: true)
        self.carte.removeAnnotations(self.carte.annotations)
        urlString = "http://jefnewtech.be/Map/Poubelles%20publique.json"
        obtenirDonneesDepuisJSON()
    }
    

    
    func obtenirDonneesDepuisJSON() {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard data != nil else { return }
            do {
                self.poubelles = try JSONDecoder().decode(Poubelles.self, from: data!)
                DispatchQueue.main.async {
                    self.obtenirAnnotations()
                }
                
            } catch {
                print(error.localizedDescription)
            }
            }.resume()
    }
    
    func obtenirAnnotations() {
        for poubelle in (poubelles?.features)! {
            if let latitudeString = poubelle.geometry.coordinates, let longitudeString = poubelle.geometry.coordinates {
                if let latitude = latitudeString, let longitude = longitudeString {
                    let coordonnes = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                    let titre = poubelle.properties.name
                    let cluster = "identifier"
                    let location = CLLocation(latitude: latitude, longitude: longitude)
                    MonGeocoder.obtenir.adresseDepuis(location, completion: { (adresse, erreur) -> (Void) in
                        var monAdresse = ""
                        if adresse != nil {
                            monAdresse = adresse!
                        }
                        let monAnnotation = MonAnnotation(titre: titre, adresse: monAdresse, coordonnes: coordonnes, clusteringIdentifier: cluster)
                        self.carte.addAnnotation(monAnnotation)
                    })
                }
            }
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: Double(poubelle.latitude!)!, longitude: Double(poubelle.longitude!)!)
            annotation.title = poubelle.properties.name
            self.carte.addAnnotation(annotation)
    
        }
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return labelNames.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return labelNames[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selected = row
        if (selected == 0) {
            self.carte.removeAnnotations(self.carte.annotations)
            urlString = "http://jefnewtech.be/Map/Poubelles%20publique.json"
            obtenirDonneesDepuisJSON()
        } else if (selected == 1) {
            self.carte.removeAnnotations(self.carte.annotations)
            urlString = "https://www.jefnewtech.be/Map/test.json"
            obtenirDonneesDepuisJSON()
        }
        print(urlString)
    }
    
    
    
    @IBAction func meLocaliser(_ sender: Any) {
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    @IBAction func segmentChoisi(_ sender: Any) {
        switch segment.selectedSegmentIndex {
        case 0: carte.mapType = .standard
        case 1: carte.mapType = .satellite
        case 2: carte.mapType = .hybrid
        default: break
        }
    }

}
