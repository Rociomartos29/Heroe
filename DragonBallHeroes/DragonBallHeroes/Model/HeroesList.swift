//
//  HeroesList.swift
//  DragonBallHeroes
//
//  Created by Rocio Martos on 14/1/24.
//

import Foundation
struct Heroe: Codable {
    let id: Int
    let name: String
    let description: String
    var imageURL: String?
}
struct HeroeTransformation: Codable {
    let name: String
    let photo: String?
    let id, description: String
}
extension HeroeTransformation: Hashable{}
extension Heroe: Hashable{}

class HeroesManager {
 
    static let shared = HeroesManager()

    init() {}

    func getHeroes(completion: @escaping ([Heroe]?, Error?) -> Void) {
        guard let url = URL(string: "https://dragonball.keepcoding.education/api/heros/all") else {
            completion(nil, NSError(domain: "Invalid URL", code: 0, userInfo: nil))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil, error)
                return
            }

            do {
                let heroes = try JSONDecoder().decode([Heroe].self, from: data)
                completion(heroes, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
}
