//
//  MovieTableViewCell.swift
//  RottenTomatoes
//
//  Created by William Castellano on 2/3/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieTitleThumbnail: UIImageView!
    @IBOutlet weak var movieSynopsisLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
