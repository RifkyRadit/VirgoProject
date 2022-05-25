//
//  TmdbDetailBaseViewController.swift
//  VirgoProject
//
//  Created by Administrator on 24/05/22.
//

import UIKit

class TmdbDetailBaseViewController: UIViewController, ErrorViewDelegate {
    
    private var heightImage: CGFloat = 0
    private var tableViewHeight: NSLayoutConstraint!
    
    lazy var indicatorView: UIActivityIndicatorView = {
        let indicator: UIActivityIndicatorView = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    lazy var errorView: ErrorView = {
        let errorView: ErrorView = ErrorView()
        errorView.delegate = self
        errorView.translatesAutoresizingMaskIntoConstraints = false
        return errorView
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView: UIScrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    lazy var contentView: UIView = {
        let view: UIView = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var movieImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var voteAverageView: VoteAverageView = {
        let view: VoteAverageView = VoteAverageView()
        view.backgroundColor = UIColor(named: "primary_color")
        view.layer.masksToBounds = true
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor(named: "tertiary_color")?.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var contentMovieDetailView: ContentMovieDetailView = {
        let view: ContentMovieDetailView = ContentMovieDetailView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var reviewLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        label.textColor = .white
        label.text = "Review"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableView: UITableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
//        tableView.tableFooterView = UIView(frame: .zero)
        tableView.isScrollEnabled = false
        return tableView
    }()
    
    open func actionRetryButton() { }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func setupViews() {
        view.backgroundColor = UIColor(named: "primary_color")
        
        view.addSubview(errorView)
        view.addSubview(indicatorView)
        
        contentView.addSubview(movieImageView)
        contentView.addSubview(voteAverageView)
        contentView.addSubview(contentMovieDetailView)
        contentView.addSubview(reviewLabel)
        contentView.addSubview(tableView)
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.bounces = false
        setupTableView()
    }
    
    func setupTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        tableView.isScrollEnabled = false
        tableView.allowsSelection = false
        
        tableViewHeight = tableView.heightAnchor.constraint(equalToConstant: 100)
        tableViewHeight.priority = UILayoutPriority(rawValue: 999)
        tableViewHeight.isActive = true
    }

    
    func setupLayouts() {
        NSLayoutConstraint.activate([
            indicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            errorView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            errorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
        ])
        
        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            movieImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            movieImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            movieImageView.heightAnchor.constraint(equalToConstant: self.heightImage)
        ])
        
        NSLayoutConstraint.activate([
            voteAverageView.topAnchor.constraint(equalTo: movieImageView.bottomAnchor),
            voteAverageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            voteAverageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            voteAverageView.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        NSLayoutConstraint.activate([
            contentMovieDetailView.topAnchor.constraint(equalTo: voteAverageView.bottomAnchor, constant: Margin.maximumMargin),
            contentMovieDetailView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Margin.mainMargin),
            contentMovieDetailView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Margin.mainMargin)
        ])
        
        NSLayoutConstraint.activate([
            reviewLabel.topAnchor.constraint(equalTo: contentMovieDetailView.bottomAnchor, constant: Margin.mainMargin),
            reviewLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Margin.mainMargin),
            reviewLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Margin.mainMargin)
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: reviewLabel.bottomAnchor, constant: Margin.minimumMargin),
            tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Margin.mainMargin),
            tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Margin.mainMargin),
            tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            tableViewHeight
        ])
    }
    
    func setupHeightImage() {
        self.heightImage = (UIScreen.main.bounds.size.height - 74)/3
    }

    func didTapRetryButton() {
        actionRetryButton()
    }
    
    func setupStateView(state: StateView) {
        switch state {
        case .showIndicator:
            indicatorView.startAnimating()
            indicatorView.isHidden = false
            scrollView.isHidden = true
            errorView.isHidden = true
            
        case .showContent:
            scrollView.isHidden = false
            errorView.isHidden = true
            indicatorView.stopAnimating()
            
        case .showError:
            DispatchQueue.main.async {
                self.indicatorView.stopAnimating()
                self.indicatorView.isHidden = true
                self.errorView.isHidden = false
                self.scrollView.isHidden = true
            }
        }
    }
}
