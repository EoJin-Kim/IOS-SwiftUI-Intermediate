//
//  ViewBuilderInter.swift
//  SwiftUIIntermediate
//
//  Created by 김어진 on 3/17/24.
//

import SwiftUI

struct ViewBuilderInter: View {
    var body: some View {
        VStack{
            HeaderComponent(title: "일반적인 compoennt 사용", description: "Component 사용해서 사용되지 않는 것들은 Optional 처리해줌", iconName: "gear")
            HeaderComponent(title: "일반적인 compoennt 사용2", description: nil, iconName: nil)
            
            // 2. generic적용
//            HeaderGeneric(title: "Generic Component1", content: Text("genenric 사용해서 필요할때마다 사용"))
//            HeaderGeneric(title: "Generic Component2", content: Image(systemName: "camera"))
            
            //3 @ViewBuilder 사용하기
            HeaderGeneric(title: "@ViewBiulder Component") {
                HStack{
                    Text("ViewBuilder 사용해보기")
                    Image(systemName: "gear")
                }
            }
            
            // 4. ViewBuilder Custom 사용하기
            CustomHStack{
                Text("Hello")
                Text("Hello")
            }
            
        } //:VSTACK
    }
}

struct HeaderComponent: View {
    let title: String
    let description: String?
    let iconName: String?
    var body: some View {
        VStack{
            VStack(alignment: .leading){
                Text(title)
                    .font(.title)
                    .fontWeight(.semibold)
                
                if let description = description {
                    Text(description)
                        .font(.body)
                }
                
                if let iconName = iconName{
                    Image(systemName: iconName)
                }
                RoundedRectangle(cornerRadius: 5)
                    .frame(height: 2)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        }
    }
}

//2 제네릭 사용해서 컴포넌트 사용하기
struct HeaderGeneric<Content: View> : View {
    let title: String
    let content: Content
    
    // 3 Generic 을 좀더 확장해서 사용하기 -> ViewBuilder 사용하기
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack{
            VStack(alignment: .leading){
                Text(title)
                    .font(.title)
                    .fontWeight(.semibold)
                
                content
                
                RoundedRectangle(cornerRadius: 5)
                    .frame(height: 2)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        }
    }
}

// 4 ViewBulder Custom하기
struct CustomHStack<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    var body: some View {
        HStack{
            content
        }
    }
}

// 5. Local ViewBiulder 사용하기
struct LocalViewBuilder: View {
    
    enum ViewType {
        case one
        case two
        case three
    }
    
    let type: ViewType
    
    var body: some View {
        VStack{
            numberPlate
        }
    }
    
    @ViewBuilder private var numberPlate: some View{
        if type == .one{
            view1
        }else if type == .two{
            view2
        }else if type == .three{
            view3
        }
    }
    
    private var view1: some View{
        Text("Number 1")
    }
    
    private var view2: some View{
        Text("Number 2")
    }
    
    private var view3: some View{
        Text("Number 3")
    }
}

#Preview {
    ViewBuilderInter()
}

#Preview {
    LocalViewBuilder(type: .one)
}



