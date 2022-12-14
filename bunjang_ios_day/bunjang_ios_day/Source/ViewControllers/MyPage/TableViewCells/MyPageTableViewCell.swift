//
//  MyPageTableViewCell.swift
//  bunjang_ios_day
//
//  Created by 안다영 on 2022/08/30.
//

import UIKit

protocol MyPageTableViewDelegate {
    func tapMoreButton(tableIndex: Int)
}

class MyPageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var photoView: UIImageView!
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    var index = 0
    var delegate:MyPageTableViewDelegate?
    
    @IBAction func tapMoreButton(_ sender: UIButton) {
        self.delegate?.tapMoreButton(tableIndex: index)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        photoView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
