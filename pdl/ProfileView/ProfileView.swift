//
//  ProfileView.swift
//  pdl
//
//

import SwiftUI

struct ProfileView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State private var isShowBaseView: Bool = false
    @State private var selectedItem: BaseViewModel?
    
    var body: some View {
        BaseView(title: "Personal info") {
            mainCard()
        }
    }
    
    private func mainCard() -> some View {
        VStack(alignment: .leading) {
            ForEach(BaseViewModel.profileModels) { i in
                profileCard(title: i.titleView, image: i.titleImage) {
                    print("Tap: \(i.titleView)")
                    selectedItem = i
                    isShowBaseView.toggle()
                }
            }
            if let item = selectedItem {
                NavigationLink("", destination: ProfileSubView(model: item),
                               isActive: $isShowBaseView)
                
            }
        }
        .padding(.vertical)
        .padding()
        .background(BackgroundCard())
        .shadow(color: .black, radius: 5, x: 0, y: 0)
        .padding()
        
    }
    
    
    private func profileCard(title: String, image: String, action: @escaping ()->()) -> some View {
        VStack(alignment: .leading) {
            HStack {
                Button {
                    action()
                } label: {
                    Image(image)
                        .font(.system(size: 35))
                        .accentColor(.gray)
                        .foregroundColor(.white)
                }
                Text(title)
                    .font(.semibold18())
                    .foregroundColor(.white)
                
                Spacer()
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
    
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
