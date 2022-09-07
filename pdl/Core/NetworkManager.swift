//
//  NetworkManager.swift
//  pdl
//
//  Created by Oleksandr Khalypa on 04.09.2022.
//

import Foundation
import Network

class NetworkManager: ObservableObject {
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkManager")
    @Published var isShowAlert = false
    
    var imageName: String {
        return isShowAlert ? "wifi.slash" : "wifi"
    }
    
    var connectionDescription: String {
        if isShowAlert {
            return "Please check your internet connection!"
        } else {
            return "Internet connection looks good!"
        }
    }
    
    init() {
        getNetworkStatus()
    }
    
    func getNetworkStatus() {
        monitor.pathUpdateHandler = { path in
            print("Network Status: ", path.status)
            switch path.status {
            case .satisfied:
                DispatchQueue.main.async {
                    self.isShowAlert = false
                }
            case .unsatisfied:
                DispatchQueue.main.async {
                    self.isShowAlert = true
                }
            case .requiresConnection:
                DispatchQueue.main.async {
                    self.isShowAlert = true
                }
            @unknown default:
                print("Network Status default: ", path.status)
            }
            
        }
        monitor.start(queue: queue)
    }
}
