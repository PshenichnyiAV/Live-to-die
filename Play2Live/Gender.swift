//
//  Gender.swift
//  Play2Live
//
//  Created by Алексей on 18.08.2022.
//

import UIKit

enum Gender: String, CaseIterable {
    case male = "Male"
    case female = "Female"
    
    var avarageAge: Int {
        switch self {
        case .male:
            return 70
        case .female:
            return 75
        }
    }
}
 

