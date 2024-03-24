//
//  ProfileViewModel.swift
//  MiniGithubApp
//
//  Created by Josue Lubaki on 2024-03-23.
//

import Foundation
import Alamofire
import Combine

enum GHError : Error {
    case invalidURL
    case invalidResponse
    case invalidData
}

class ProfileViewModel : ObservableObject {
    @Published var user : GithubUser? = nil
    
    init() {
        do {
            try getInfo()
        } catch GHError.invalidURL {
            print("invalid URL")
        } catch {
            print(error)
        }
    }
    
    let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    // First Approch
    private func getInfo() throws {
        let endpoint = "https://api.github.com/users/josue-lubaki"
        
        guard let url = URL(string: endpoint) else {
            throw GHError.invalidURL
        }
        
        AF.request(url, method: .get).responseDecodable(of: GithubUser.self, decoder : decoder) { response in
            switch response.result {
                case .success(let data) :
                    self.user = data
                case .failure(let error) :
                    if(error.responseCode == 404){
                        print("Not Found")
                        return
                    }
                
                    if(error.isResponseSerializationError) {
                        print("Serialization Error")
                        return
                    }
                
                    else { print(error) }
            }
        }
    }
    
    // Second Approch
//    private func getInfo() async throws -> GithubUser {
//        let endpoint = "https://api.github.com/users/josue-lubaki"
//        
//        guard let url = URL(string: endpoint) else {
//            throw GHError.invalidURL
//        }
//        
//        let (data, response) = try await URLSession.shared.data(from: url)
//        
//        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
//            throw GHError.invalidResponse
//        }
//        
//        do {
//            let decoder = JSONDecoder()
//            decoder.keyDecodingStrategy = .convertFromSnakeCase
//            return try decoder.decode(GithubUser.self, from: data)
//        } catch {
//            throw GHError.invalidData
//        }
//    }
}
