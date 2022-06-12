//
//  CardView.swift
//  marvel-api-app
//
//  Created by KimJongHee on 2022/06/12.
//

import SwiftUI
import SDWebImageSwiftUI

struct CardView: View {
    
    @EnvironmentObject var  homeData: CharacterManager
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                if homeData.fecthComicData.isEmpty {
                    VStack {
                        ProgressView()
                        Text("카드 찾는 중..")
                    }
                }
                else {
                    ForEach(homeData.fecthComicData) { data in
                        CardRowView(cards: data)
                    }
                    
                    if homeData.offset == homeData.fecthComicData.count {
                        ProgressView()
                            .onAppear() {
                                homeData.fetchComic()
                                print("\(homeData.offset), \(homeData.fecthComicData.count)")
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
            .navigationTitle("Cards")
        }
        .onAppear() {
            if homeData.fecthComicData.isEmpty {
                homeData.fetchComic()
            }
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}

struct CardRowView: View {
    
    var cards: Comic
    
    var body: some View {
        VStack {
            WebImage(url: extractImage(data: cards.thumbnail))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 150, alignment: .center)
                .cornerRadius(10)
            Text("\(cards.title)")
            if let description = cards.description {
                Text(description)
            }
            HStack {
                ForEach(cards.urls, id: \.self) { data in
                    NavigationLink(destination: {
                        WebView(url: extractURL(data: data))
                            .navigationTitle(extractURLType(data: data))
                    }, label: {
                        Text(extractURLType(data: data))
                    })
                }
            }
        }
        .padding()
    }
    
    func extractImage(data: [String: String]) -> URL {
        
        let path = data["path"] ?? ""
        let ext = data["extension"] ?? ""
        print("\(path).\(ext)")
        return URL(string: "\(path).\(ext)")!
    }
    
    func extractURL(data: [String: String]) -> URL {
        
        let url = data["url"] ?? ""
        return URL(string: url)!
    }
    
    func extractURLType(data: [String: String]) -> String {
        
        let type = data["type"] ?? ""
        return type.capitalized
    }
    
}
