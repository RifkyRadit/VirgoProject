//
//  TabSegmentedControl.swift
//  VirgoProject
//
//  Created by Administrator on 24/05/22.
//

import UIKit

protocol TabSegmentedControlInput: AnyObject {
    func addCurrentIndex(index: Int)
}

protocol TabSegmentedControlDelegate: AnyObject {
    func changeViewWithIndex(index: Int)
}

class TabSegmentedControl: UISegmentedControl {

    weak var delegate: TabSegmentedControlDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    override init(items: [Any]?) {
        super.init(items: items)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupView()
    }
    
    func setupView() {
        let attributNormal = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
        let attributSelected = [NSAttributedString.Key.foregroundColor: UIColor(red: 1/255, green: 180/255, blue: 228/225, alpha: 1), NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)]
        
        setTitleTextAttributes(attributNormal, for: .normal)
        setTitleTextAttributes(attributSelected, for: .selected)
        
        let background = segmentedFillAndShape(color: UIColor(red: 13/255, green: 37/255, blue: 63/255, alpha: 1), size: self.bounds.size)
        setBackgroundImage(background, for: .normal, barMetrics: .default)
        setBackgroundImage(background, for: .selected, barMetrics: .default)
        setBackgroundImage(background, for: .highlighted, barMetrics: .default)
        
        setDividerImage(segmentedFillAndShape(color: .white, size: CGSize(width: 0, height: 0)), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        clipsToBounds = false
        
        self.addTarget(self, action: #selector(actionTabSegmented(_:)), for: .valueChanged)
    }
    
    func setupLayout() {
        
    }
    
    func segmentedFillAndShape(color: UIColor, size: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        let rectangle = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
        context?.fill(rectangle)
        
        let rectangleImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return rectangleImage ?? UIImage()
    }
    
    @objc
    func actionTabSegmented(_ sender: UISegmentedControl) {
        
        guard let delegate = delegate else {
            return
        }
        
        delegate.changeViewWithIndex(index: sender.selectedSegmentIndex)
    }
}

extension TabSegmentedControl: TabSegmentedControlInput {
    func addCurrentIndex(index: Int) {
        self.selectedSegmentIndex = index
        actionTabSegmented(self)
    }
}
