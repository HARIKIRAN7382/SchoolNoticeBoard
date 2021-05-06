//
//  NoticesViewController.swift
//  SchoolNoticeBoard
//
//  Created by iOS Developer on 06/05/21.
//

import UIKit

class NoticesViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var noNoticeView: UIView!
    @IBOutlet weak var noNoticesLabel: UILabel!
    @IBOutlet weak var noNocicesViewHeightContraint: NSLayoutConstraint!
    @IBOutlet weak var noticesCollectionView: UICollectionView!
    @IBOutlet weak var noticesHeadingLabel: UILabel!
    
    var userId:String?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var notices:[Notice]?

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetchNotices()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Notices"
        self.navigationItem.setHidesBackButton(true, animated: true)
        let addNewNoticeBarButton = UIBarButtonItem(image: .add, style: .done, target: self, action: #selector(addNewNotice(_:)))
        self.navigationItem.rightBarButtonItem = addNewNoticeBarButton
        // Do any additional setup after loading the view.
       
    }
    
    @objc func addNewNotice( _ sender:UIBarButtonItem){
        let addOrEditNoticesVC = (storyboard?.instantiateViewController(identifier: "AddOrUpdateViewController"))! as AddOrUpdateViewController
        addOrEditNoticesVC.userId = self.userId
        navigationController?.pushViewController(addOrEditNoticesVC, animated: true)
    }
    
    func fetchNotices(){
        do{
            let tempNotices = try context.fetch(Notice.fetchRequest())
            notices = []
            for value in tempNotices{
                if( (value as! Notice).notice_id ==  self.userId){
                    notices?.append(value as! Notice)
                }
            }
//            notices = tempNotices.filter { ($0 as! Notice).user_id == self.userId } as? [Notice]
            if((notices?.count ?? 0) > 0){
                DispatchQueue.main.async {
                    self.noNoticeView.isHidden = true
                    self.noNoticesLabel.isHidden = true
                    self.noNocicesViewHeightContraint.constant = 0
                    self.noticesHeadingLabel.isHidden = false
                    self.noticesCollectionView.isHidden = false
                    self.noticesCollectionView.reloadData()
                }
            }else{
                DispatchQueue.main.async {
                    self.noNoticeView.isHidden = false
                    self.noNoticesLabel.isHidden = false
                    self.noNocicesViewHeightContraint.constant = 46
                    self.noticesHeadingLabel.isHidden = true
                    self.noticesCollectionView.isHidden = true
                }
            }
          
        }catch let error{
            print(error.localizedDescription)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        (cell as! NoticeCollectionViewCell).noticesHeadingLabel.layer.cornerRadius = 20.0
        (cell as! NoticeCollectionViewCell).noticesHeadingLabel.layer.shadowColor = UIColor.gray.cgColor
        (cell as! NoticeCollectionViewCell).noticesHeadingLabel.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        (cell as! NoticeCollectionViewCell).noticesHeadingLabel.layer.shadowRadius = 6.0
        (cell as! NoticeCollectionViewCell).noticesHeadingLabel.layer.shadowOpacity = 0.3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        notices?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NoticeCollectionViewCell", for: indexPath) as! NoticeCollectionViewCell
        cell.noticesHeadingLabel.text = notices?[indexPath.row].notice_heading
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 150, height: 150)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let noticeDetailsViewController = (storyboard?.instantiateViewController(identifier: "NoticeDetailsViewController"))! as NoticeDetailsViewController
        noticeDetailsViewController.notice = notices?[indexPath.row]
        navigationController?.pushViewController(noticeDetailsViewController, animated: true)
    }

}


class NoticeCollectionViewCell:UICollectionViewCell{
    static let identifier = "NoticeCollectionViewCell"
    
    @IBOutlet weak var noticesHeadingLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
