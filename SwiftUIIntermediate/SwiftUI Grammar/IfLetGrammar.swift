//
//  IfLetGrammar.swift
//  SwiftUIIntermediate
//
//  Created by 김어진 on 3/16/24.
//

import SwiftUI

struct IfLetGrammar: View {
    
    @State
    var displayText: String? = nil
    @State
    var currentUserID: String? = nil
    
    
    var body: some View {
        NavigationView{
            VStack (spacing: 20){
                Text("Safe Code 연습하기")
//                Text(displayText)
//                    .font(.title)
                if let text = displayText { // displayText 가 nil 이 아닐때
                    Text(text)
                        .font(.title2)
                }else{
                    ProgressView()
                }
                Spacer()
            } //:VSTACK
            .navigationTitle("Optional 처리하기")
            .onAppear{
                loadData2()
            }
        } //:NAVIGATION
    }
    
    func loadData(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 3){
            if let userId = currentUserID{
                displayText = "데이터를 성공적으로 가져왔습니다.\n당신의 이름든\(userId)"
            }else{
                displayText = "Error, 로그인이 되지 않았습니다"
            }
        }
    }
    
    func loadData2(){
        guard let userID = currentUserID else {
            displayText = "Error, 로그인이 되지 않았습니다"
            return
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3){
            displayText = "데이터를 성공적으로 가져왔습니다.\n당신의 이름든\(userID)"
        }
    }
}

#Preview {
    IfLetGrammar()
}
