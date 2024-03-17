//
//  ScrollViewReaterInter.swift
//  SwiftUIIntermediate
//
//  Created by 김어진 on 3/17/24.
//

import SwiftUI

struct ScrollViewReaterInter: View {
    
    @State
    var scrollToIndex: Int = 0
    @State
    var textFieldText: String = ""
    @State
    var showAlert: Bool = false
    
    var body: some View {
        VStack{
            
            TextField("이동할 박스 #번호를 입력하세요", text: $textFieldText)
                .font(.headline)
                .frame(height: 35)
                .background(Color.gray.opacity(0.2))
            
            Button(
                action: {
                    withAnimation(.spring){
                        let index = Int(textFieldText)
                        guard let index = Int(textFieldText) else {
                            return showAlert.toggle()
                        }
                        scrollToIndex = index
                    }
                },
                label: {
                    Text("이동하기")
                }
            )
            .alert(isPresented: $showAlert){
                Alert(title: Text("잘못된 입력"), message: Text("입력값을 다시 확인하세요"), dismissButton: .default(Text("창 닫기")))
            }
            ScrollView(.vertical, showsIndicators: false){
                ScrollViewReader{ proxy in
                    Button(
                        action: {
                            withAnimation(.spring()){
                                proxy.scrollTo(30, anchor: .bottom)
                            }
                        },
                        label: {
                            Text("여기를 클릭하면 30번 박스로 이동합니다")
                        }
                    )
                    ForEach(1..<51){ index in
                        Text("이 박스의 번호는 #\(index)번 입니다")
                            .font(.headline)
                            .frame(height: 200)
                            .frame(maxWidth: .infinity)
                            .background(Color.green)
                            .padding()
                        
                        // 각각의 index에 id 값을 주어서 proxy가 id 가 어디인지 알게하기 위한 id 설정
                            .id(index)
                        
                    } //:LOOP
                    .onChange(of: scrollToIndex){ newValue in
                        withAnimation(.spring) {
                            proxy.scrollTo(newValue, anchor: .top)
                        }
                    }
                }
            } //:SCROLL
        } //:VSTACK
    }
}

#Preview {
    ScrollViewReaterInter()
}
