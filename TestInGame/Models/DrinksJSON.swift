//
//  Drinks.swift
//  TestInGame
//
//  Created by Денис Ледовский on 29.03.2022.
//

import Foundation

struct DrinksResponse: Codable {

    let drinks: [Drinks]

}

struct Drinks: Codable {

    let strDrink: String
    let strDrinkThumb: String
    let idDrink: String

}
