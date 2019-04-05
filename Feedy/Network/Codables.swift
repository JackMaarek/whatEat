//
//  Codables.swift
//  Feedy
//
//  Created by jack Maarek on 04/04/2019.
//  Copyright © 2019 jack Maarek. All rights reserved.
//

import Foundation

struct Recipes: Codable {
    let data: [Recipe]
}

struct Recipe: Codable {
    let name: String?
    let time: String?
    let number: String?
    let steps: [Step]?
    let ingredients: [Ingredient]?
    let image: String?
}

struct Step: Codable {
    let text: String?
}

struct Ingredient: Codable {
    let name: String?
    let category: String?
    let quantity: String?
}
