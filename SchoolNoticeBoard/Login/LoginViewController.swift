//
//  LoginViewController.swift
//  SchoolNoticeBoard
//
//  Created by iOS Developer on 06/05/21.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    var users:[User]?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetchUsers()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userNameTF.addDoneCancelToolbar()
        passwordTF.addDoneCancelToolbar()
        
    }
    
    func fetchUsers(){
        do{
            users =  try context.fetch(User.fetchRequest())
        }catch let error{
            print(error.localizedDescription)
        }
    }
    
    @IBAction func signUpBtnTouchUpInside(_ sender: UIButton) {
        var isUserExist = false
        if let userName = userNameTF.text, let password = passwordTF.text, !userName.replacingOccurrences(of: " ", with: "").isEmpty,!password.replacingOccurrences(of: " ", with: "").isEmpty{
            for user in users ?? [] {
                if(user.username == userName && user.password == password){
                    isUserExist = true
                    let noticesVC = storyboard?.instantiateViewController(identifier: "NoticesViewController") as! NoticesViewController
                    noticesVC.userId = user.userId
                    self.navigationController?.pushViewController(noticesVC, animated: true)
                }
            }
            if !isUserExist {
                showAlertWith(message: "Invalid user. Please enter valid user credentials.")
            }
        }else{
            showAlertWith(message: "Please enter username and password.")
        }
    }
    
    @IBAction func createAccountBtnTF(_ sender: UIButton) {
        let registerVC = storyboard?.instantiateViewController(identifier: "RegistationViewController") as! RegistationViewController
        self.navigationController?.pushViewController(registerVC, animated: true)
    }
    
    // Suport methord
    func showAlertWith(message:String){
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (UIAlertAction) in
            self.dismiss(animated: true, completion: nil)
            self.userNameTF.text = ""
            self.passwordTF.text = ""
        }))
        self.present(alert, animated: true, completion: nil)
    }

}
