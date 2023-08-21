//
//  LaunchesPastStruct.swift
//  LaunchesPast
//
//  Created by Xavier Morales on 20/08/23.
//

import Foundation

struct LaunchesPast: Decodable {
    let flight_number: Int
    let mission_name: String
    let launch_date_local: String
    let launch_site: LaunchSite
    let links: Links
}

struct LaunchSite: Decodable {
    let site_name: String
}

struct Links: Decodable {
    let mission_patch: String?
}
