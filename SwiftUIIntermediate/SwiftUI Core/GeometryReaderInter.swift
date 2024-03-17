//
//  GeometryReaderInter.swift
//  SwiftUIIntermediate
//
//  Created by 김어진 on 3/17/24.
//

import SwiftUI

struct GeometryReaderInter: View {
    var body: some View {
        
        GeometryReader{ prox in
            HStack(spacing: 0){
                Rectangle()
                    .fill(Color.green)
//                    .frame(width: UIScreen.main.bounds.width * 0.6)
                    .frame(width: prox.size.width *  0.7)
                Rectangle()
                    .fill(Color.blue)
            }.ignoresSafeArea()
        }
    }
}

struct GeometryReaderInter2: View {
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false){
            HStack{
                ForEach(1..<11){ index in
                    GeometryReader{ prox in
                        Image("NZ\(index)")
                            .resizable()
                            .cornerRadius(10)
                            .scaledToFit()
                            .rotation3DEffect(
                                Angle(degrees: getPercentage(geo: prox) * 20),
                                axis: (x: 0.0, y: 1.0, z: 0.0)
                            )
                    }
                    .frame(width: 300, height: 300)
                    .padding()
                }
            } //:HSTACK
            
        } //:SCROLL
    }
    
    func getPercentage(geo : GeometryProxy) -> Double{
        
        // 스크린 값의 절반 값 설정
        let maxDistance = UIScreen.main.bounds.width / 2
        
        // frame(in: .global) 전체 screen 의 크기에서 사진 크기의 가운데 값 설정
        let currentX = geo.frame(in: .global).midX
        
        // return 값으로 사진 가운데 기준으로 right, left에 값을 다르게 설정
        return (1 - (currentX / maxDistance))
    }
}

#Preview {
    GeometryReaderInter()
}

#Preview {
    GeometryReaderInter2()
}
