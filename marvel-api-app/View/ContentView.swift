//
//  ContentView.swift
//  marvel-api-app
//
//  Created by KimJongHee on 2022/05/31.
//

import SwiftUI
import SDWebImageSwiftUI

struct ContentView: View {
    
    @StateObject var characterData = CharacterManager()
    
    
    
    var body: some View {
        
        TabView {
            CharaterView()
                .tabItem {
                    Text("Character")
                }
                .environmentObject(characterData)
            MyCharacterView()
                .tabItem {
                    Text("My Character")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
