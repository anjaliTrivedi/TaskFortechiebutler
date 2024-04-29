//
//  ListTableViewCell.swift
//  taskProject
//
//  Created by Anjali bhatt on 27/04/24.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var labelID: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //set border for uiview
        //also set constraint for all the ui component
        bgView.layer.borderColor = UIColor.lightGray.cgColor
        bgView.layer.borderWidth = 0.5
        bgView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
