//
//  YoutubePlayer.swift
//  LaunchesPast
//
//  Created by Xavier Morales on 22/08/23.
//

import Foundation
import YouTubeiOSPlayerHelper

class YoutubePlayer:  UIViewController, YTPlayerViewDelegate {
    
    let videoPlayer: YTPlayerView!
    
    override func viewDidLoad() {

        let videoID = "https://www.youtube.com/watch?v=M7lc1UVf-VE"
    videoPlayer.loadVideoByURL(videoID, startSeconds: 0.0, suggestedQuality: .Small)
        videoPlayer.playVideo()
     videoPlayer.delegate = self
     self.view = videoPlayer

    }
    
}
