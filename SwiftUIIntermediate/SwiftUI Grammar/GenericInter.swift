//
//  GenericInter.swift
//  SwiftUIIntermediate
//
//  Created by 김어진 on 3/17/24.
//

import SwiftUI

struct StringModel{
    let info: String?
    
    func removeInfo() -> StringModel {
        return StringModel(info: nil)
    }
}

struct BoolModel{
    let info: Bool?
    
    func removeInfo() -> BoolModel {
        return BoolModel(info: nil)
    }
}

struct GenericModel<T>{
    let info: T?
    
    func removeInfo() -> GenericModel{
        return GenericModel(info: nil)
    }
}

class GenericInterViewModel : ObservableObject{
    
    @Published
    var stringModel2 = StringModel(info: "HelloWorld")
    @Published
    var boolModel2 = BoolModel(info: true)
    
    @Published
    var genericStringModel = GenericModel<String>(info: "Heloo world")
    
    @Published
    var genericBoolModel = GenericModel<Bool>(info: true)
    
    func removeData(){
        self.stringModel2 = stringModel2.removeInfo()
        self.boolModel2 = boolModel2.removeInfo()
        
        self.genericStringModel = self.genericStringModel.removeInfo()
        self.genericBoolModel = self.genericBoolModel.removeInfo()
    }
}

struct GenericView<T: View>: View {
    let title: String
    let content: T
    
    var body: some View {
        VStack{
            Text(title)
            content
        } //:VSTACK
    }
}

struct GenericInter: View {
    
    @StateObject
    var vm = GenericInterViewModel()
    var body: some View {
        VStack(spacing: 20){
            VStack(spacing:10){
                GenericView(title: "GenericView", content: Text("new contents"))
                
                Text("1. 일반적인 반복되는 Model 예시")
                    .font(.title)
                
                Divider()
                
                Text(vm.stringModel2.info ?? "No DATA")
                Text(vm.boolModel2.info?.description ?? "No DATA")
                
                Divider()
                
                Text("2. generic 사용함")
                    .font(.title)
                Text(vm.genericStringModel.info ?? "No Data")
                Text(vm.genericBoolModel.info?.description ?? "No Data")
            } //:VSTACK
        } //:VSTACK
        .onTapGesture {
            vm.removeData()
        }
    }
}

#Preview {
    GenericInter()
}
