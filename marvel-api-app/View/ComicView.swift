//
//  MyCharacterView.swift
//  marvel-api-app
//
//  Created by KimJongHee on 2022/06/02.
//

import SwiftUI
import SDWebImageSwiftUI

struct ComicView: View {
    
    @EnvironmentObject var homeData: CharacterManager
    
    var body: some View {
        
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                if homeData.fecthComicData.isEmpty {
                    ProgressView()
                        .padding()
                }
                else {
                    VStack {
                        ForEach(homeData.fecthComicData) { comic in
                            ComicRowView(characters: comic)
                        }
                        
                        if homeData.offset == homeData.fecthComicData.count {
                            ProgressView()
                                .padding(.vertical)
                                .onAppear() {
                                    print("new data fetching... fecthComicDataCount: \(homeData.fecthComicData.count), offset: \(homeData.offset)")
                                    homeData.fetchComic()
                                }
                        }
                        else {
                            GeometryReader { reader -> Color in
                                
                                let minY = reader.frame(in: .global).minY
                                
                                let height = UIScreen.main.bounds.height / 1.3
                                
                                if !homeData.fecthComicData.isEmpty && minY < height {
                                    print("last")
                                    DispatchQueue.main.async {
                                        homeData.offset = homeData.fecthComicData.count
                                    }
                                }
                                
                                return Color.clear
                            }
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

struct ComicView_Previews: PreviewProvider {
    static var previews: some View {
        ComicView()
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
                    Text(description)
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
        // ?????? data["path"] ?? "" ?????? ?????? path ????????? ????????? ????????? ????????? ?????? ?????????.
        let ext = data["extension"] ?? ""
        // ?????? ext = data["extension"] ?? "" ext ?????? ?????? data "extension" ????????? ????????? ????????? ?????? ?????????.
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
        // capitalized ??? ????????? ????????? ???????????? ?????? ????????? ???????????? ???????????? ????????????.
    }
    
    
}
