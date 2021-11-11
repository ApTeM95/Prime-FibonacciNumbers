//
//  ProgressTableViewCell.swift
//  Prime&Fibonacci Numbers
//
//  Created by Артем on 12.07.2021.
//

import UIKit

class ProgressTableViewCell: UITableViewCell {

    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        loader.startAnimating()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
