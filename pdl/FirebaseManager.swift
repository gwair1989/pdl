//
//  FirebaseManager.swift
//  PaydayLoans
//
//

import Foundation
import FirebaseRemoteConfig


class FirebaseManager {
    
    static var isEnabled = false
    static var urlString = ""
    
    private var remoteConfig = RemoteConfig.remoteConfig()
    
    
    init() {
        checkRemoteConfig()
    }
    
    
    private func checkRemoteConfig() {
        let defaults: [String: NSObject] = [
            "isEnabled" : false as NSObject,
            "urlString" : "" as NSObject
        ]
        
        let setting = RemoteConfigSettings()
        setting.minimumFetchInterval = 0
        remoteConfig.configSettings = setting
        remoteConfig.setDefaults(defaults)
        remoteConfig.fetchAndActivate { status, error in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                if status != .error {
                    let isEnabled = self.remoteConfig.configValue(forKey: "isEnabled").boolValue
                    FirebaseManager.isEnabled = isEnabled
                    if let urlString = self.remoteConfig.configValue(forKey: "urlString").stringValue {
                        FirebaseManager.urlString = urlString
                    }
                    
                }
            }
        }
    }
}
