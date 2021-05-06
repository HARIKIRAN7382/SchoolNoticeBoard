//
//  NoticeDetailsViewController.swift
//  SchoolNoticeBoard
//
//  Created by iOS Developer on 06/05/21.
//

import UIKit

class NoticeDetailsViewController: UIViewController {
    
    
    @IBOutlet weak var noticeImateView: UIImageView!
    @IBOutlet weak var noticeImageHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var noticeHeadingLabel: UILabel!
    @IBOutlet weak var noticeDateLabel: UILabel!
    @IBOutlet weak var noticeTeacherLabel: UILabel!
    @IBOutlet weak var noticeStudentLabel: UILabel!
    @IBOutlet weak var noticeDescription: UILabel!
    
    var notice:Notice?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let notice = notice{
            if notice.notice_image != "" {
                noticeImateView.isHidden = false
                noticeImateView.image = notice.notice_image?.base64Convert()
                noticeImageHeightConstraint.constant = 400
            }else{
                noticeImateView.isHidden = true
                noticeImageHeightConstraint.constant = 50
            }
            noticeHeadingLabel.text = notice.notice_heading
            noticeDateLabel.text = notice.notice_send_date_time
            noticeTeacherLabel.text = notice.teacher_name
            noticeStudentLabel.text = notice.student_name
            noticeDescription.text = notice.notice_description
            
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
