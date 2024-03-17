//
//  ViewModifierInter.swift
//  SwiftUIIntermediate
//
//  Created by 김어진 on 3/17/24.
//

import SwiftUI

//2. ViewModifier 만들기
struct DefaultButtonModifier: ViewModifier{
    
    let backgoundColor : Color
    
    func body(content: Content) -> some View {
        content
            .font(.title)
            .foregroundColor(.white)
            .frame(height: 60)
            .frame(maxWidth: .infinity)
            .background(backgoundColor)
            .cornerRadius(10)
            .shadow(radius: 10)
            .padding()
    }
}

struct ViewModifierInter: View {
    var body: some View {
        VStack(spacing: 20){
            
            // 1. 일반적인 버튼 만들기
            Button(
                action: {
                      
                },
                label: {
                    Text("ViewModifier 연습하기")
//                        .modifier(DefaultButtonModifier())
                        .withDefaultButtonFormat(backgroundColor: Color.green)
                }
            )
            
            Button(
                action: {
                      
                },
                label: {
                    Text("ViewModifier 연습하기")
                        .foregroundColor(.blue)
//                        .modifier(DefaultButtonModifier())
                        .withDefaultButtonFormat(backgroundColor: Color.yellow)
                }
            )
            
            Button(
                action: {
                      
                },
                label: {
                    Text("ViewModifier 연습하기")
//                        .modifier(DefaultButtonModifier())
                        .withDefaultButtonFormat(backgroundColor: Color.red)
                }
            )
        
        } //:VSTACK
    }
}

extension View {
    func withDefaultButtonFormat(backgroundColor: Color) -> some View{
        self.modifier(DefaultButtonModifier(backgoundColor: backgroundColor))
    }
}

#Preview {
    ViewModifierInter()
}
