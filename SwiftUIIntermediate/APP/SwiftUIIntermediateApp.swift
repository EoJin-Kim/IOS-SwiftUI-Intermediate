//
//  SwiftUIIntermediateApp.swift
//  SwiftUIIntermediate
//
//  Created by 김어진 on 3/16/24.
//

import SwiftUI

@main
struct SwiftUIIntermediateApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            UIViewRepresentableInter()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
