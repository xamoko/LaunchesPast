//
//  ViewController.swift
//  LaunchesPast
//
//  Created by Xavier Morales on 20/08/23.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tableView: UITableView!
    var myCell: String = "myCell"
    var datasDelegate = LaunchesPadViewModel()
    var datasLaunches: [LaunchesPast] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Space X 🚀"
        addTable()
        self.datasDelegate.gettingDatasLaunchesPast()
        self.datasDelegate.launchProtocolLaunchesPast = self
    }

    func addTable() {
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height))
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: myCell)
        tableView.dataSource = self
        tableView.delegate = self
        //tableView.separatorColor = UIColor.clear
        tableView.backgroundColor = .red
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.datasLaunches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: myCell, for: indexPath)
        cell.textLabel?.text = "\(self.datasLaunches[indexPath.row].mission_name)"
        cell.accessoryType = .disclosureIndicator
        return cell
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

