//
//  ListTvShowCell.swift
//  VirgoProject
//
//  Created by Administrator on 24/05/22.
//

import UIKit

class ListTvShowCell: UICollectionViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setPosterImage(urlString: String?) {
        ImageDownloader.shared.setupImage(urlImage: urlString, imageView: posterImageView)
    }
}
