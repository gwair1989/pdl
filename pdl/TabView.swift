//
//  TabView.swift
//  pdl
//
//

import SwiftUI

struct MainView: View {
    @State private var selectedView = 1
    @StateObject private var model: ViewModel = ViewModel()
    var body: some View {
        
        
        NavigationView {
            ZStack {
                
                TabView(selection: $selectedView) {
                    
                    CalculatorView().navigationTitle("").navigationBarHidden(true)
                        .environmentObject(model)
                        .tabItem {
                            Image(systemName: "apps.iphone")
                                .font(.system(size: 29))
                                .foregroundColor(Color(hex: "BDBDBD"))
                            Text("Calculator")
                        }.tag(0).statusBar(hidden: true)
                    
                    
                    CreateRequestView().navigationTitle("").navigationBarHidden(true)
                        .environmentObject(model)
                        .tabItem {
                            Image(systemName: "dollarsign.square")
                                .font(.system(size: 29))
                                .foregroundColor(Color(hex: "BDBDBD"))
                            Text("Loan")
                        }.tag(1).statusBar(hidden: true)
                    
                    CurrencyView().navigationTitle("").navigationBarHidden(true)
                        .environmentObject(model)
                        .tabItem {
                            Image(systemName: "digitalcrown.arrow.clockwise")
                                .font(.system(size: 29))
                                .foregroundColor(Color(hex: "BDBDBD"))
                            Text("Currency")
                        }.tag(2).statusBar(hidden: true)
                    
                    ReminderView().navigationTitle("").navigationBarHidden(true)
                        .environmentObject(model)
                        .tabItem {
                            Image(systemName: "deskclock")
                                .font(.system(size: 29))
                                .foregroundColor(Color(hex: "BDBDBD"))
                            Text("Reminder")
                        }.tag(3).statusBar(hidden: true)
                    
                }
                .preferredColorScheme(.light)
                .onAppear{
//                    UINavigationBar.appearance().backgroundColor = .clear
//                    UINavigationBar.appearance().isHidden = false
                    
                    
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
