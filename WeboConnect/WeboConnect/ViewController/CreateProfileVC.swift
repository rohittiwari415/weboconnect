//
//  CreateProfileVC.swift
//  WeboConnect
//
//  Created by apple on 20/04/23.
//

import UIKit

class CreateProfileVC: UIViewController {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var firstNameView: UIView!
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var lastNameView: UIView!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var locationView: UIView!
    @IBOutlet weak var postalView: UIView!
    @IBOutlet weak var postalTF: UITextField!
    @IBOutlet weak var submitBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func submitAction(_ sender: Any) {
        fetchAPI(param: ["firstName" : firstNameTF.text ?? "", "lastName" : lastNameTF.text ?? "", "phone": phoneTF.text ?? "", "postalAddress" : postalTF.text ?? ""])
    }
    
    func fetchAPI(param : [String: String]) {
        // 1. Define the URL and the parameters
        let urlString = "https://dummy-api.com/submit"
        let params = param

        // 2. Create the URLRequest object
        var request = URLRequest(url: URL(string: urlString)!)
        request.httpMethod = "POST"

        // 3. Add the form data to the request
        let formBody = params.map { key, value in
            "\(key)=\(value)"
        }.joined(separator: "&")
        request.httpBody = formBody.data(using: .utf8)

        // 4. Send the request using URLSession
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            print(data)
            // Handle the response here
        }
        task.resume()

    }
  
    func setupUI() {
        imgView.layer.cornerRadius = 60.0
        firstNameView.layer.cornerRadius = 5.0
        lastNameView.layer.cornerRadius = 5.0
        phoneView.layer.cornerRadius = 5.0
        postalView.layer.cornerRadius = 5.0
        submitBtn.layer.cornerRadius = 5.0
        locationView.layer.cornerRadius = 5.0
        firstNameTF.delegate = self
        lastNameTF.delegate = self
        phoneTF.delegate = self
        postalTF.delegate = self
    }

}

extension CreateProfileVC:UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == firstNameTF {
            firstNameView.layer.borderColor = UIColor.orange.cgColor
            firstNameView.layer.borderWidth = 1.0
        }else if textField == lastNameTF {
            lastNameView.layer.borderColor = UIColor.orange.cgColor
            lastNameView.layer.borderWidth = 1.0
        }else if textField == phoneTF {
            phoneView.layer.borderColor = UIColor.orange.cgColor
            phoneView.layer.borderWidth = 1.0
        }else if textField == postalTF {
            postalView.layer.borderColor = UIColor.orange.cgColor
            postalView.layer.borderWidth = 1.0
        }
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == firstNameTF {
            firstNameView.layer.borderWidth = 0.0
        }else if textField == lastNameTF {
            lastNameView.layer.borderWidth = 0.0
        }else if textField == phoneTF {
            phoneView.layer.borderWidth = 0.0
        }else if textField == postalTF {
            postalView.layer.borderWidth = 0.0
        }
    }
}
