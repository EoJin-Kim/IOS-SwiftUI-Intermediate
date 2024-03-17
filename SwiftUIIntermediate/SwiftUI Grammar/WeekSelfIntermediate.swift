//
//  WeekSelfIntermediate.swift
//  SwiftUIIntermediate
//
//  Created by 김어진 on 3/17/24.
//

import SwiftUI


class WeekSelfInterViewModel: ObservableObject{
    @Published
    var data: String? = nil
    
    init(){
        print("초기화 시작")
        let currentCount = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.set(currentCount + 1, forKey: "count")
        getData()
    }
    
    deinit{
        print("초기화 해제 시작")
        let currentCount = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.set(currentCount - 1, forKey: "count")
    }
    
    func getData(){
        
        
//        // Strong Reference 에시
//        DispatchQueue.main.asyncAfter(deadline: .now() + 100){
//            DispatchQueue.main.async{
//                self.data = "New DATA!"
//            }
//        }
        
        // Week Reference 예시
        DispatchQueue.main.asyncAfter(deadline: .now() + 100){ [ weak self ] in
            DispatchQueue.main.async{
                self?.data = "New DATA!"
            }
        }
    }
}

struct WeekSelfIntermediate: View {
    @AppStorage("count")
    var count: Int?
    
    
    var body: some View {
        NavigationView{
            NavigationLink("2번째 페이지로 이동"){
                WeekSelfIntermediate2()
            }
            .navigationTitle("1번째 페이지")
        } //:NAVIGATION
        .overlay(
            Text("\(count ?? 0)")
                .font(.largeTitle)
                .padding()
                .background(Color.green.cornerRadius(10))
                .padding()
            , alignment: Alignment.topTrailing
        )
    }
}

struct WeekSelfIntermediate2: View{
    @StateObject
    var vm = WeekSelfInterViewModel()
    
    var body: some View{
        VStack{
            VStack{
                Text("2번째 페이지")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                if let data = vm.data{
                    Text(data)
                }
                
            } //:VSTACK
        }
    }
}

#Preview {
    WeekSelfIntermediate()
}
