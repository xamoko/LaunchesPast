//
//  youtubePlayerViewController.swift
//  LaunchesPast
//
//  Created by Xavier Morales on 22/08/23.
//

import Foundation
import UIKit
import YouTubeiOSPlayerHelper

class youtubePlayerViewController: UIViewController, YTPlayerViewDelegate {
    
    var youubeID: String = ""
    
    @IBOutlet var playerView: YTPlayerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .darkGray
        playerView.load(withVideoId: youubeID, playerVars: ["autoplay":1])
    }
    
    
}
