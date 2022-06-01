//
//  ContentView.swift
//  marvel-api-app
//
//  Created by KimJongHee on 2022/05/31.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var chData = ChManager()
    @State var char: String = ""
    
    
    var body: some View {
        VStack {
            Text("\(chData.title)")
            Text("\(chData.id)")
            
            TextField("캐릭터 입력", text: $char)
            Button(action: {
                chData.fetchCharater()
            }, label: {
                Text("Button")
            })
        }
        
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
