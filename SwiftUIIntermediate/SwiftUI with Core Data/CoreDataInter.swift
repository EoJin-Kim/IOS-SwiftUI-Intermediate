//
//  CoreDataInter.swift
//  SwiftUIIntermediate
//
//  Created by kej on 3/18/24.
//

import SwiftUI
import CoreData

class CoreDataInterViewModel: ObservableObject{
    let container: NSPersistentContainer
    
    @Published
    var savedEntites: [Fish] = []
    
    init() {
        self.container = NSPersistentContainer(name: "FishContainer")
        container.loadPersistentStores { (description, error) in
            if let error = error{
                print("ERROR LOADING CORE DATA. \(error)")
            }else{
                print("SUCCESSFULLY LOADED CORE DATA. \(description)")
            }
        }
        fetchFish()
    }
    
    func fetchFish(){
        let request = NSFetchRequest<Fish>(entityName: "Fish")
        do{
            savedEntites = try container.viewContext.fetch(request)
            
        }catch{
            print("ERROR FETCHING CORE DATA: \(error)")
        }
    }
    
    func saveData(){
        do{
            try container.viewContext.save()
            fetchFish()
        }catch{
            print("save error")
        }
    }
    
    func addFish(text: String){
        let newFish = Fish(context: container.viewContext)
        newFish.name = text
        saveData()
    }
    
    func deleteFish(indexSet: IndexSet){
        guard let index = indexSet.first else { return }
        
        let entity = savedEntites[index]
        
        container.viewContext.delete(entity)
        saveData()
    }
    
    func updateFish(fish: Fish){
        let currentName = fish.name ?? ""
        
        let newName = currentName + "~"
        
        fish.name = newName
        saveData()
    }
}

struct CoreDataInter: View {
    
    @StateObject
    var vm = CoreDataInterViewModel()
    @State
    var textFieldText: String = ""
    
    var body: some View {
        NavigationStack{
            VStack(spacing: 20){
                TextField("새로운 생선을 입력하세요", text: $textFieldText)
                    .font(.headline)
                    .padding(.leading)
                    .frame(maxWidth: .infinity)
                    .frame(height: 80)
                    .background(.gray.opacity(0.2))
                    .cornerRadius(10)
                    .padding()
                
                Button(
                    action: {
                        guard !textFieldText.isEmpty else { return }
                        vm.addFish(text: textFieldText)
                        textFieldText = ""
                    },
                    label: {
                        Text("추가하기")
                            .withDefaultButtonFormat(backgroundColor: .green)
                    }
                )
                List{
                    ForEach(vm.savedEntites){ fish in
                        Text(fish.name ?? "이름 없음")
                            .onTapGesture {
                                vm.updateFish(fish: fish)
                            }
                    }.onDelete(perform: vm.deleteFish)
                    
                }//: List
        
                .listStyle(.plain)
            }//: VStack
            .navigationTitle("Fish Market")
        }//: NavigationView
    }
}

#Preview {
    CoreDataInter()
}
