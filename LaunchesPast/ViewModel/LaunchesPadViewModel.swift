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
        let defaults = UserDefaults.standard
        
        let savedArray = defaults.object(forKey: "SavedArray") as! String
        guard savedArray.isEmpty else {

            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
              let launchesPastDatas: [LaunchesPast] = try decoder.decode([LaunchesPast].self, from: savedArray.data(using: .utf8) ?? Data())
              self.launchProtocolLaunchesPast?.launchGettingDatas(datas: launchesPastDatas)
              }
            catch let error {
                print(error)
            }
            
            return
        }
        
        AF.request(URLAPI, method: .get).response { response in
            let data = response.data
            guard let json: String = String(data: data ?? Data(), encoding: String.Encoding.utf8) else {
                return
            }
            do {
                defaults.set(json, forKey: "SavedArray")
                let savedArray = defaults.object(forKey: "SavedArray") as! String
                let decoder = JSONDecoder()
                  decoder.keyDecodingStrategy = .convertFromSnakeCase
                let launchesPastDatas: [LaunchesPast] = try decoder.decode([LaunchesPast].self, from: savedArray.data(using: .utf8) ?? Data())

                self.launchProtocolLaunchesPast?.launchGettingDatas(datas: launchesPastDatas)
                
            } catch let error {
                print(error)
            }
        }
    }
}
