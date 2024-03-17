//
//  FuctionsInter.swift
//  SwiftUIIntermediate
//
//  Created by 김어진 on 3/16/24.
//

import SwiftUI


struct UserModel: Identifiable{
    let id: String = UUID().uuidString
    let name: String
    let points: Int
    let isChecked: Bool
}

class UserViewModel: ObservableObject{
    @Published
    var dataArray: [UserModel] = []
    
    @Published
    var fillteredArray: [UserModel] = []
    
    @Published
    var mappedArray: [String] = []
    
    func updateFilterArray(){
//        fillteredArray = dataArray.sorted{ (user1, user2) -> Bool in
//            return user1.points > user2.points
//        }
        
        
//        fillteredArray = dataArray.filter{ user -> Bool in
//            return user.points > 50
//        }
        
        mappedArray = dataArray.map{ user -> String in
            return user.name
        }
        
    }
    
    init(){
        getUsers()
        updateFilterArray()
    }
    
    func getUsers(){
        let user1 = UserModel(name: "철수", points: 88, isChecked: true)
        let user2 = UserModel(name: "민수", points: 88, isChecked: false)
        let user3 = UserModel(name: "영희", points: 21, isChecked: true)
        let user4 = UserModel(name: "곽수", points: 23, isChecked: false)
        let user5 = UserModel(name: "민지", points: 32, isChecked: false)
        let user6 = UserModel(name: "혜린", points: 54, isChecked: true)
        let user7 = UserModel(name: "유아", points: 62, isChecked: false)
        let user8 = UserModel(name: "함시", points: 623, isChecked: true)
        let user9 = UserModel(name: "다나", points: 23, isChecked: false)
        let user10 = UserModel(name: "마린", points: 231, isChecked: true)
        
        dataArray.append(contentsOf: [
            user1,
            user2,
            user3,
            user4,
            user5,
            user6,
            user7,
            user8,
            user9,
            user10,
        ])
                        
    }
}

struct FuctionsInter: View {
    
    @StateObject
    var vm: UserViewModel = UserViewModel()
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack(spacing:20){
                    ForEach(vm.fillteredArray){ user in
                        VStack(alignment: .leading){
                            Text(user.name)
                                .font(.headline)
                            HStack{
                                Text("점수: \(user.points)")
                                Spacer()
                                if(user.isChecked){
                                    Image(systemName: "checkmark.seal.fill")
                                }
                            } //:HSTACK
                        } //:VSTACK
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue.cornerRadius(10))
                        .padding()
                    } //:LOOP
                    
                    ForEach(vm.mappedArray, id: \.self){ name in
                        Text(name)
                    }
                } //:VSTACK
            }.navigationTitle("학생 시험 성적표")
        } //:NAVIGATION
    }
}

#Preview {
    FuctionsInter()
}
