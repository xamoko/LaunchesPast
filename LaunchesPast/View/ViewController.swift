//
//  ViewController.swift
//  LaunchesPast
//
//  Created by Xavier Morales on 20/08/23.
//

import UIKit
import Kingfisher

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tableView: UITableView!
    var myCell: String = "myCell"
    var datasDelegate = LaunchesPadViewModel()
    var datasLaunches: [LaunchesPast] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "Space X 🚀"
        addTable()
        self.datasDelegate.gettingDatasLaunchesPast()
        self.datasDelegate.launchProtocolLaunchesPast = self
    }

    func addTable() {
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height))
        tableView.register(LaunchesDetailTableViewCell.self, forCellReuseIdentifier: myCell)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorColor = UIColor.clear
        tableView.estimatedRowHeight = UITableView.automaticDimension
        
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.datasLaunches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: myCell, for: indexPath) as! LaunchesDetailTableViewCell
        
        cell.launchLabel.text = "\(self.datasLaunches[indexPath.row].mission_name)"
        cell.siteName.text = "\(self.datasLaunches[indexPath.row].launch_site.site_name)"
        cell.launchDateLocal.text = "\(self.datasLaunches[indexPath.row].launch_date_local)"
        
        let missionPatch:String = self.datasLaunches[indexPath.row].links.mission_patch ?? ""
        
        if let urlImages = URL(string: missionPatch) {
            let imageResource = KF.ImageResource(downloadURL: urlImages, cacheKey: missionPatch)
            cell.imageLaunches.kf.setImage(with: imageResource)
        } else {
            cell.imageLaunches.image = UIImage(named: "noImage")
        }
        
        cell.accessoryType = .disclosureIndicator
        
        let margins = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        
        let red = UIColor(red: 96.0/255.0, green: 96.0/255.0, blue: 96.0/255.0, alpha: 1.0)
        cell.backgroundColor = UIColor(red: 250.0/255.0, green: 250.0/255.0, blue: 250.0/255.0, alpha: 1)
        cell.layer.borderColor = red.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8
        cell.contentView.frame = cell.contentView.frame.inset(by: margins)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let launchesDetail = details()
        launchesDetail.titleLaunches = "\(self.datasLaunches[indexPath.row].mission_name)"
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
