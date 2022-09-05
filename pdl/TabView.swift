//
//  TabView.swift
//  pdl
//
//

import SwiftUI

struct MainView: View {
    @State private var selectedView = 1
    @State private var showAlert = false
    @EnvironmentObject var firebaseManager: FirebaseManager
    @EnvironmentObject var networkManager: NetworkManager
    
    var body: some View {
        NavigationView {
            ZStack {
                TabView(selection: $selectedView) {
                    
                    CalculatorView().navigationTitle("").navigationBarHidden(true)
                        .tabItem {
                            Image(systemName: "apps.iphone")
                                .font(.system(size: 29))
                                .foregroundColor(Color(hex: "BDBDBD"))
                            Text("Calculator")
                        }.tag(0).statusBar(hidden: true)
                    
                    if firebaseManager.isShowLoan {
                        CreateRequestView().navigationTitle("").navigationBarHidden(true)
                            .tabItem {
                                Image(systemName: "dollarsign.square")
                                    .font(.system(size: 29))
                                    .foregroundColor(Color(hex: "BDBDBD"))
                                Text("Loan")
                            }.tag(1).statusBar(hidden: true)
                    }
                    CurrencyView().navigationTitle("").navigationBarHidden(true)
                        .tabItem {
                            if #available(iOS 15.0, *) {
                                Image(systemName: "digitalcrown.arrow.clockwise")
                                    .font(.system(size: 29))
                                    .foregroundColor(Color(hex: "BDBDBD"))
                            } else {
                                Image("digitalcrown")
                                    .renderingMode(.template)
                                    .foregroundColor(Color(hex: "34CB81"))
                            }
                            Text("Currency")
                        }.tag(2).statusBar(hidden: true)
                    
                    ReminderView().navigationTitle("").navigationBarHidden(true)
                        .tabItem {
                            Image(systemName: "deskclock")
                                .font(.system(size: 29))
                                .foregroundColor(Color(hex: "BDBDBD"))
                            Text("Reminder")
                        }.tag(3).statusBar(hidden: true)
                    
                }
                .preferredColorScheme(.light)
                .alert(isPresented: $networkManager.isShowAlert) {
                    
                    Alert(
                        title: Text("Please check your internet connection"),
                        primaryButton: .default(
                            Text("Retry"),
                            action: {
                                firebaseManager.checkRemoteConfig()
                            }
                        ),
                        secondaryButton: .cancel()
                    )
                }
                .onChange(of: networkManager.isShowAlert, perform: { newValue in
                    print(networkManager.isShowAlert)
                    if newValue == false {
                        firebaseManager.checkRemoteConfig()
                    }
                })
                .onAppear {
                    print(networkManager.isShowAlert)
                    if #available(iOS 13.0, *) {
                        let tabBarAppearance: UITabBarAppearance = UITabBarAppearance()
                        tabBarAppearance.configureWithDefaultBackground()
                        UITabBar.appearance().standardAppearance = tabBarAppearance
                        if #available(iOS 15.0, *) {
                            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
                        }
                    }
                    
                }
                .accentColor(Color(hex: "#34CB81"))
                
                
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
