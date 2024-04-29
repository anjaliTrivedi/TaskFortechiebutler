//
//  DetailViewController.swift
//  taskProject
//
//  Created by Anjali bhatt on 27/04/24.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailTableView: UITableView!
    var detailData: RootClass?
    var cellIdentifier = "DetailTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //define nib of detailtableviewcell
        detailTableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        detailTableView.reloadData()
        //set backbutton in navigationbar
        let buttonBaseView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage.init(named: "back"), for: .normal)
        backButton.backgroundColor = UIColor.clear
        backButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        backButton.addTarget(self, action: #selector(btnBackClicked), for: .touchUpInside)
        buttonBaseView.addSubview(backButton)
        var forwardButtonItem: UIBarButtonItem?
        forwardButtonItem = UIBarButtonItem(customView: buttonBaseView)
        self.navigationItem.leftBarButtonItem = forwardButtonItem
    }
    //MARK:- selector method
    @objc func btnBackClicked(){
        //back button click event
        self.navigationController?.popViewController(animated: true)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Details"
    }
}
extension DetailViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //load data which is pass from previous controller
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! DetailTableViewCell
        cell.labelDetail.numberOfLines = 0
        cell.labelDetail.sizeToFit()
        if(indexPath.row == 0){
            let intValue: Int = detailData?.it ?? 0
            cell.labelDetail.text = "ID : \(String(intValue))"
        }else if(indexPath.row == 1){
            let intValueUserID: Int = detailData?.userId ?? 0
            cell.labelDetail.text = "USERID : \(String(intValueUserID))"
        }else if(indexPath.row == 2){
            cell.labelDetail.text = "TITLE : \(detailData?.title ?? "NA")"
        }else if(indexPath.row == 3){
            cell.labelDetail.text = "BODY : \(detailData?.body ?? "NA")"
        }
        return cell
    }
    
}

