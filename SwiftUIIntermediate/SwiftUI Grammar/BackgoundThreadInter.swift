//
//  BackgoundThreadInter.swift
//  SwiftUIIntermediate
//
//  Created by 김어진 on 3/16/24.
//

import SwiftUI


class BackgoundThreadViewModel: ObservableObject{
    @Published
    var dataArray: [String] = []
    
    
    func fetchData(){
        DispatchQueue.global().async{
            let newData = self.downloadData()
            
            DispatchQueue.main.async{
                self.dataArray = newData
            }
        }
    }
    
    func downloadData() -> [String] {
        var data: [String] = []
        
        for x in 0..<1000{
            data.append("\(x)")
        }
        
        return data
    }
}

struct BackgoundThreadInter: View {
    
    @StateObject var vm: BackgoundThreadViewModel = BackgoundThreadViewModel()
    var body: some View {
        ScrollView{
            VStack(spacing: 20){
                Text("데이터 로드")
                    .font(.title)
                    .onTapGesture {
                        vm.fetchData()
                    }
                
                ForEach(vm.dataArray, id:\.self){ item in
                    Text(item)
                        .font(.headline)
                        .foregroundColor(.red)
                }
            } //:VSTACK
        } //:SCROLL
    }
}

#Preview {
    BackgoundThreadInter()
}
