//
//  Alert.swift
//  SmallWorldTest
//
//  Created by shairjeel ahmed on 20/08/2023.
//

import Foundation

struct AlertItem {
    let title: String
    let message: String
    var dismissButton: String = "OK"
}

struct AlertContext {
    
    //MARK: - Network Alerts
    static let invalidData = AlertItem(title: "Server Error",
                                       message: "The Data Recieve from the server was invalid. Please contact support")
    
    static let invalidResponse = AlertItem(title: "Server Error",
                                           message: "Invalid response from the server. Please try again later or contact support")
    
    static let invalidURl = AlertItem(title: "Server Error",
                                      message: "There was an issue connecting to the server. If this persist, please contact support")
    
}


