//
//  TypealiasInter.swift
//  SwiftUIIntermediate
//
//  Created by 김어진 on 3/17/24.
//

import SwiftUI

struct MovieModel {
    let title: String
    let director: String
    let count: Int
}

//struct TVModel {
//    let title: String
//    let director: String
//    let count: Int
//}
typealias TVModel = MovieModel

struct TypealiasInter: View {
    
    @State
    var item: MovieModel = MovieModel(title: "영화 제목", director: "Eojin", count: 10)
    @State
    var item2: TVModel = TVModel(title: "영화 제목2", director: "Eojin2", count: 120)
    var body: some View {
        VStack(spacing: 20){
            Text(item.title)
            Text(item.director)
            Text("\(item.count)")
            
            Divider()
            
            Text(item2.title)
            Text(item2.director)
            Text("\(item2.count)")
        } //:VSTACK
    }
}

#Preview {
    TypealiasInter()
}
