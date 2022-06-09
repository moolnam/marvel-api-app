//
//  MyCharacterView.swift
//  marvel-api-app
//
//  Created by KimJongHee on 2022/06/02.
//

import SwiftUI
import SDWebImageSwiftUI

struct MyCharacterView: View {
    
    @EnvironmentObject var homeData: CharacterManager
    
    var body: some View {
        
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                if homeData.fecthComicData.isEmpty {
                    ProgressView()
                }
                else {
                    VStack {
                        ForEach(homeData.fecthComicData) { comic in
                            ComicRowView(characters: comic)
                        }
                    }
                }
                
            }
            .navigationTitle("Comic Book")
        }
        .onAppear() {
            if homeData.fecthComicData.isEmpty {
                homeData.fetchComic()
            }
        }
    }
    
    
}

struct MyCharacterView_Previews: PreviewProvider {
    static var previews: some View {
        MyCharacterView()
    }
}

struct ComicRowView: View {
    
    var characters: Comic
    
    var body: some View {
        HStack() {
            WebImage(url: extractImage(data: characters.thumbnail))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 150, alignment: .center)
                .cornerRadius(10)
            VStack {
                Text(characters.title)
                    .font(.system(size: 30))
                if let description = characters.description {
                    Text(characters.description)
                }
                HStack {
                    ForEach(characters.urls, id: \.self) { data in
                        NavigationLink(destination: {
                            WebView(url: extractURL(data: data))
                                .navigationTitle(extractURLType(data: data))
                        }, label: {
                            Text(extractURLType(data: data))
                        })
                    }
                }
            }
        }
        .padding()
    }
    
    func extractImage(data: [String : String]) -> URL {
        let path = data["path"] ?? ""
        // 중요 data["path"] ?? "" 안에 있는 path 스트링 글자가 다르면 정보를 받지 못한다.
        let ext = data["extension"] ?? ""
        // 중요 ext = data["extension"] ?? "" ext 안에 있는 data "extension" 글자가 다르면 정보를 받지 못한다.
        print("\(path).\(ext)")
        return URL(string: "\(path).\(ext)")!
    }
    
    func extractURL(data: [String : String]) -> URL {
        let url = data["url"] ?? ""
        return URL(string: url)!
    }
    
    func extractURLType(data: [String : String]) -> String {
        let tpye = data["type"] ?? ""
        return tpye.capitalized
        // capitalized 은 첫번째 문자만 대문자가 되고 나머지 글자들은 소문자로 변경된다.
    }
    
    
}
