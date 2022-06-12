//
//  ContentView.swift
//  marvel-api-app
//
//  Created by KimJongHee on 2022/05/31.
//

import SwiftUI
import SDWebImageSwiftUI


struct ContentView: View {
    
    @StateObject var homeData = CharacterManager()
    
    
    
    var body: some View {
        
        TabView {
            CharaterView()
                .tabItem {
                    Image(systemName: "person.3")
                    Text("Character")
                }
                .environmentObject(homeData)
            ComicView()
                .tabItem {
                    Image(systemName: "books.vertical")
                    Text("My Character")
                }
                .environmentObject(homeData)
            CharacterCard()
                .tabItem() {
                    Image(systemName: "creditcard")
                    Text("My Cards")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
