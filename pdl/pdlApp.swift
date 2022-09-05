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
    @StateObject private var networkManager = NetworkManager()
    @StateObject private var firebaseManager = FirebaseManager()
    
    init() {
        let center = UNUserNotificationCenter.current()
        center.delegate = notifDelegate
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(firebaseManager)
                .environmentObject(networkManager)
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
