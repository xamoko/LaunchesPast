//
//  LaunchesPadViewModel.swift
//  LaunchesPast
//
//  Created by Xavier Morales on 20/08/23.
//

import Foundation
import Alamofire

protocol LaunchesPastProtocol: AnyObject {
    func launchGettingDatas(datas: [LaunchesPast]?)
}

class LaunchesPadViewModel {
    
    let URLAPI = "https://api.spacexdata.com/v3/launches/past"
    weak var launchProtocolLaunchesPast: LaunchesPastProtocol?
    
    func gettingDatasLaunchesPast(){
        AF.request(URLAPI, method: .get).response { response in
            let data = response.data
            guard let json: String = String(data: data ?? Data(), encoding: String.Encoding.utf8) else {
                return
            }
            do {
                let decoder = JSONDecoder()
                  decoder.keyDecodingStrategy = .convertFromSnakeCase
                let launchesPastDatas: [LaunchesPast] = try decoder.decode([LaunchesPast].self, from: json.data(using: .utf8) ?? Data())

                self.launchProtocolLaunchesPast?.launchGettingDatas(datas: launchesPastDatas)
                
            } catch let error {
                print(error)
            }
        }
    }
}
