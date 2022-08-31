//
//  ReminderCard.swift
//  pdl
//
//

import SwiftUI

struct ReminderCard: View {
    let title: String
    let date: String
    let hours: String
    let minute: String
    let daysLeft: Int
    
    let action: () -> Void
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                
                
                Text(title)
                    .font(.semibold22())
                    .foregroundColor(Color.white)
                    
                    Spacer()

                    Text(date)
                        .font(.regular16())
                        .foregroundColor(Color.white)

                    HStack {
                        Text(hours)
                            .font(.semibold30())
                            .foregroundColor(Color.white)
                        Text("hrs")
                            .font(.regular16())
                            .foregroundColor(Color.white)
                        Text(minute)
                            .font(.semibold30())
                            .foregroundColor(Color.white)
                        Text("min")
                            .font(.regular16())
                            .foregroundColor(Color.white)
                    }
                    
                }
                .padding(.vertical)
                Spacer()
                
                VStack {
                    HStack {
                        Spacer()
                Button {
                    print("Tap: Delete Card")
                    action()
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 22))
                        .foregroundColor(Color.white)
                }
                    }
                Spacer()
                    HStack {
                        Spacer()
                    VStack {
                        Text("\(daysLeft) days")
                            .font(.semibold22())
                            .foregroundColor(.white)
                        Text("left")
                            .font(.semibold22())
                            .foregroundColor(.white)
                    }
                    .padding(.bottom)
                    }
            }
            }
            

        }
        .padding()
        .frame(maxWidth: .infinity)
        .frame(height: 206)
        .background(BackgroundCard())
    }
}

//struct ReminderCard_Previews: PreviewProvider {
//    static var previews: some View {
//        ReminderCard(title: "Lodoofodffodkfodkfokdffdfsdsdsdsdsdsd", date: "Jul 29, 2022", hours: "05", minute: "00", daysLeft: 2)
//    }
//}
