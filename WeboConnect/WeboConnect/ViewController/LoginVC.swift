//
//  LoginVC.swift
//  WeboConnect
//
//  Created by apple on 19/04/23.
//

import UIKit
import SKCountryPicker

class LoginVC: UIViewController {
    
    @IBOutlet weak var enterMobileLbl: UILabel!
    @IBOutlet weak var countryImageView: UIImageView!
    @IBOutlet weak var countryTF: UITextField!
    @IBOutlet weak var phoneTF: TextField!
    @IBOutlet weak var countryCodeView: UIView!
    @IBOutlet weak var phoneNumberView: UIView!
    @IBOutlet weak var otpBtn: UIButton!
    @IBOutlet weak var googleView: UIView!
    @IBOutlet weak var fbView: UIView!
    
    let phoneNumber = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI ()
    }
    
    @IBAction func moveToCountryVC(_ sender: UIButton) {
        presentCountryPickerScene()
    }
    
    @IBAction func moveToPopUp(_ sender: Any) {
        if countryTF.text != "" && phoneTF.text != ""{
            let preNum =  phoneTF.text?.prefix(2)
            let postNum = phoneTF.text?.suffix(2)
            let number = "\(preNum ?? "")\(postNum ?? "")"
            print(number)
            let countryCode = countryTF.text
            var phoneNumber = phoneTF.text
            let fullNumber = "\(countryCode ?? "")\(phoneNumber ?? "")"
            phoneNumber = fullNumber.replacingOccurrences(of: " ", with: "")
            UserDefaults.standard.set(phoneNumber, forKey: "number")
            let VC = storyboard?.instantiateViewController(withIdentifier: "PopUpOTPVC") as! PopUpOTPVC
            VC.modalPresentationStyle = .overFullScreen
            self.view.alpha = 0.5
            VC.otpNumber = number
            self.present(VC, animated: false)
        }

    }
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupUI () {
        self.countryImageView.layer.cornerRadius = 6.0
        enterMobileLbl.text = "Enter Your Mobile \nNumber"
        phoneTF.delegate = self
        self.countryCodeView.layer.cornerRadius = 5.0
        self.phoneNumberView.layer.cornerRadius = 5.0
        self.googleView.layer.cornerRadius = 5.0
        self.fbView.layer.cornerRadius = 5.0
        self.otpBtn.layer.cornerRadius = 5.0
    }
    
    func presentCountryPickerScene(withSelectionControlEnabled selectionControlEnabled: Bool = true) {
           switch selectionControlEnabled {
           case true:
               // Present country picker with `Section Control` enabled
               CountryPickerWithSectionViewController.presentController(on: self, configuration: { countryController in
                   countryController.configuration.flagStyle = .circular
                   countryController.modalPresentationStyle = .fullScreen
                   countryController.favoriteCountriesLocaleIdentifiers = ["IN", "US"]

               }) { [weak self] country in
                   
                   guard let self = self else { return }
                   self.countryImageView.isHidden = false
                   self.countryImageView.image = country.flag
                   self.countryTF.text = country.dialingCode
               }
               
           case false:
               // Present country picker without `Section Control` enabled
               CountryPickerController.presentController(on: self, configuration: { countryController in
                   countryController.modalPresentationStyle = .fullScreen
                   countryController.configuration.flagStyle = .corner
                   countryController.favoriteCountriesLocaleIdentifiers = ["IN", "US"]

               }) { [weak self] country in
                   
                   guard let self = self else { return }
                   
                   self.countryImageView.isHidden = false
                   self.countryImageView.image = country.flag
                   self.countryTF.text = country.dialingCode
               }
           }
       }
   }

extension LoginVC : UITextFieldDelegate {
   
    func format(with mask: String, phone: String) -> String {
        let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex // numbers iterator

        // iterate over the mask characters until the iterator of numbers ends
        for ch in mask where index < numbers.endIndex {
            if ch == "X" {
                // mask requires a number in this place, so take the next one
                result.append(numbers[index])

                // move numbers iterator to the next index
                index = numbers.index(after: index)

            } else {
                result.append(ch) // just append a mask character
            }
        }
        return result
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        textField.text = format(with: "XXX XXX XXXX", phone: newString)
        return false
    }
}
