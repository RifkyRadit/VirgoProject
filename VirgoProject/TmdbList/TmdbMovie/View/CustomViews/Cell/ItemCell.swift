//
//  ItemCell.swift
//  VirgoProject
//
//  Created by Administrator on 24/05/22.
//

import UIKit
import Kingfisher

class ItemCell: UICollectionViewCell {

    @IBOutlet weak var itemImageCell: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupImage(urlString: String?) {
        
        ImageDownloader.shared.setupImage(urlImage: urlString, imageView: itemImageCell)
    }
}
