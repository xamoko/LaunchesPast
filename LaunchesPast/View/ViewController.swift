//
//  ViewController.swift
//  LaunchesPast
//
//  Created by Xavier Morales on 20/08/23.
//

import UIKit
import Kingfisher
import FirebaseAuth

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tableView: UITableView!
    var myCell: String = "myCell"
    var datasDelegate = LaunchesPadViewModel()
    var datasLaunches: [LaunchesPast] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        self.title = "Space X 🚀"
        self.navigationItem.setHidesBackButton(true, animated: true)
        manageNavigationbar()
        addTable()
        self.datasDelegate.gettingDatasLaunchesPast()
        self.datasDelegate.launchProtocolLaunchesPast = self
    }
    
    func manageNavigationbar(){
        let button = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.trash, target: self, action: #selector(signOut))
        navigationItem.rightBarButtonItem = button
    }
    
    @objc func signOut(){
        do {
            try Auth.auth().signOut()
            let VC = Authenticate()
            navigationController?.pushViewController(VC, animated: true)
        } catch {
            
        }
    }

    func addTable() {
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height))
        tableView.register(LaunchesDetailTableViewCell.self, forCellReuseIdentifier: myCell)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorColor = UIColor.clear
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .lightGray
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -10).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.datasLaunches.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: myCell, for: indexPath) as! LaunchesDetailTableViewCell
        
        cell.launchLabel.text = "\(self.datasLaunches[indexPath.row].missionName)"
        cell.siteName.text = "\(self.datasLaunches[indexPath.row].launchSite.siteName)"
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"

        let date: Date? = dateFormatterGet.date(from: self.datasLaunches[indexPath.row].launchDateLocal)
        
        cell.launchDateLocal.text = dateFormatter.string(from: date!)
        
        let missionPatch:String = self.datasLaunches[indexPath.row].links.missionPatch ?? ""
        
        if let urlImages = URL(string: missionPatch) {
            let imageResource = KF.ImageResource(downloadURL: urlImages, cacheKey: missionPatch)
            cell.imageLaunches.kf.setImage(with: imageResource)
        } else {
            cell.imageLaunches.image = UIImage(named: "noImage")
        }
        
        cell.accessoryType = .disclosureIndicator
        cell.tintColor = .black
        
        let margins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        let red = UIColor(red: 96.0/255.0, green: 96.0/255.0, blue: 96.0/255.0, alpha: 1.0)
        cell.backgroundColor = UIColor(red: 250.0/255.0, green: 250.0/255.0, blue: 250.0/255.0, alpha: 1)
        cell.layer.borderColor = red.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let launchesDetail = LaunchesPastDetail()
        launchesDetail.titleLaunches = "\(self.datasLaunches[indexPath.row].missionName)"
        let datasLaunch = self.datasLaunches[indexPath.row].links
        launchesDetail.launchData = self.datasLaunches[indexPath.row].links.flickrImages
        launchesDetail.launchDetails = self.datasLaunches[indexPath.row]
        self.navigationController?.pushViewController(launchesDetail, animated: true)
        
    }
}

extension ViewController: LaunchesPastProtocol {
    func launchGettingDatas(datas: [LaunchesPast]?) {
        DispatchQueue.main.async {
            self.datasLaunches = datas ?? []
            self.tableView.reloadData()
        }
    }
}
