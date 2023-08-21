//
//  NetworkConnectivity.swift
//  SmallWorldTest
//
//  Created by shairjeel ahmed on 21/08/2023.
//

import Foundation
import Alamofire

protocol NetworkReachabilityService {
    var isReachable: Bool { get }
}

class AlamofireNetworkReachabilityService: NetworkReachabilityService {
    private let reachabilityManager = NetworkReachabilityManager()
    
    var isReachable: Bool {
        return reachabilityManager?.isReachable ?? false
    }
}
