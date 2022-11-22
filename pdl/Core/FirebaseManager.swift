//
//  FirebaseManager.swift
//  PaydayLoans
//
//

import Foundation
import FirebaseRemoteConfig


class FirebaseManager: ObservableObject {
    
    @Published var isShowLoan = true
    @Published var isEnabled = true
    @Published var urlString = ""
    
    private var remoteConfig = RemoteConfig.remoteConfig()
    
    init() {
        checkRemoteConfig()
    }
    
    func checkRemoteConfig() {
        let defaults: [String: NSObject] = [
            "isShowLoan" : true as NSObject,
            "isEnabled" : true as NSObject,
            "urlString" : "" as NSObject
        ]
        
        let setting = RemoteConfigSettings()
        setting.minimumFetchInterval = 0
        remoteConfig.configSettings = setting
        remoteConfig.setDefaults(defaults)
        remoteConfig.fetchAndActivate { status, error in
            if error != nil {
                print("Error Remote Config: ", error!.localizedDescription)
            } else {
                if status != .error {
                    let isShowLoan = self.remoteConfig.configValue(forKey: "isShowLoan").boolValue
                    self.isShowLoan = isShowLoan
                    if isShowLoan {
                        let isEnabled = self.remoteConfig.configValue(forKey: "isEnabled").boolValue
                        self.isEnabled = isEnabled
                        if let urlString = self.remoteConfig.configValue(forKey: "urlString").stringValue {
                            self.urlString = urlString
                        }
                    }
                }
            }
        }
    }
}
