//
//  CharacterCard.swift
//  marvel-api-app
//
//  Created by KimJongHee on 2022/06/03.
//

import SwiftUI

struct CharacterCard: View {
    
    let name: String
    
    var body: some View {
        VStack {
            Text(name)
        }
    }
}

struct CharacterCard_Previews: PreviewProvider {
    static var previews: some View {
        CharacterCard(name: "-")
    }
}
