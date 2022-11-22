//
//  AddReminderView.swift
//  pdl
//
//

import SwiftUI

struct AddReminderView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var isShowCalenderView: Bool = false
    @State private var isRemember: Bool = true
    @State private var isShowPicker: Bool = false
    @State private var selection: Repeat = .Never
    @State private var titleReminder = ""
    @EnvironmentObject var model: ReminderViewModel
    
    @State private var date = Date()
    var body: some View {
        Background {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 25) {
                    topView()
                    Spacer()
                    DateForm()
                    
                    if isShowCalenderView {
                        CalendarView()
                    }
                    RemindView()
                    Spacer()
                    Spacer()
                }
            }
            
            
        }
        .padding()
        .background(Color.black.ignoresSafeArea(.all))
    }
    
    private func topView() -> some View {
        HStack {
            Button {
                print("Tap: Cancel")
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Cancel")
                    .font(.medium18())
                    .foregroundColor(Color(hex: "34CB81"))
            }
            Spacer()
            Text("Add")
                .font(.semibold22())
                .foregroundColor(.white)
            Spacer()
            Button {
                print("Tap: Save")
                if !titleReminder.isEmpty {
                    model.addReminder(reminder: Reminder(id: UUID(), date: date, isRemind: isRemember, isRepeat: selection, title: titleReminder))
                    presentationMode.wrappedValue.dismiss()
                }
            } label: {
                Text("Save")
                    .font(.medium18())
                    .foregroundColor(Color(hex: titleReminder.isEmpty ? "BDBDBD" : "34CB81"))
            }
        }
    }
    
    
    private func DateForm() -> some View {
        
        Text(model.getCurrentDay(date: date))
            .font(.medium18())
            .frame(maxWidth: .infinity)
            .onTapGesture {
                withAnimation {
                    isShowCalenderView.toggle()
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10).fill(Color(hex: "F5F8F9"))
                
            )
    }
    
    private func CalendarView() -> some View {
        DatePicker("", selection: $date, in: Date()...)
            .datePickerStyle(.graphical)
            .background(Color.white)
            .cornerRadius(20)
    }
    
    private func RemindView() -> some View {
        VStack {
            Toggle(isOn: $isRemember) {
                Text("Remind me on a day")
                    .font(.medium18())
                    .foregroundColor(.white)
            }
            .toggleStyle(SwitchToggleStyle(tint: .black))
            
            
            VStack(spacing: 10) {
                callPickerView()
                    .onTapGesture {
                        withAnimation {
                            isShowPicker.toggle()
                        }
                    }
                rechargeView
            }
            .padding(.top)
            
            if isShowPicker {
                pickerView
            }
        }
        .padding()
        .background(Color(hex: "34CB81"))
        .cornerRadius(10)
    }
    
    
    private var pickerView: some View {
        VStack {
            Group {
                Picker(selection: $selection) {
                    ForEach(Repeat.allCases, id: \.self) { value in
                        Text(value.localizedName)
                            .font(.medium18())
                            .foregroundColor(.white)
                            .tag(value)
                    }
                    .onChange(of: selection) { newValue in
                        withAnimation {
                            isShowPicker.toggle()
                        }
                    }
                } label: {
                    Text("Picker")
                }
                .pickerStyle(.inline)
            }
        }
    }
    
    
    private var rechargeView: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Recharge Type")
                .font(.regular16())
                .foregroundColor(.white)
            
            ZStack {
                TextField("", text: $titleReminder)
                    .placeholder(when: titleReminder.isEmpty) {
                        Text(verbatim: "Title")
                            .font(.medium18())
                            .foregroundColor(Color(hex: "BDBDBD"))
                    }
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                    .padding()
                    .background(Color(hex: "F5F8F9"))
                    .cornerRadius(5)
                    .foregroundColor(.black)
            }
        }
        .padding(.vertical)

    }
    
    private func callPickerView() -> some View {
        VStack(spacing: 8) {
            HStack {
                Text("Repeat")
                    .font(.regular16())
                    .foregroundColor(.white)
                Spacer()
            }
            ZStack {
                HStack {
                    Text(selection.localizedName)
                    Spacer()
                }
                HStack {
                    Spacer()
                    Image(systemName: "chevron.down")
                        .font(.system(size: 12))
                        .foregroundColor(Color(hex: "#172635"))
                }
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 10)
                .fill(Color(hex: "F5F8F9")))
        }
    }
}

struct AddReminderView_Previews: PreviewProvider {
    static var previews: some View {
        AddReminderView()
    }
}
