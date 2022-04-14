//
//  PulledDataTableViewCell.swift
//  MoneyManagementCapstone
//
//  Created by Satyam on 2022-04-09.
//

import UIKit

class PulledDataTableViewCell: UITableViewCell {

    
    @IBOutlet weak var lblAmount: UILabel!
    
    @IBOutlet weak var lblNote: UILabel!
    
    @IBOutlet weak var lblNumber: UILabel!
    
    @IBOutlet weak var lblTypee: UILabel!
    
    
   @IBOutlet weak var lblDate: UILabel!
    
    @IBOutlet weak var lblCategory: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }

}
