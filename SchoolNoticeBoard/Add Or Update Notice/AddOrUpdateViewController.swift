//
//  AddOrUpdateViewController.swift
//  SchoolNoticeBoard
//
//  Created by iOS Developer on 06/05/21.
//

import UIKit

// Open Image
enum PickerType {
    case camera
    case photolib
}

class AddOrUpdateViewController: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate {
    
    @IBOutlet weak var noticeToTextField: UITextField!
    @IBOutlet weak var noticeHeadingTF: UITextField!
    @IBOutlet weak var noticeDescriptionTV: UITextView!
    @IBOutlet weak var noticeByTextView: UITextField!
    @IBOutlet weak var uploadImageBtn: UIButton!
    @IBOutlet weak var previewImage: UIImageView!
    @IBOutlet weak var saveBtn: UIButton!
    
    var userId:String?
    var uploadImage:String?
    var imagePickerController:UIImagePickerController?
    var selectedNotice:Notice?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Please enter notice details"
        noticeDescriptionTV.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        noticeDescriptionTV.layer.borderWidth = 1
        noticeDescriptionTV.layer.cornerRadius = 5
        // Do any additional setup after loading the view.
        
        noticeToTextField.addDoneCancelToolbar()
        noticeHeadingTF.addDoneCancelToolbar()
        noticeDescriptionTV.addDoneCancelToolbar()
        noticeByTextView.addDoneCancelToolbar()
    }
    
    @IBAction func saveBtnTouchUpInside(_ sender: UIButton) {
        if let noticeTo = noticeToTextField.text, let noticeHeading = noticeHeadingTF.text, let noticeDescription = noticeDescriptionTV.text, let noticeBy = noticeByTextView.text,!noticeTo.replacingOccurrences(of: " ", with: "").isEmpty,!noticeHeading.replacingOccurrences(of: " ", with: "").isEmpty,!noticeDescription.replacingOccurrences(of: " ", with: "").isEmpty,!noticeBy.replacingOccurrences(of: " ", with: "").isEmpty{
            if(sender.titleLabel?.text == "Update"){
                selectedNotice?.student_name = noticeTo
                selectedNotice?.notice_heading = noticeHeading
                selectedNotice?.notice_description = noticeDescription
                selectedNotice?.notice_id = userId
                selectedNotice?.teacher_name = noticeBy
                selectedNotice?.notice_send_date_time = Date().toString(format: "dd-MM-yyyy hh:mm")
                if let previewImageBase64 = uploadImage{
                    selectedNotice?.notice_image = previewImageBase64
                }
                do{
                    try context.save()
                    DispatchQueue.main.async {
                        self.showAlertWithMsg(message: "Order is updated successsfully.", navigateToNotices: false, isUpdatingExistantOrder: true)
                    }
                }catch let error{
                    print(error.localizedDescription)
                }
            }else{
                let notice = Notice(context: self.context)
                notice.student_name = noticeTo
                notice.notice_heading = noticeHeading
                notice.notice_description = noticeDescription
                notice.notice_id = userId
                notice.teacher_name = noticeBy
                notice.notice_send_date_time = Date().toString(format: "dd-MM-yyyy hh:mm")
                if let previewImageBase64 = uploadImage{
                    notice.notice_image = previewImageBase64
                }
                do{
                    try context.save()
                    DispatchQueue.main.async {
                        self.showAlertWithMsg(message: "Notice saved successfully. Do you want add one more notice?", navigateToNotices: true, isUpdatingExistantOrder: false)
                    }
                }catch let error{
                    print(error.localizedDescription)
                }
            }
        }else{
            showAlertWithMsg(message: "Please enter all required input fields.", navigateToNotices: false, isUpdatingExistantOrder: false)
        }
    }
    
    
    @IBAction func uploadImageBtnTouchUpInside(_ sender: Any) {
        
        imagePickerController = UIImagePickerController()
        
        imagePickerController?.delegate = self
        
        let alertController = UIAlertController(title: "", message: "Upload Image By", preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction(title: "Camara", style: .default, handler: { UIAlertAction in
            guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
                self.openSource(.photolib)
                return
            }
            self.openSource(.camera)
        }))
        
        alertController.addAction(UIAlertAction(title: "Photos", style: .default, handler: { UIAlertAction in
            self.openSource(.photolib)
        }))
        
        self.navigationController?.present(alertController, animated: true, completion: nil)
    }
    
    
    func openSource(_ picker:PickerType){
        
        switch picker {
            case .camera:
                imagePickerController?.sourceType = .camera
            case .photolib:
                imagePickerController?.sourceType = .photoLibrary
        }
        present(imagePickerController ?? UIImagePickerController(), animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagePickerController?.dismiss(animated: true, completion: nil)
        guard let image = info[.originalImage] as? UIImage else {
            print("No Image Found")
            return
        }
        
        let imageData: Data? = image.jpegData(compressionQuality: 0.4)
        uploadImage = imageData?.base64EncodedString(options: .lineLength64Characters) ?? ""
       
        previewImage.image = image
    }
    
    func showAlertWithMsg(message:String,navigateToNotices:Bool,isUpdatingExistantOrder:Bool){
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        if navigateToNotices {
            self.noticeToTextField.text = ""
            self.noticeHeadingTF.text = ""
            self.noticeDescriptionTV.text = ""
            self.noticeByTextView.text = ""
            self.previewImage.image = UIImage()
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (UIAlertAction) in
                self.saveBtn.setTitle("Save", for: .normal)
            }))
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (UIAlertAction) in
                self.dismiss(animated: true, completion: nil)
                self.navigationController?.popViewController(animated: true)
            }))
        }else if isUpdatingExistantOrder{
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (UIAlertAction) in
                self.dismiss(animated: true, completion: nil)
                self.navigationController?.popViewController(animated: true)
            }))
        }else{
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (UIAlertAction) in
                self.dismiss(animated: true, completion: nil)
            }))
        }
        present(alert, animated: true, completion: nil)
    }

}
