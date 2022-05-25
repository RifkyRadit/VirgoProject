//
//  HeaderView.swift
//  VirgoProject
//
//  Created by Administrator on 24/05/22.
//

import UIKit
import Kingfisher

protocol HeaderViewInput: AnyObject {
    func addHeaderViewComponent(imageUrl: String?, title: String)
}

class HeaderView: UIView {
    
    let sideMargin: CGFloat = 16
    let minimumMargin: CGFloat = 8
    var heightImage: CGFloat = 0
    
    lazy var headerImageView: UIImageView = {
        let image: UIImageView = UIImageView()
        image.contentMode = .scaleToFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var titleView: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = UIColor(named: "header_title_color")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let titleLabel: UILabel = UILabel()
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.text = ""
        titleLabel.textColor = .white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupViews()
        setupLayouts()
    }
    
    func setupViews() {
        setupHeightImage()
        addSubview(headerImageView)
        addSubview(titleView)
        titleView.addSubview(titleLabel)
    }
    
    func setupLayouts() {
        NSLayoutConstraint.activate([
            headerImageView.topAnchor.constraint(equalTo: topAnchor),
            headerImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            headerImageView.heightAnchor.constraint(equalToConstant: self.heightImage)
        ])
        
        NSLayoutConstraint.activate([
            titleView.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleView.trailingAnchor.constraint(equalTo:trailingAnchor),
            titleView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: titleView.topAnchor, constant: minimumMargin),
            titleLabel.leadingAnchor.constraint(equalTo: titleView.leadingAnchor, constant: sideMargin),
            titleLabel.trailingAnchor.constraint(equalTo: titleView.trailingAnchor, constant: -sideMargin),
            titleLabel.bottomAnchor.constraint(equalTo: titleView.bottomAnchor, constant: -minimumMargin)
        ])
    }
    
    func setupHeightImage() {
        self.heightImage = (UIScreen.main.bounds.size.height - 74)/3
    }
}

extension HeaderView: HeaderViewInput {
    func addHeaderViewComponent(imageUrl: String?, title: String) {        
        let urlBackdrop = [NetworkHelper.shared.baseUrlImage, imageUrl ?? ""].joined()
        ImageDownloader.shared.setupImage(urlImage: urlBackdrop, imageView: headerImageView)
        
        titleLabel.text = title
    }
}
