//
//  LaunchesPastDetail.swift
//  LaunchesPast
//
//  Created by Xavier Morales on 21/08/23.
//

import Foundation
import UIKit

class details: UIViewController {
    
    var titleLaunches:String? = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = titleLaunches
        
    }
}
