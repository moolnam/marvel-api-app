//
//  CharaterView.swift
//  marvel-api-app
//
//  Created by KimJongHee on 2022/06/02.
//

import SwiftUI

struct CharaterView: View {
    
    @EnvironmentObject var homeData: CharacterManager
    
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("캐릭터 검색", text: $homeData.searchQueary)
                    .padding()
                Spacer()
            }
            .navigationTitle("Character")
        }
    }
}

struct CharaterView_Previews: PreviewProvider {
    static var previews: some View {
        CharaterView()
    }
}
