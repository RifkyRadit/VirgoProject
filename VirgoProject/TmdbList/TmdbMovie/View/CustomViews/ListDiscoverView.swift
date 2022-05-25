//
//  ListDiscoverView.swift
//  VirgoProject
//
//  Created by Administrator on 24/05/22.
//

import Foundation
import UIKit

protocol ListDiscoverViewInput: AnyObject {
    func setContenListDiscover(withData data: [DiscoverMovieResult])
}

protocol ListDiscoverViewDelegate: AnyObject {
    func didSelectedDiscoverItem(withIndex index: Int)
}

class ListDiscoverView: UIView {
    
    weak var delegate: ListDiscoverViewDelegate?
    private var collectionHeight: CGFloat = 0
    
    private var listData: [DiscoverMovieResult] = [] {
        didSet {
            self.reloadData()
        }
    }
    
    lazy var titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var listCollectionView: UICollectionView = {
        let collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
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
        setHeightCollectionView()
        
        addSubview(titleLabel)
        addSubview(listCollectionView)
        
        titleLabel.text = "Discover"
        setupCollectionView()
    }
    
    func setupLayouts() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Margin.mainMargin),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Margin.mainMargin)
        ])
        
        NSLayoutConstraint.activate([
            listCollectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Margin.minimumMargin),
            listCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Margin.mainMargin),
            listCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Margin.mainMargin),
            listCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            listCollectionView.heightAnchor.constraint(equalToConstant: self.collectionHeight)
        ])
    }
    
    func setupCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        listCollectionView.backgroundColor = .clear
        listCollectionView.delegate = self
        listCollectionView.dataSource = self
        listCollectionView.collectionViewLayout = layout
        
        listCollectionView.register(UINib(nibName: "ItemCell", bundle: nil), forCellWithReuseIdentifier: "cell")
    }
    
    func setHeightCollectionView() {
        self.collectionHeight = (UIScreen.main.bounds.size.height - 64)/4
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.listCollectionView.reloadData()
        }
    }
}

extension ListDiscoverView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.listData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: ItemCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? ItemCell else {
            return UICollectionViewCell()
        }
        
        let urlPosterPath = [NetworkHelper.shared.baseUrlImage, self.listData[indexPath.row].posterPath ?? ""].joined()
        cell.setupImage(urlString: urlPosterPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let delegate = self.delegate else {
            return
        }
        
        delegate.didSelectedDiscoverItem(withIndex: indexPath.row)
    }
    
}

extension ListDiscoverView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height = collectionView.frame.size.height
        return CGSize(width:(collectionView.bounds.width - 8)/3, height: height)
    }
}

extension ListDiscoverView: ListDiscoverViewInput {
    func setContenListDiscover(withData data: [DiscoverMovieResult]) {
        self.listData = data
    }
}
