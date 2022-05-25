//
//  ImageDownloader.swift
//  VirgoProject
//
//  Created by Administrator on 24/05/22.
//

import Foundation
import Kingfisher

struct ImageDownloader {
    
    static let shared = ImageDownloader()
    
    func setupImage(urlImage: String?, imageView: UIImageView) {
        if let urlString = urlImage, !urlString.isEmpty {
            let url = URL(string: urlString)
            imageView.kf.indicatorType = .activity
            imageView.kf.setImage(with: url, placeholder: UIImage(named: "image_placeholder"), options: [.backgroundDecode, .cacheOriginalImage], completionHandler: nil)
        } else {
            imageView.image = UIImage(named: "image_placeholder")
        }
    }

}
