//
//  RegistationViewController.swift
//  SchoolNoticeBoard
//
//  Created by iOS Developer on 06/05/21.
//

import UIKit

class RegistationViewController: UIViewController {
    
    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var conformPasswordTF: UITextField!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        self.title = "User Registation"
        userNameTF.addPreviousNextDoneToolbar()
        passwordTF.addPreviousNextDoneToolbar()
        conformPasswordTF.addPreviousNextDoneToolbar()
    }
    
    @IBAction func registerBtnTouchUpInside(_ sender: UIButton) {
        if let userName = userNameTF.text, let password = passwordTF.text, let conformPassword = conformPasswordTF.text, !userName.replacingOccurrences(of: " ", with: "").isEmpty,!password.replacingOccurrences(of: " ", with: "").isEmpty,!conformPassword.replacingOccurrences(of: " ", with: "").isEmpty{
            if(password == conformPassword){
                let user = User(context: self.context)
                user.username = userName
                user.password = password
                user.userId = "\(random(digits: 3))"
                do {
                    try context.save()
                    DispatchQueue.main.async {
                        self.showAlertWithMsg(message: "Registated user successfully.", navigateToLogin: true)
                    }
                }catch let error{
                    print(error.localizedDescription)
                }
            }else{
                showAlertWithMsg(message: "Password and Conform Password are different. Please enter valid password.", navigateToLogin: false)
            }
        }else{
            showAlertWithMsg(message: "Please enter all input fields.", navigateToLogin: false)
        }
    }
    
    
    // Support Functions
    func showAlertWithMsg(message:String,navigateToLogin:Bool){
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (UIAlertAction) in
            self.dismiss(animated: true, completion: nil)
            if navigateToLogin {
                self.navigationController?.popViewController(animated: true)
            }
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func random(digits:Int) -> Int {
        let min = Int(pow(Double(10), Double(digits-1))) - 1
        let max = Int(pow(Double(10), Double(digits))) - 1
        let randomDigit = Int(range: Range(min...max))
        return randomDigit
    }
    
}
