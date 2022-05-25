//
//  VoteAverageView.swift
//  VirgoProject
//
//  Created by Administrator on 24/05/22.
//

import Foundation
import UIKit

class VoteAverageView: UIView {
    
    lazy var titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.spacing = 32
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var thumbsUpImageView: UIImageView = {
        let image: UIImageView = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var thumbsDownImageView: UIImageView = {
        let image: UIImageView = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
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
        
        addSubview(titleLabel)
        addSubview(stackView)
        
        stackView.addArrangedSubview(thumbsUpImageView)
        stackView.addArrangedSubview(thumbsDownImageView)
        
        titleLabel.text = "Vote Average"
        setupImage()
    }
    
    func setupLayouts() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: Margin.mainMargin),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Margin.mainMargin),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Margin.mainMargin)
        ])
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: Margin.minimumMargin),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            stackView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            thumbsUpImageView.widthAnchor.constraint(equalToConstant: 20),
            thumbsUpImageView.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            thumbsDownImageView.widthAnchor.constraint(equalToConstant: 20),
            thumbsDownImageView.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func setupImage() {
        let tapGestureThumbsUp = UITapGestureRecognizer(target: self, action: #selector(actionTapThumbsUp(_:)))
        thumbsUpImageView.addGestureRecognizer(tapGestureThumbsUp)
        thumbsUpImageView.isUserInteractionEnabled = true
        thumbsUpImageView.image = thumbsUpImageView.image?.withRenderingMode(.alwaysTemplate)
        thumbsUpImageView.tintColor = .lightGray
        thumbsUpImageView.image = UIImage(named: "thumbs_up")
        
        let tapGestureThumbsDown = UITapGestureRecognizer(target: self, action: #selector(actionTapThumbsDown(_:)))
        thumbsDownImageView.addGestureRecognizer(tapGestureThumbsDown)
        thumbsDownImageView.isUserInteractionEnabled = true
        thumbsDownImageView.image = thumbsDownImageView.image?.withRenderingMode(.alwaysTemplate)
        thumbsDownImageView.tintColor = .lightGray
        thumbsDownImageView.image = UIImage(named: "thumbs_down")
    }
    
    @objc
    func actionTapThumbsUp(_ sender: UITapGestureRecognizer) {
        thumbsUpImageView.tintColor = .yellow
    }
    
    @objc
    func actionTapThumbsDown(_ sender: UITapGestureRecognizer) {
        thumbsDownImageView.tintColor = .yellow
    }
}
