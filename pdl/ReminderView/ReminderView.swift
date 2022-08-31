//
//  ReminderView.swift
//  pdl
//
//

import SwiftUI

struct ReminderView: View {
    @State private var isShowAddReminderView: Bool = false
    @EnvironmentObject var model: ViewModel
    var body: some View {
        Background {
            VStack(spacing: 0) {
                HeaderView(step: nil, title: "Creat new reminder", imageSize: model.getWidthEqualScreen(52))
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 10) {
                        if !model.reminders.isEmpty {
                            ForEach(model.reminders) { reminder in
                                ReminderCard(title: reminder.title, date: model.getSeletedDay(date: reminder.date), hours: model.getSeletedHours(date: reminder.date), minute: model.getSeletedMinute(date: reminder.date), daysLeft: model.getDaysLeft(date: reminder.date), action: {
                                    model.removeReminder(uuid: reminder.id)
                                })
                                    .padding(.top)
                                    .padding(.horizontal)
                            }
                        }

                        AddReminder()
                        Spacer()
                    }
                }
            }
            .onAppear {
                model.removeOldReminder()
            }
        }
        .onAppear(
            perform: NotificationManager.instance.requestAuthorization
        )
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification), perform: { output in
            model.removeOldReminder()
            print("App open")
        })
        
        .background(Color(hex: "F7F7F7")
            .ignoresSafeArea(.all))

    }
    
    private func AddReminder() -> some View {
        VStack(alignment: .center) {
            VStack(spacing: 15) {
                Button {
                    print("Tap: Add reminder")
                    isShowAddReminderView.toggle()
                } label: {
                    Image(systemName: "plus.circle")
                        .font(.system(size: model.getWidthEqualScreen(31)))
                        .foregroundColor(Color(hex: "828282"))
                }
                .sheet(isPresented: $isShowAddReminderView) {
                    AddReminderView()
                }
                Text("Add reminder")
                    .font(.medium16())
                    .foregroundColor(Color(hex: "828282"))
                    .multilineTextAlignment(.center)
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 206)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .strokeBorder(style: StrokeStyle(lineWidth: 2, dash: [10])).foregroundColor(Color(hex: "828282")))
        .padding()
    }
    
}

struct ReminderView_Previews: PreviewProvider {
    static var previews: some View {
        ReminderView()
    }
}
