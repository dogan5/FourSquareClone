//
//  ViewController.swift
//  foursquareClone
//
//  Created by Doğan seçilmiş on 10.06.2022.
//

import UIKit
import Parse

class SignUpVC: UIViewController {
    
    @IBOutlet var usernameTextfield:UITextField!
    @IBOutlet var passwordTextfield:UITextField!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

      /*  let ParseObject = PFObject(className: "fruits")
        ParseObject["name"] = "Banana"
        ParseObject["clories"] = 150
        ParseObject.saveInBackground { success, error in
            if error != nil {
                print(error?.localizedDescription)
            }else{
                print("uploded")
            }
        }
  
    let query = PFQuery(className: "fruits")
        query.findObjectsInBackground { objects, error in
            if error != nil {
                print(error?.localizedDescription)
            }else{
                print(objects)
            }
        }
       */
       }
    
    @IBAction func SıgnInButton(_ sender: Any) {
        if usernameTextfield.text != "" && passwordTextfield.text != "" {
            PFUser.logInWithUsername(inBackground: usernameTextfield.text!, password: passwordTextfield.text!) { user, error in
                if error != nil {
                    self.makeAlert(error: "Error", message: error?.localizedDescription  ?? "Error!!")
                }else{
                    self.performSegue(withIdentifier: "toPlacesVc", sender: nil)
                }
            }
        }else{
            makeAlert(error: "error", message: "Username ? / Password ?")
        }
    }
    @IBAction func SıgnUpButton(_ sender: Any) {
        if usernameTextfield.text != "" && passwordTextfield.text != "" {
            let user = PFUser()
            user.username = usernameTextfield.text!
            user.password = passwordTextfield.text!
            
            user.signUpInBackground { success, error in
                if error != nil {
                    self.makeAlert(error: "Error", message: error?.localizedDescription ?? "Error !!")
                }else{
                    self.performSegue(withIdentifier: "toPlacesVc", sender: nil)
                }
            }
        }else{
            makeAlert(error: "Error", message: "Username ? / Password ?")
        }
    

}
    func makeAlert(error:String,message:String) {
        let alert = UIAlertController(title:error , message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
    }
}
