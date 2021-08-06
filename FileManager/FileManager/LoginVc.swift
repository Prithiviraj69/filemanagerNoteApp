//
//  LoginVc.swift
//  FileManager
//
//  Created by DCS on 09/07/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class LoginVc: UIViewController {
    
    
    private let usertxt:UITextField = {
        let txt = UITextField()
        txt.placeholder = "USER NAME "
        txt.textColor = .orange
        //txt.autocorrectionType = .
        txt.autocapitalizationType = .none
        txt.borderStyle = .roundedRect
        txt.textAlignment = .center
        txt.borderStyle = .roundedRect
        
        return txt
    }()
    private let pswdtxt:UITextField = {
        let txt = UITextField()
        txt.placeholder = "PASSWORD "
        txt.textColor = .orange
        txt.isSecureTextEntry = true
        //txt.autocorrectionType = .
        txt.autocapitalizationType = .none
        txt.borderStyle = .roundedRect
        txt.textAlignment = .center
        txt.borderStyle = .roundedRect
        
        return txt
    }()
    
    private let mybtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("LOGIN", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.borderWidth = 5
        
        btn.addTarget(self, action: #selector(loginfunc), for: .touchUpInside)
        btn.backgroundColor = .orange
        btn.layer.cornerRadius = 27
        
        return btn
    }()
    @objc private func loginfunc(){
        if usertxt.text == "yash" && pswdtxt.text == "yash10"{
            UserDefaults.standard.setValue("abcdefg", forKey: "sessionToken")
            UserDefaults.standard.setValue(usertxt.text, forKey: "username")
            self.dismiss(animated: true)
            
        }
        else{
            let  alert = UIAlertController(title: "Incorrect!", message: "Username or password is incorrect !", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Close", style: .cancel))
            DispatchQueue.main.async {
                self.present(alert,animated: true,completion : nil)
            }
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "LOGIN"
        view.addSubview(pswdtxt)
        view.addSubview(usertxt)
        view.addSubview(mybtn)
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        usertxt.frame = CGRect(x: 20,y: 300, width: view.width - 40, height: 50)
        pswdtxt.frame = CGRect(x: 20,y: usertxt.bottom + 10, width: view.width - 40, height: 50)
        mybtn.frame = CGRect(x: 20,y: pswdtxt.bottom + 10, width: view.width - 40, height: 50)
        
    }
    
}
