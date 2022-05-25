//
//  TmdbDetailViewController.swift
//  VirgoProject
//
//  Created by Administrator on 24/05/22.
//

import UIKit

class TmdbDetailViewController: TmdbDetailBaseViewController {

    var presenter: ViewToPresenterDetailProtocol?
    var reviewIsEmpty: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = UIColor(named: "primary_color")
        navigationController?.navigationBar.tintColor = UIColor.white
        
        setupStateView(state: .showIndicator)
        setupHeightImage()
        setupViews()
        setupLayouts()
        presenter?.viewDidLoad()
        
        tableView.register(ReviewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        tableView.backgroundColor = .clear
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
    }
}

extension TmdbDetailViewController {
    func setupMovieImage(urlPath: String?) {
        
        let urlImage = [NetworkHelper.shared.baseUrlImage, urlPath ?? ""].joined()
        ImageDownloader.shared.setupImage(urlImage: urlImage, imageView: movieImageView)
    }
}

extension TmdbDetailViewController: PresenterToViewDetailProtocol {
    
    func onFetchSuccess(withData itemData: MovieDetailEntity) {
        setupStateView(state: .showContent)
        setupMovieImage(urlPath: itemData.backdropPath)
        contentMovieDetailView.addContentMovieDetail(overviewText: itemData.overview ?? "", releaseDateText: itemData.releaseDate ?? "")
    }
    
    func onFetchFailed() {
        setupStateView(state: .showError)
    }
    
    func onFetchReviewIsEmpty() {
        reviewIsEmpty = true
        tableView.reloadData()
    }
}

extension TmdbDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if reviewIsEmpty {
            return 1
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: ReviewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ReviewCell else {
            return UITableViewCell()
        }
        
        if reviewIsEmpty {
            cell.accountImageView.isHidden = true
            cell.nameLabel.text = "No Review Available"
            cell.textReviewLabel.text = ""
            
            return cell
        }
        
        return UITableViewCell()
    }
}
