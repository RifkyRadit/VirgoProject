//
//  ContentMovieDetailView.swift
//  VirgoProject
//
//  Created by Administrator on 24/05/22.
//

import Foundation
import UIKit

protocol ContentMovieDetailViewInput: AnyObject {
    func addContentMovieDetail(overviewText: String, releaseDateText: String)
}

class ContentMovieDetailView: UIView {
    
    lazy var overviewLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var overviewDetailLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var releaseDateLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var releaseDateDetailLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        addSubview(overviewLabel)
        addSubview(overviewDetailLabel)
        addSubview(releaseDateLabel)
        addSubview(releaseDateDetailLabel)
        
        overviewLabel.text = "Overview"
        releaseDateLabel.text = "Release date"
    }
    
    func setupLayouts() {
        NSLayoutConstraint.activate([
            overviewLabel.topAnchor.constraint(equalTo: topAnchor),
            overviewLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            overviewLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            overviewDetailLabel.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: Margin.minimumMargin),
            overviewDetailLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            overviewDetailLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            releaseDateLabel.topAnchor.constraint(equalTo: overviewDetailLabel.bottomAnchor, constant: Margin.mainMargin),
            releaseDateLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            releaseDateLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            releaseDateDetailLabel.topAnchor.constraint(equalTo: releaseDateLabel.bottomAnchor, constant: Margin.minimumMargin),
            releaseDateDetailLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            releaseDateDetailLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            releaseDateDetailLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

extension ContentMovieDetailView: ContentMovieDetailViewInput {
    func addContentMovieDetail(overviewText: String, releaseDateText: String) {

        overviewDetailLabel.text = !overviewText.isEmpty ? overviewText : "Overview Not Found"
        releaseDateDetailLabel.text = !releaseDateText.isEmpty ? releaseDateText : "Release Date Not Found"
    }
}
