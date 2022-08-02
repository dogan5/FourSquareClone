//
//  AddPlacesVC.swift
//  foursquareClone
//
//  Created by Doğan seçilmiş on 21.06.2022.
//

import UIKit

class AddPlacesVC: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var placeNameTextfield: UITextField!
    @IBOutlet weak var placeTypeTextfield: UITextField!
    @IBOutlet weak var placeAtmosphereTextfield: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.isUserInteractionEnabled = true
        let guestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseimage))
        imageView.addGestureRecognizer(guestureRecognizer)
    }
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        if placeNameTextfield.text != "" && placeTypeTextfield.text != "" && placeAtmosphereTextfield.text != "" {
            if let chosenImage = imageView.image {
                let placeModel = PlaceModel.sharedInstance
                placeModel.placeName = placeNameTextfield.text!
                placeModel.placeType = placeTypeTextfield.text!
                placeModel.placeatmosphere = placeAtmosphereTextfield.text!
                placeModel.imageView = chosenImage
            }
            performSegue(withIdentifier: "toMapVC", sender: nil)
        }else{
            let makeAlert = UIAlertController(title: "Error", message: "Name/Type/Atmosphere??", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            makeAlert.addAction(okButton)
            self.present(makeAlert, animated: true, completion: nil)
        }
        
    }
    @objc func chooseimage (){
       let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
}
