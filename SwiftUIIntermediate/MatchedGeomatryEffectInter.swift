//
//  MatchedGeomatryEffectInter.swift
//  SwiftUIIntermediate
//
//  Created by 김어진 on 3/17/24.
//

import SwiftUI

struct MatchedGeomatryEffectInter: View {
    
    @State
    private var isToggled: Bool = false
    
    @Namespace
    private var namespace
    
    var body: some View {
        VStack{
            if !isToggled{
                RoundedRectangle(cornerRadius: 20)
                    .matchedGeometryEffect(id: "rectangle", in: namespace)
                    .frame(width: 100, height: 100)
            }

            Spacer()
            if isToggled{
                RoundedRectangle(cornerRadius: 20)
                    .matchedGeometryEffect(id: "rectangle", in: namespace)
                    .frame(width: 300, height: 100)

            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.green)
        .onTapGesture {
            withAnimation {
                isToggled.toggle()
            }
        }
    }
}

struct MatchedGeomatryEffectInter2 : View {
    
    @Namespace
    private var namespace
    
    let categories: [String] = ["홈", "한식", "중식", "양식", "일식"]
    
    @State
    private var selectedItem: String = ""
    
    var body: some View {
        ScrollView{
            HStack{
                ForEach(categories, id:\.self){ item in
                    ZStack{
                        if selectedItem == item{
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.green)
                                .matchedGeometryEffect(id: "food_category", in: namespace)
                                .frame(width: 40, height: 2)
                                .offset(y: 15)
                            
                        }
                        
                        Text(item)
                            .foregroundColor(selectedItem == item ? .green : .black)
                    } //:ZSTACK
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .onTapGesture {
                        withAnimation(.spring()){
                            selectedItem = item
                        }
                    }
                    
                    
                } //:LOOP
            } //:VSTACK
        } //:SCROLL
    }
}

#Preview {
    MatchedGeomatryEffectInter()
}
#Preview {
    MatchedGeomatryEffectInter2()
}

