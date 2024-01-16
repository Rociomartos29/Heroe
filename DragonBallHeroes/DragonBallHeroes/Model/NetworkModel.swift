//
//  NetworkModel.swift
//  DragonBallHeroes
//
//  Created by Rocio Martos on 14/1/24.
//

import Foundation
struct Details: Decodable {
    // Propiedades y métodos de la clase Details
}

enum CustomNetworkError: Error {
    case malformedURL
    case tokenNotFound
    // Agrega más casos según sea necesario
}

protocol CustomAPIClientProtocol {
    func loginUser(url: URL, username: String, password: String, completion: @escaping (Result<String, CustomNetworkError>) -> Void)
    func fetchData<T: Decodable>(url: URL, authToken: String, completion: @escaping (Result<T, CustomNetworkError>) -> Void)
    func fetchTransformations<T: Decodable>(url: URL, authToken: String, heroId: String, completion: @escaping (Result<T, CustomNetworkError>) -> Void)
}



final class CustomAPIClient: CustomAPIClientProtocol {
    func loginUser(url: URL, username: String, password: String, completion: @escaping (Result<String, CustomNetworkError>) -> Void) {
            // Implementa la lógica para la autenticación y llama al completion con el token o el error.
        }
        
        func fetchData<T: Decodable>(url: URL, authToken: String, completion: @escaping (Result<T, CustomNetworkError>) -> Void) {
            // Implementa la lógica para la obtención de datos y llama al completion con los datos o el error.
        }
        
        func fetchTransformations<T: Decodable>(url: URL, authToken: String, heroId: String, completion: @escaping (Result<T, CustomNetworkError>) -> Void) {
            // Implementa la lógica para la obtención de transformaciones y llama al completion con las transformaciones o el error.
        }
    }

final class NetworkModel {
    func login(user: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
            
        }
    static let shared = NetworkModel()
    func getDetails(id: Int, completion: @escaping (Details?, Error?) -> Void) {
        guard let url = URL(string: "https://dragonball.keepcoding.education/api/details/\(id)") else {
            completion(nil, NSError(domain: "Invalid URL", code: 0, userInfo: nil))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil, error)
                return
            }

            do {
                let details = try JSONDecoder().decode(Details.self, from: data)
                completion(details, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
    
    
    private var authToken: String?
    
    private let baseURL = URL(string: "https://dragonball.keepcoding.education")!
    
    private let customAPIClient: CustomAPIClientProtocol
    
    private init(customAPIClient: CustomAPIClientProtocol = CustomAPIClient()) {
        self.customAPIClient = customAPIClient
    }
    
    func loginUser(username: String, password: String, completion: @escaping (Result<String, CustomNetworkError>) -> Void) {
        let loginEndpoint = baseURL.appendingPathComponent("/api/auth/login")
        
        guard let loginURL = URL(string: loginEndpoint.absoluteString) else {
            completion(.failure(.malformedURL))
            return
        }
        
        customAPIClient.loginUser(url: loginURL, username: username, password: password) { [weak self] result in
            switch result {
            case let .success(token):
                self?.authToken = token
                completion(.success(token))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchHeroes(completion: @escaping (Result<[Heroe], CustomNetworkError>) -> Void) {
        let heroesEndpoint = baseURL.appendingPathComponent("/api/heroes/all")
        
        guard let heroesURL = URL(string: heroesEndpoint.absoluteString) else {
            completion(.failure(.malformedURL))
            return
        }
        
        guard let authToken = authToken else {
            completion(.failure(.tokenNotFound))
            return
        }
        
        customAPIClient.fetchData(url: heroesURL, authToken: authToken, completion: completion)
    }
    
    func fetchTransformations(forHero heroId: String, completion: @escaping (Result<[HeroeTransformation], CustomNetworkError>) -> Void) {
        let transformationsEndpoint = baseURL.appendingPathComponent("/api/heroes/transformations")
        
        guard let transformationsURL = URL(string: transformationsEndpoint.absoluteString) else {
            completion(.failure(.malformedURL))
            return
        }
        
        guard let authToken = authToken else {
            completion(.failure(.tokenNotFound))
            return
        }
        
        customAPIClient.fetchTransformations(url: transformationsURL, authToken: authToken, heroId: heroId, completion: completion)
    }
}
