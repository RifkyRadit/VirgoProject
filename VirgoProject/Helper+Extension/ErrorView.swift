//
//  ErrorView.swift
//  VirgoProject
//
//  Created by Administrator on 24/05/22.
//

import Foundation
import UIKit

protocol ErrorViewDelegate: AnyObject {
    func didTapRetryButton()
}

class ErrorView: UIView {
    
    weak var delegate: ErrorViewDelegate?
    
    lazy var errorImage: UIImageView = {
        let image: UIImageView = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var retryButton: UIButton = {
        let button: UIButton = UIButton(type: .roundedRect)
        button.backgroundColor = UIColor.lightGray
        button.layer.cornerRadius = 5
        button.tintColor = UIColor.white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
        addSubview(errorImage)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(retryButton)
        
        errorImage.image = UIImage(named: "image_error")
        titleLabel.text = "Something went wrong!!!"
        descriptionLabel.text = "please, check your connection and wait a while. Press Retry to reload"
        
        retryButton.setTitle("Retry", for: .normal)
        retryButton.addTarget(self, action: #selector(actionRetryButton(_:)), for: .touchUpInside)
    }
    
    func setupLayouts() {
        NSLayoutConstraint.activate([
            errorImage.topAnchor.constraint(equalTo: topAnchor, constant: Margin.mainMargin),
            errorImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            errorImage.widthAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width - 32) / 2),
            errorImage.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 3)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: errorImage.bottomAnchor, constant: Margin.minimumMargin),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Margin.mainMargin),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Margin.mainMargin)
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Margin.minimumMargin),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Margin.mainMargin),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Margin.mainMargin)
        ])
        
        NSLayoutConstraint.activate([
            retryButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: Margin.minimumMargin),
            retryButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            retryButton.widthAnchor.constraint(equalToConstant: 90),
            retryButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Margin.mainMargin)
        ])
    }
    
    @objc
    func actionRetryButton(_ sender: UIButton) {
        guard let delegate = delegate else {
            return
        }
        
        delegate.didTapRetryButton()
    }
    
}
