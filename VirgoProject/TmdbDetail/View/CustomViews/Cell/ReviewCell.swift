//
//  ReviewCell.swift
//  VirgoProject
//
//  Created by Administrator on 25/05/22.
//

import UIKit

class ReviewCell: UITableViewCell {
    
    lazy var stackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.distribution = .fill
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var accountImageView: UIImageView = {
        let image: UIImageView = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "icon_review_account")?.withRenderingMode(.alwaysTemplate)
        image.tintColor = .white
        return image
    }()
    
    lazy var nameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var textReviewLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupViews()
        setupLayout()
    }
    
    func setupViews() {
        backgroundColor = .clear
        
        stackView.addArrangedSubview(accountImageView)
        stackView.addArrangedSubview(nameLabel)
        
        addSubview(stackView)
        addSubview(textReviewLabel)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            accountImageView.widthAnchor.constraint(equalToConstant: 20),
            accountImageView.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: Margin.mainMargin),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Margin.minimumMargin),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Margin.minimumMargin)
        ])
        
        NSLayoutConstraint.activate([
            textReviewLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: Margin.minimumMargin),
            textReviewLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Margin.minimumMargin),
            textReviewLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Margin.minimumMargin),
            textReviewLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Margin.mainMargin)
        ])
    }
    
    func setContentReview(name: String, review: String) {
        nameLabel.text = name
        textReviewLabel.text = review
    }

}
