//
//  CharaterView.swift
//  marvel-api-app
//
//  Created by KimJongHee on 2022/06/02.
//

import SwiftUI
import SDWebImageSwiftUI

struct CharaterView: View {
    
    @EnvironmentObject var homeData: CharacterManager
    
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    TextField("캐릭터 검색", text: $homeData.searchQueary)
                    
                        .padding()
                    
                    
                    if let characters = homeData.fecthCharaterData {
                        if characters.isEmpty {
                            Text("No Character..")
                                .padding()
                        } else {
                            ForEach(characters) { data in
                                CharacterThumbnail(characters: data)
                            }
                        }
                    }
                    else {
                        
                        if homeData.searchQueary != "" {
                            ProgressView()
                        }
                    }
                    Spacer()
                }
                .navigationTitle("Character")
            }
        }
        .navigationTitle("Characters")
    }
}

struct CharaterView_Previews: PreviewProvider {
    static var previews: some View {
        CharaterView()
    }
}


struct CharacterThumbnail: View {
    
    var characters: Character
    
    var body: some View {
        VStack {
            Text(characters.name)
                .font(.system(size: 30))
            WebImage(url: extractImage(data: characters.thumbnail))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 150, alignment: .center)
            Text(characters.description)
        }
    }
    
    func extractImage(data: [String : String]) -> URL {
        let path = data["path"] ?? ""
        let ext = data["ext"] ?? ""
        return URL(string: "\(path).\(ext)")!
    }
}
