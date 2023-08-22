//
//  LaunchesPastStruct.swift
//  LaunchesPast
//
//  Created by Xavier Morales on 20/08/23.
//

import Foundation

struct LaunchesPast: Decodable {
    let flightNumber: Int
    let missionName: String
    let launchDateLocal: String
    let launchSuccess: Bool?
    let details: String?
    let launchSite: LaunchSite
    let links: Links
    let launchFailureDetails: LaunchFailureDetails?
}

struct LaunchSite: Decodable {
    let siteName: String
}

struct Links: Decodable {
    let missionPatch: String?
    let flickrImages: [String?]
    let youtubeId: String?
    let wikipedia: String?
}

struct LaunchFailureDetails: Decodable {
    let time: Int
    let reason: String
}
