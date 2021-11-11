//
//  NumbersTableViewCell.swift
//  Prime&Fibonacci Numbers
//
//  Created by Артем on 11.07.2021.
//

import UIKit

class NumbersTableViewCell: UITableViewCell {
    @IBOutlet weak var leftNumberLabel: UILabel!
    @IBOutlet weak var rightNumberLabel: UILabel!
    
    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var rightView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func fillCellWith(leftNumber left: Int, rightNumber right: Int) {
        leftNumberLabel.text = "\(left)"
        rightNumberLabel.text = "\(right)"
        
        let isEven = tag % 2 == 0
        leftView.backgroundColor = isEven ? #colorLiteral(red: 0.7441433072, green: 0.6248514056, blue: 0.5064539909, alpha: 1) : #colorLiteral(red: 0.6806539297, green: 0.3485928476, blue: 0.2231357396, alpha: 1)
        rightView.backgroundColor = isEven ? #colorLiteral(red: 0.6806539297, green: 0.3485928476, blue: 0.2231357396, alpha: 1) : #colorLiteral(red: 0.7441433072, green: 0.6248514056, blue: 0.5064539909, alpha: 1)
    }
}
