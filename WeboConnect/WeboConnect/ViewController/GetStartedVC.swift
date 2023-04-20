//
//  ViewController.swift
//  WeboConnect
//
//  Created by apple on 19/04/23.
//

import UIKit

class GetStartedVC: UIViewController {
    
    @IBOutlet weak var getStartedBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getStartedBtn.layer.cornerRadius = 5.0
    }
    
    @IBAction func moveToLogin(_ sender: Any) {
        let VC = storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        self.navigationController?.pushViewController(VC, animated: true)
    }

}

