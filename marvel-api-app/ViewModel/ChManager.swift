//
//  HomeViewModel.swift
//  marvel-api-app
//
//  Created by KimJongHee on 2022/05/31.
//

import Foundation
import Combine
import CryptoKit

class ChManager: ObservableObject {
    
    @Published var title: String = "-"
    @Published var id: Int = 0
    
    @Published var charaterData = [Character]()
    
    
    // https://gateway.marvel.com:443/v1/public/characters?apikey=443904aea2fa9b610e8600d614904bff&hash=ffd275c5130566a2916217b101f26150
    // http://gateway.marvel.com/v1/public/comics?ts=1&apikey=443904aea2fa9b610e8600d614904bff&hash=0dae0525214a76bbb8ce988812d330a26afadbec
    
    
    func fetchCharater() {
        
        let publicKey = "443904aea2fa9b610e8600d614904bff"
        let privateKey = "0dae0525214a76bbb8ce988812d330a26afadbec"
        // ts=1654083745.121179&
// http://gateway.marvel.com/v1/public/comics?ts=1&apikey=1234&hash=ffd275c5130566a2916217b101f26150
        
        let ts = String(Date().timeIntervalSince1970)
        let hash = MD5(data: "\(ts)\(privateKey)\(publicKey)")
        
        
        let url = "http://gateway.marvel.com/v1/public/comics?ts=\(ts)&apikey=\(publicKey)&hash=\(hash)"
        print(url)
        
        let session = URLSession(configuration: .default)
        session.dataTask(with: URL(string: url)!) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let APIData = data else {
                return
            }
            do {
                let result = try JSONDecoder().decode(Character.self, from: APIData)
                DispatchQueue.main.async {
                    self.id = result.id
                    self.title = result.name
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        
    }
    
    func MD5(data: String) -> String {
        let hash = Insecure.MD5.hash(data: data.data(using: .utf8) ?? Data())
        
        return hash.map{
            String(format: "%02hhx", $0)
        }
        .joined()
    }

    
    
}
