//
//  DoCatchTryThrowInter.swift
//  SwiftUIIntermediate
//
//  Created by 김어진 on 3/17/24.
//

import SwiftUI

class DoCatchTryThrowInterDataManager{
    let isActive: Bool = false
    
    func getTitle1() -> (title: String?, error: Error?){
        if isActive{
            return ("새로운 데이터 다운 완료", nil)
        }else{
            return (nil, URLError(.badURL))
        }
    }
    
    func getTitle2() -> Result<String, Error>{
        if isActive{
            return .success("새로운 데이터 완료")
        }else{
            return .failure(URLError(.badURL))
        }
    }
    
    func getTitle3() throws -> String {
        
        if isActive{
            return "새로운 데이터 다운 왈료"
        }else{
            throw URLError(.badURL)
        }
    }
    
    func getTitle4() throws -> String {
        
        if isActive{
            return "마지막 데이터 다운 왈료"
        }else{
            throw URLError(.badURL)
        }
    }
}

class DoCatchTryThrowInterViewModel: ObservableObject{
    @Published
    var text: String = "시작"
    
    let manager = DoCatchTryThrowInterDataManager()
    
    func fetchTitle1(){
        let returnedValue = manager.getTitle1()
        
        if let newTitle = returnedValue.title{
            self.text = newTitle
        }else if let error = returnedValue.error{
            self.text = error.localizedDescription
        }
        
    }
    
    func fetchTitle2(){
        let result = manager.getTitle2()
        
        switch result {
        case .success(let newTitle):
            self.text = newTitle
        case .failure(let error):
            self.text = error.localizedDescription
        }
    
    }

    func fetchTitle3(){
        do {
            let newTitle = try? manager.getTitle3()
            if let newTitle = newTitle{
                self.text = newTitle
            }
            
            
            let finalTitle = try manager.getTitle4()
            self.text = finalTitle
            
        } catch let error{
            self.text = error.localizedDescription
        }
        
    }
    
}

struct DoCatchTryThrowInter: View {
    
    @StateObject
    var vm = DoCatchTryThrowInterViewModel()
    
    
    var body: some View {
        Text(vm.text)
            .font(.title)
            .frame(width: 300, height: 300)
            .background(Color.green.cornerRadius(20))
            .onTapGesture {
//                vm.fetchTitle1()
//                vm.fetchTitle2()
                vm.fetchTitle3()
            }
    }
}

#Preview {
    DoCatchTryThrowInter()
}
