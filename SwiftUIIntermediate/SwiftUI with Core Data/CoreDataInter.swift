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
    var savedEntites: [FishContainer] = []
    
    init() {
        self.container = NSPersistentContainer(name: "FishContainer")
        container.loadPersistentStores { (description, error) in
            if let error = error{
                print("ERROR LOADING CORE DATA. \(error)")
            }else{
                print("SUCCESSFULLY LOADED CORE DATA. \(description)")
            }
        }
    }
    
    private func fetchFish(){
        let request = NSFetchRequest<Fish>(NSFetchRequest(entityName: "Fish"))
    }
}

struct CoreDataInter: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    CoreDataInter()
}
