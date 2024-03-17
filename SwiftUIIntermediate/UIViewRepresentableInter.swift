//
//  UIViewRepresentableInter.swift
//  SwiftUIIntermediate
//
//  Created by 김어진 on 3/18/24.
//

import SwiftUI


struct FirstUIViewRepresentable: UIViewRepresentable{
    
    
    
    // UIKit 의 UIView 을 생성하는 함수
    func makeUIView(context: Context) -> some UIView {
        let view = UIView()
        view.backgroundColor = .green
        return view
    }
    
    
    // UIKit 에 업데이트
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

struct UIViewRepresentableInter: View {
    var body: some View {
        VStack{
            Text("SWIFTUI")
            FirstUIViewRepresentable()
        } //:VSTACK
    }
}

#Preview {
    UIViewRepresentableInter()
}
