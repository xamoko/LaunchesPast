//
//  LaunchesPastWebView.swift
//  LaunchesPast
//
//  Created by Xavier Morales on 22/08/23.
//

import Foundation
import UIKit
import WebKit

class LaunchesPastWebView: UIViewController, WKNavigationDelegate {
    
    var wikiURL: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        let webV    = WKWebView()
        webV.frame  = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        webV.load(NSURLRequest(url: NSURL(string: wikiURL)! as URL) as URLRequest)
        webV.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(webV)
        
        NSLayoutConstraint.activate([
            webV.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webV.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            webV.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            webV.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}
