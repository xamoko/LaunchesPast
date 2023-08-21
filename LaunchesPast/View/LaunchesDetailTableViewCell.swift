//
//  LaunchesDetailTableViewCell.swift
//  LaunchesPast
//
//  Created by Xavier Morales on 21/08/23.
//

import Foundation
import UIKit

class LaunchesDetailTableViewCell: UITableViewCell {
    
    lazy var launchLabel: UILabel = {
       let launchLabel = UILabel()
        return launchLabel
    }()
    
    lazy var siteName: UILabel = {
       let siteName = UILabel()
        return siteName
    }()
    
    lazy var launchDateLocal: UILabel = {
       let launchDateLocal = UILabel()
        return launchDateLocal
    }()
    
    lazy var imageLaunches: UIImageView = {
       let imageLaunches = UIImageView()
        return imageLaunches
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
           super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        launchLabel.translatesAutoresizingMaskIntoConstraints = false
        siteName.translatesAutoresizingMaskIntoConstraints = false
        launchDateLocal.translatesAutoresizingMaskIntoConstraints = false
        imageLaunches.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(launchLabel)
        addSubview(siteName)
        addSubview(launchDateLocal)
        addSubview(imageLaunches)
        
        NSLayoutConstraint.activate([
            launchLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            launchLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            launchLabel.bottomAnchor.constraint(equalTo: siteName.topAnchor, constant: -5),
            
            siteName.topAnchor.constraint(equalTo: launchLabel.bottomAnchor, constant: 5),
            siteName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            siteName.bottomAnchor.constraint(equalTo: launchDateLocal.topAnchor, constant: -5),
            
            launchDateLocal.topAnchor.constraint(equalTo: siteName.bottomAnchor, constant: 5),
            launchDateLocal.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            launchDateLocal.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),

            imageLaunches.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            imageLaunches.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            imageLaunches.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            imageLaunches.widthAnchor.constraint(equalToConstant: 60),
            imageLaunches.heightAnchor.constraint(equalToConstant: 80),

            launchLabel.leadingAnchor.constraint(equalTo: imageLaunches.trailingAnchor, constant: 20),
            siteName.leadingAnchor.constraint(equalTo: imageLaunches.trailingAnchor, constant: 20),
            launchDateLocal.leadingAnchor.constraint(equalTo: imageLaunches.trailingAnchor, constant: 20)

        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
