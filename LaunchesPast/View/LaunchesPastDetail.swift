//
//  LaunchesPastDetail.swift
//  LaunchesPast
//
//  Created by Xavier Morales on 21/08/23.
//

import Foundation
import UIKit
import Kingfisher

class LaunchesPastDetail: UIViewController {
    
    var titleLaunches:String? = ""
    var launchData: [String?] = []
    var launchDetails: LaunchesPast?
    var collectionview: UICollectionView!
    var cellId = "Cell"
    var x = 1
    
    lazy var successLaunchLabel: UILabel = {
        let reasonLabel = UILabel()
        reasonLabel.font = UIFont.boldSystemFont(ofSize: 20)
        reasonLabel.translatesAutoresizingMaskIntoConstraints = false
        return reasonLabel
    }()
    
    lazy var reasonLabel: UILabel = {
        let reasonLabel = UILabel()
        reasonLabel.font = UIFont.boldSystemFont(ofSize: 20)
        reasonLabel.numberOfLines = 3
        reasonLabel.textColor = .black
        reasonLabel.translatesAutoresizingMaskIntoConstraints = false
        return reasonLabel
    }()
    
    lazy var detailLabel: UILabel = {
        let detailLabel = UILabel()
        detailLabel.font = UIFont.systemFont(ofSize: 20)
        detailLabel.numberOfLines = 10
        detailLabel.textColor = .black
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        return detailLabel
    }()
    
    private let scrollView: UIScrollView = {
    let view = UIScrollView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = titleLaunches
        self.view.backgroundColor = .lightGray
        addElements()
        guard !launchData.isEmpty else {return}
        addCollectionView()
    }
    
    func addElements(){
        successLaunchLabel.text = launchDetails?.launchSuccess ?? false ? "Launch: Sucess" : "Launch: Failure"
        successLaunchLabel.textColor = launchDetails?.launchSuccess ?? false ? UIColor.green : UIColor.red
        
        let reasonLaunchFailure = launchDetails?.launchFailureDetails?.reason ?? "There's not reason"
        reasonLabel.text = "Reason: " + reasonLaunchFailure
        reasonLabel.isHidden = launchDetails?.launchSuccess ?? false ? true : false
        
        detailLabel.text = launchDetails?.details
        
        let image = UIImage(named: "youtube")
        let youtubeButton = UIButton(type: UIButton.ButtonType.custom)
        youtubeButton.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        youtubeButton.setImage(image, for: .normal)
        youtubeButton.translatesAutoresizingMaskIntoConstraints = false
        youtubeButton.addTarget(self, action: #selector(youtube), for: .touchUpInside)
        
        let imageWiki = UIImage(named: "wiki")
        let wikiButton = UIButton(type: UIButton.ButtonType.custom)
        wikiButton.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        wikiButton.setImage(imageWiki, for: .normal)
        wikiButton.translatesAutoresizingMaskIntoConstraints = false
        wikiButton.addTarget(self, action: #selector(infoWiki), for: .touchUpInside)
        
        scrollView.contentSize = CGSize.init(width: self.view.frame.width, height: self.view.frame.height + 200)
         scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        let isFlickerEmpty: CGFloat = launchData.isEmpty ? 20 : 250
        let margin20: CGFloat = 20
        
       view.addSubview(scrollView)
        scrollView.addSubview(successLaunchLabel)
        scrollView.addSubview(reasonLabel)
        scrollView.addSubview(detailLabel)
        scrollView.addSubview(youtubeButton)
        scrollView.addSubview(wikiButton)

        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            
            successLaunchLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
            successLaunchLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: margin20),
            
            reasonLabel.topAnchor.constraint(equalTo: successLaunchLabel.bottomAnchor, constant: 10),
            reasonLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: margin20),
            reasonLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -margin20),
            
            detailLabel.topAnchor.constraint(equalTo: reasonLabel.safeAreaLayoutGuide.bottomAnchor, constant: isFlickerEmpty),
            detailLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: margin20),
            detailLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -margin20),
            
            youtubeButton.topAnchor.constraint(equalTo: detailLabel.bottomAnchor, constant: 30),
            youtubeButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            youtubeButton.heightAnchor.constraint(equalToConstant: 30),
            youtubeButton.widthAnchor.constraint(equalToConstant: 170),
            youtubeButton.bottomAnchor.constraint(equalTo: detailLabel.bottomAnchor, constant: 200),
            
            wikiButton.topAnchor.constraint(equalTo: detailLabel.bottomAnchor, constant: 30),
            wikiButton.leadingAnchor.constraint(equalTo: youtubeButton.trailingAnchor, constant: margin20),
            wikiButton.heightAnchor.constraint(equalToConstant: 30),
            wikiButton.widthAnchor.constraint(equalToConstant: 170),
            wikiButton.bottomAnchor.constraint(equalTo: detailLabel.bottomAnchor, constant: 200)
        ])
    }
    
    @objc func youtube() {

        let storyboard : UIStoryboard = UIStoryboard(name: "YoutubePlayer", bundle: nil)
        let vc : youtubePlayerViewController = storyboard.instantiateViewController(withIdentifier: "YTPlayer") as! youtubePlayerViewController
        vc.youubeID = launchDetails?.links.youtubeId ?? ""

        let navigationController = UINavigationController(rootViewController: vc)
        
        self.present(navigationController, animated: true, completion: nil)
    }
    
    @objc func infoWiki() {
        let launchesDetail = LaunchesPastWebView()
        launchesDetail.wikiURL = launchDetails?.links.wikipedia ?? ""
        self.navigationController?.pushViewController(launchesDetail, animated: true)
    }
    
}
