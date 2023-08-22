//
//  LaunchPastDetailCollecionCell.swift
//  LaunchesPast
//
//  Created by Xavier Morales on 21/08/23.
//

import Foundation
import UIKit

class LaunchPastDetailCollecionCell: UICollectionViewCell {

    let showCaseImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()


    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
    }
    
    func addViews() {
        addSubview(showCaseImageView)
        NSLayoutConstraint.activate([
            showCaseImageView.topAnchor.constraint(equalTo: topAnchor),
            showCaseImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            showCaseImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            showCaseImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
