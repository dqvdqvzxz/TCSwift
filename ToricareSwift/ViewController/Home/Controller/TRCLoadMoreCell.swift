//
//  TRCLoadMoreCell.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 7/31/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

class TRCLoadMoreCell: UITableViewCell {

    @IBOutlet weak var viewIndicator: UIView!
    @IBOutlet weak var viewTitle: UIView!
    
    @IBOutlet weak var indicatorLoadMore: UIActivityIndicatorView!
    
    @IBOutlet weak var lblTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: Loading
    func startStopLoading(_ isStart: Bool){
        if(isStart){
            indicatorLoadMore.startAnimating()
            lblTitle.text = "Loading Data"
        }else{
            indicatorLoadMore.stopAnimating()
            lblTitle.text = "Pull for more data"
        }
    }
}
