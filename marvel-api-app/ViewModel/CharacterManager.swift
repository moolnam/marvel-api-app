//
//  HomeViewModel.swift
//  marvel-api-app
//
//  Created by KimJongHee on 2022/05/31.
//

import Foundation
import Combine
import CryptoKit

class CharacterManager: ObservableObject {
    
    @Published var title: String = "-"
    @Published var id: Int = 0
    
    @Published var fecthCharaterData: [Character]? = nil
    @Published var searchQueary = ""
    
    var searchCancellable: AnyCancellable? = nil
    
    init() {
        searchCancellable = $searchQueary
            .removeDuplicates()
            .debounce(for: 0.6, scheduler: RunLoop.main)
            .sink(receiveValue: { str in
                if str == "" {
                    
                } else {
                    self.fetchCharater()
                    print(str)
                }
            })
    }
    
    func fetchCharater() {
        
        let publicKey = "443904aea2fa9b610e8600d614904bff"
        let privateKey = "0dae0525214a76bbb8ce988812d330a26afadbec"
        
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
                let characters = try JSONDecoder().decode(APIResult.self, from: APIData)
                DispatchQueue.main.async {
                    if self.fecthCharaterData == nil {
                        self.fecthCharaterData = characters.data.results
                    }
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
