//
//  FetchRequestInter.swift
//  SwiftUIIntermediate
//
//  Created by kej on 3/18/24.
//

import SwiftUI

struct FetchRequestInter: View {
    @Environment(\.managedObjectContext) private var viewContext


    @FetchRequest(
        entity: FishEntity.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \FishEntity.name, ascending: true)]
    )
    var fishes: FetchedResults<FishEntity>
    
    @State
    var textField: String = ""

    var body: some View {
        NavigationStack{
            
            VStack(spacing: 20){
                
                TextField("새로운 생선을 입력하세요", text: $textField)
                    .font(.headline)
                    .padding(.leading)
                    .frame(maxWidth: .infinity)
                    .frame(height: 80)
                    .background(.gray.opacity(0.2))
                    .cornerRadius(10)
                    .padding()
                
                Button(
                    action: {
                        addItem()
                    },
                    label: {
                        Text("추가하기")
                    }
                ).withDefaultButtonFormat(backgroundColor: .green)
                
                List{
                    ForEach(fishes){ fish in
                        Text(fish.name ?? "")
                            .onTapGesture {
                                updateItem(fish: fish)
                            }
                    }
                    .onDelete(perform: deleteItems)
                }//: List
                .listStyle(.plain)
                .navigationTitle("Fish Market")
            }//: VStack
            


        }//: NavigationView
    }
    
    private func saveItem(){
        do {
            try viewContext.save()
        } catch {

            print("Unresolved error \(error)")
        }
    }

    private func addItem() {

        withAnimation {
            let newFish = FishEntity(context: viewContext)
            newFish.name = textField
            
            saveItem()
            
            textField = ""
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            guard let index = offsets.first else { return }
            
            let selectedFish = fishes[index]
            viewContext.delete(selectedFish)
            
            saveItem()
        }
    }
    
    private func updateItem(fish: FishEntity){
        withAnimation {
            guard let currentName = fish.name else { return }
            let newName = currentName + "~"
            fish.name = newName
            saveItem()
        }
    }
}



#Preview {
    FetchRequestInter()
}
