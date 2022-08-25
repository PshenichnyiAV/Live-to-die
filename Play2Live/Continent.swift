//
//  Continent.swift
//  Play2Live
//
//  Created by Алексей on 19.08.2022.
//

import UIKit

enum Continent: String, CaseIterable {
    case europe = "Europe"
    case northAmerica = "North Americca"
    case southAmerica = "South America"
    case africa = "Africa"
    case asia = "Asia"
    case australia = "Australia"
    
    var avarageContinentAge: Int {
        switch self {
        case .europe:
            return 78
        case .northAmerica:
            return 79
        case .southAmerica:
            return 75
        case .africa:
            return 60
        case .asia:
            return 73
        case .australia:
            return 78
        }
    }
}
