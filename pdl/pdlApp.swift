//
//  pdlApp.swift
//  pdl
//
//

import SwiftUI
import FirebaseCore


class AppDelegate: NSObject, UIApplicationDelegate {
    
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}





@main
struct pdlApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    private var notifDelegate: NotificationManagerDelegate = NotificationManagerDelegate()

    init() {
        let center = UNUserNotificationCenter.current()
        center.delegate = notifDelegate
    }
    
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification), perform: { output in
                    print("App close")
                })
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification), perform: { output in
                    UIApplication.shared.applicationIconBadgeNumber = 0
                    print("App open")
                })
                    
        }
    }
}
