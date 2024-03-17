//
//  LocalNotificationInter.swift
//  SwiftUIIntermediate
//
//  Created by 김어진 on 3/17/24.
//

import SwiftUI
import UserNotifications

class NotificationManager {
    static let instance = NotificationManager()
    
    func requestAutorization() {
        let option: UNAuthorizationOptions = [.alert, .sound, .badge]
        
        UNUserNotificationCenter.current().requestAuthorization(options: option) { success, error in
            if let error = error{
                print("에러: \(error)")
            }else{
                print("성공")
            }
        }

    }
    
    func scheduleNotification(){
        
        let content = UNMutableNotificationContent()
        content.title = "Local Notifcation 테스트1"
        content.subtitle = "앱 알람 테스트 중입니다."
        content.sound = .default
        content.badge = NSNumber(value: UIApplication.shared.applicationIconBadgeNumber + 1)
        
        // 1. 시간 기준
        let timeTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
        
        
        // 2. 날짜 기준
        var dateComponents = DateComponents()
        dateComponents.hour = 20
        dateComponents.minute = 37
//        dateComponents.weekday = 1 // 1은 일요일이 되고 6은 금요일이 됨
        let calendarTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
//            trigger: calendarTrigger
            trigger: timeTrigger
        )
        
        UNUserNotificationCenter.current().add(request)
    }
    
    // 생성된 노티 cancel 하기
    func cancelNottification(){
        // panding notification 은 트리거 상에서 만족된 조건이 되어도 더이상 노티 되지 않게 하기
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        
        // 아이폰 상태바에있는 노티 없애기
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
}


struct LocalNotificationInter: View {
    
    @Environment(\.scenePhase)
    var scenePhase
    
    var body: some View {
        VStack(spacing: 40){
            Button(
                action: {
                    NotificationManager.instance.requestAutorization()
                }, label: {
                    Text("권한 요청하기")
                        .padding()
                        .foregroundColor(.black)
                        .background(Color.green)
                }
            )
            Button(
                action: {
                    NotificationManager.instance.scheduleNotification()
                }, label: {
                    Text("Time Notifiactioin")
                        .padding()
                        .foregroundColor(.black)
                        .background(Color.green)
                }
            )
            Button(
                action: {
                    NotificationManager.instance.scheduleNotification()
                }, label: {
                    Text("Calendar Notifiactioin")
                        .padding()
                        .foregroundColor(.black)
                        .background(Color.green)
                }
            )
            
            Button(
                action: {
                    NotificationManager.instance.cancelNottification()
                }, label: {
                    Text("Noti Cancel")
                        .padding()
                        .foregroundColor(.black)
                        .background(Color.green)
                }
            )
        } //:VSTACK
        .onChange(of: scenePhase) {newValue in
            if newValue == .active{
                UIApplication.shared.applicationIconBadgeNumber = 0
            }
        }
    }
}

#Preview {
    LocalNotificationInter()
}
