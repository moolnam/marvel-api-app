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
    
    @Published var fecthCharaterData: [Character]? = nil
    @Published var fecthComicData: [Comic]? = nil
    @Published var searchQueary = ""
    @Published var searchButton = ""
    
    var searchCancellable: AnyCancellable? = nil
    
    
    func fetchCharater() {
        
        let publicKey = "443904aea2fa9b610e8600d614904bff"
        let privateKey = "0dae0525214a76bbb8ce988812d330a26afadbec"
        
        let ts = String(Date().timeIntervalSince1970)
        let hash = MD5(data: "\(ts)\(privateKey)\(publicKey)")
        let originalQueary =  searchQueary.replacingOccurrences(of: " ", with: "%20")
        
        let urlString = "https://gateway.marvel.com:443/v1/public/characters?nameStartsWith=\(originalQueary)&ts=\(ts)&apikey=\(publicKey)&hash=\(hash)"
        
        
        guard let url = URL(string: urlString) else {
            print("url error")
            return
        }
        print(urlString)
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
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
                print("catch error : \(error.localizedDescription)")
            }
        }
        task.resume()
        
    }
    
    func MD5(data: String) -> String {
        let hash = Insecure.MD5.hash(data: data.data(using: .utf8) ?? Data())
        
        return hash.map{
            String(format: "%02hhx", $0)
        }
        .joined()
    }
    
    init() {
        searchCancellable = $searchQueary
            .removeDuplicates()
            .debounce(for: 0.6, scheduler: RunLoop.main)
            .sink(receiveValue: { str in
                if str == "" {
                    self.fecthCharaterData = nil
                }
                else {
                    self.fetchCharater()
                    print(str)
                }
            })
    }
    
    @Published var limitCount = 50
    
    
    func fetchComic() {
        let publicKey = "443904aea2fa9b610e8600d614904bff"
        let privateKey = "0dae0525214a76bbb8ce988812d330a26afadbec"
        
        
        var urlString = "https://gateway.marvel.com:443/v1/public/comics?limit=\(limitCount)&apikey=\(publicKey)"
        
        guard let url = URL(string: urlString) else {
            return
        }
        print(url)
        
        let task = URLSession.shared.dataTask(with: url) { data, respinse, error in
            if let error = error {
                print(error.localizedDescription)
            }
            
            
        }
        task.resume()
        
    }
    
    
    
}
