//
//  AccountViewController.swift
//  VirgoProject
//
//  Created by Administrator on 24/05/22.
//

import UIKit

class AccountViewController: UIViewController {

    lazy var contentView: UIView = {
        let view: UIView = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        label.textColor = .white
        label.text = "Rifky Radityatama"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.barTintColor = UIColor(named: "primary_color")
        navigationController?.navigationBar.tintColor = UIColor.white
        view.backgroundColor = UIColor(named: "primary_color")
        
        setupViews()
        setupLayouts()
    }
    
    func setupViews() {
        
        contentView.addSubview(accountImageView)
        contentView.addSubview(nameLabel)
        view.addSubview(contentView)
        
        setupContentView()
    }
    
    func setupLayouts() {
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Margin.mainMargin),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Margin.mainMargin)
        ])
        
        NSLayoutConstraint.activate([
            accountImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            accountImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Margin.mainMargin),
            accountImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24),
            accountImageView.widthAnchor.constraint(equalToConstant: 50),
            accountImageView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: accountImageView.trailingAnchor, constant: Margin.mainMargin),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Margin.mainMargin),
            nameLabel.centerYAnchor.constraint(equalTo: accountImageView.centerYAnchor)
        ])
    }
    
    func setupContentView() {
        contentView.backgroundColor = UIColor(named: "card_color")
        contentView.layer.cornerRadius = 13
        contentView.layer.shadowOffset = CGSize(width: 2, height: 2)
        contentView.layer.shadowRadius = 3
        contentView.layer.shadowOpacity = 0.3
        contentView.layer.masksToBounds = false
    }
}
