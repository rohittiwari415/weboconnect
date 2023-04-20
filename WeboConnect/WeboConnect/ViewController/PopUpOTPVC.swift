//
//  PopUpOTPVC.swift
//  WeboConnect
//
//  Created by apple on 20/04/23.
//

import UIKit

class PopUpOTPVC: UIViewController {
    @IBOutlet weak var otp1TextField: UITextField!
    @IBOutlet weak var otp2TextField: UITextField!
    @IBOutlet weak var otp3TextField: UITextField!
    @IBOutlet weak var otp4TextField: UITextField!
    
    @IBOutlet weak var popUPView: UIView!
    @IBOutlet weak var stackView: UIView!
    
    var otpArray = [String]()
    var otpText = ""
    var otpNumber = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func checkOtp() {
        self.otpText = "\(otp1TextField.text!)\(otp2TextField.text!)\(otp3TextField.text!) \(otp4TextField.text!)"
        print(otpText)
        otpText = otpText.replacingOccurrences(of: " ", with: "")
        if (otpText == "" || otpText.count == 0) {
            self.showToast(message: "Please enter valid otp", seconds: 1.0)
        }else{
            if otpText == otpNumber{
                let VC = storyboard?.instantiateViewController(withIdentifier: "OTPVC") as! OTPVC
                VC.modalPresentationStyle = .fullScreen
                VC.otpNumber = otpText
                self.present(VC, animated: true)
            }else{
                self.showToast(message: "Please enter valid otp", seconds: 1.0)
            }
        }
    }
    
    func setupUI() {
        otp1TextField.delegate = self
        otp2TextField.delegate = self
        otp3TextField.delegate = self
        otp4TextField.delegate = self
        otp1TextField.becomeFirstResponder()
        popUPView.layer.cornerRadius = 10.0
        stackView.layer.cornerRadius = 5.0
    }
    
    func showToast(message : String, seconds: Double){
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = .black
        alert.view.alpha = 0.5
        alert.view.layer.cornerRadius = 15
        self.present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
        }
    }
    
}

extension PopUpOTPVC : UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        if (string.count > 0) {
            if textField == otp1TextField  {
                otp2TextField.becomeFirstResponder()
            }
            if textField == otp2TextField{
                otp3TextField.becomeFirstResponder()
            }
            if textField == otp3TextField{
                otp4TextField.becomeFirstResponder()
            }
            if textField == otp4TextField{
                otp4TextField.resignFirstResponder()
            }
            //            if textField == otp5TextField{
            //                otp6TextField.becomeFirstResponder()
            //            }
            //            if textField == otp6TextField{
            //                print(otp6TextField.text)
            //                otp6TextField.resignFirstResponder()
            //            }
            
            textField.text = string
            print(string.count)
            otpArray.append(string)
            if otp1TextField.text != "" && otp2TextField.text != "" && otp3TextField.text != "" && otp4TextField.text != ""  {
                self.checkOtp()
                return false
            }
            return false
            
        } else if ((textField.text?.count)! >= 1) && (string.count == 0) {
            if textField == otp2TextField{
                otp1TextField.becomeFirstResponder()
            }
            if textField == otp3TextField{
                otp2TextField.becomeFirstResponder()
            }
            if textField == otp4TextField{
                otp3TextField.becomeFirstResponder()
            }
            //            if textField == otp5TextField{
            //                otp4TextField.becomeFirstResponder()
            //            }
            //            if textField == otp6TextField{
            //                print(otp6TextField.text)
            //                otp5TextField.becomeFirstResponder()
            //            }
            if textField == otp1TextField{
                otp1TextField.resignFirstResponder()
            }
            textField.text = ""
            return false
        } else if (textField.text?.count)! >= 1 {
            textField.text = string
            print(string)
            return false
        }
        return true
    }
}
