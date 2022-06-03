//
//  MyCharacterView.swift
//  marvel-api-app
//
//  Created by KimJongHee on 2022/06/02.
//

import SwiftUI
import SDWebImageSwiftUI

struct MyCharacterView: View {
    
    @EnvironmentObject var characterCardData: CharacterManager
    
    
    
    var body: some View {
        
        NavigationView {
            VStack {
                Text("Cards")
            }
            .navigationTitle("My Cards")
        }
    }
    
    
}

struct MyCharacterView_Previews: PreviewProvider {
    static var previews: some View {
        MyCharacterView()
    }
}
