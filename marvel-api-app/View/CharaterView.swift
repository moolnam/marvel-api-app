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
            ScrollView {
                VStack {
                    TextField("캐릭터 검색", text: $homeData.searchQueary)
                        .padding()
                    HStack {
                        TextField("캐릭터 검색 2", text: $homeData.searchButton)
                        Button(action: {
                            homeData.fetchButton(characterName: homeData.searchButton)
                        }, label: {
                            Text("캐릭터 검색")
                        })
                    }
                    
                    if let characters = homeData.fecthCharaterData {
                        if characters.isEmpty {
                            Text("No Character..")
                                .padding()
                        } else {
                            ForEach(characters) { data in
                                //                                Text(String(data.id))
                                Text(data.name)
                                //                                Text(data.description)
                            }
                        }
                    }
                    else {
                        
                        if homeData.searchQueary != "" {
                            
                        } else {
                            ProgressView()
                        }
                    }
                    Spacer()
                }
                .navigationTitle("Character")
            }
        }
    }
}

struct CharaterView_Previews: PreviewProvider {
    static var previews: some View {
        CharaterView()
    }
}
