//
//  DragGestureInter.swift
//  SwiftUIIntermediate
//
//  Created by 김어진 on 3/17/24.
//

import SwiftUI

struct DragGestureInter: View {
    
    @State var offset: CGSize = .zero
    var body: some View {
        ZStack{
            VStack{
                Text("\(offset.width)")
                Spacer()
            } //:VSTACK
            
            RoundedRectangle(cornerRadius: 20)
            .frame(width: 300, height: 500)
            .offset(offset)
            .scaleEffect(getScaleAmount())
            .gesture(
                DragGesture()
                    .onChanged({ value in
                        withAnimation(.spring){
                            offset = value.translation

                        }
                    })
                    .onEnded({ value in
                        withAnimation(.spring){
                            offset = .zero

                        }
                    })
            )
        } //:ZSTACK
    }
    
    func getScaleAmount() -> CGFloat {
        let max = UIScreen.main.bounds.width / 2
        
        let currentAmount = abs(offset.width)
        let percentage = currentAmount / max
        
        return 1.0 - min(percentage, 0.8)
    }
}

struct DragGestureInter2: View {
    
    @State
    var startOffsetY: CGFloat = UIScreen.main.bounds.height * 0.8
    @State
    var currentDragOffsetY: CGFloat = 0
    @State
    var endingOffsetY: CGFloat = 0
    
    var body: some View {
        ZStack{
            FrontView()
            
            LoginView()
                .offset(y: startOffsetY)
                .offset(y: currentDragOffsetY)
                .offset(y: endingOffsetY)
                .gesture(
                    DragGesture()
                        .onChanged({ value in
                            withAnimation(.spring()){
                                currentDragOffsetY = value.translation.height
                            }
                        })
                        .onEnded({ value in
                            withAnimation(.spring()){
                                if currentDragOffsetY < -150 {
                                    endingOffsetY = -startOffsetY
                                }else if endingOffsetY != 0 && currentDragOffsetY > 150{
                                    endingOffsetY = 0
                                }
                                currentDragOffsetY = 0
                            }
                        })
                )
            Text("\(currentDragOffsetY)")
        } //:ZSTACK
    }
}


struct FrontView: View {
    var body: some View {
        VStack(spacing: 20){
            Text("SWfit wrold")
                .font(.title)
                .fontWeight(.semibold)
                .padding(.top, 70)
            Image(systemName: "swift")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            
            Text("Swift World  에 오신 여러분 환용합니다")
                .multilineTextAlignment(.center)
            
            Button(
                action: {

                },
                label: {
                    Text("게스트로 로그인 하기")
                        .foregroundColor(.white)
                        .font(.title2)
                        .padding()
                        .padding(.horizontal)
                        .background(Color.black.cornerRadius(10.0))
                }
            )
            
            Spacer()
        } //:VSTACK
        .frame(maxWidth: .infinity)
        .background(Color.green)
        .ignoresSafeArea()
    }
}

struct LoginView: View {
    @State
    private var id: String = ""
    @State
    private var password: String = ""
    
    var body: some View {

        VStack(spacing: 20){
            Image(systemName: "chevron.up")
                .padding(.top)
            
            Text("위로 드래그 해서 로그인 하깈")
                .font(.headline)
                .fontWeight(.semibold)
                .padding(.bottom)
            
            Text("Login")
                .font(.title)
                .padding()
            
            TextField("ID", text:  $id)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .padding(.horizontal)
            
            
            SecureField("Password", text: $password)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .padding(.horizontal)
            
            
            Button(
                action: {

                }, label: {
                    Text("로그인")
                        .font(.title)
                        .bold()
                        .foregroundColor(.white)
                        .padding()
                        .padding(.horizontal)
                        .background(Color.black.cornerRadius(10))
                }
            )
            Spacer()
            
            Text("아래로 드래그 해서 창 닫기")
                .padding(.bottom)
            Image(systemName: "chevron.down")
                .padding(.bottom)
        
        } //:VSTACK
        .background(Color.white)
    }
}
#Preview {
    DragGestureInter()
}
#Preview {
    DragGestureInter2()
}
