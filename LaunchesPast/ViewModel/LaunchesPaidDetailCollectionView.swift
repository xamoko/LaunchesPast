//
//  LaunchesPaidDetailCollectionView.swift
//  LaunchesPast
//
//  Created by Xavier Morales on 22/08/23.
//

import Foundation
import UIKit
import Kingfisher

extension LaunchesPastDetail: UICollectionViewDataSource, UICollectionViewDelegate {

    func addCollectionView(){
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
            layout.itemSize = CGSize(width: view.frame.width, height: view.frame.height)
            layout.scrollDirection = .horizontal
        collectionview = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height), collectionViewLayout: layout)
        collectionview.dataSource = self
        collectionview.delegate = self
        collectionview.register(LaunchPastDetailCollecionCell.self, forCellWithReuseIdentifier: cellId)
        collectionview.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(collectionview)
       setTimer()
        
        NSLayoutConstraint.activate([
            collectionview.topAnchor.constraint(equalTo: successLaunchLabel.bottomAnchor, constant: 10),
            collectionview.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            collectionview.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            collectionview.bottomAnchor.constraint(equalTo: successLaunchLabel.bottomAnchor, constant: 200)
        ])
    }
    
    func setTimer() {
         let _ = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(autoScroll), userInfo: nil, repeats: true)
    }
    
    @objc func autoScroll() {
        if self.x < self.launchData.count {
          let indexPath = IndexPath(item: x, section: 0)
          self.collectionview.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
          self.x = self.x + 1
        }else{
          self.x = 0
          self.collectionview.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return launchData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! LaunchPastDetailCollecionCell
        
        let missionPatch:String = self.launchData[indexPath.row] ?? ""
        cell.showCaseImageView.contentMode = .scaleAspectFit
        cell.showCaseImageView.clipsToBounds = true
        if let urlImages = URL(string: missionPatch) {
            let imageResource = KF.ImageResource(downloadURL: urlImages, cacheKey: missionPatch)
            cell.showCaseImageView.kf.setImage(with: imageResource)
        } else {
            cell.showCaseImageView.image = UIImage(named: "noImage")
        }
        return cell
    }
    
}
