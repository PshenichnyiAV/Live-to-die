//
//  DataBase.swift
//  Play2Live
//
//  Created by Алексей on 24.08.2022.
//

import RealmSwift

class UserData : Object {
    
    @Persisted(primaryKey: true) var id = 123
    @Persisted var restTime: Int // осталось прожить
    @Persisted var goneTime: Int // прошло = age
    @Persisted var allTime: Int // все время
    
    convenience init(restTime: Int, goneTime: Int, gender: Gender, continent: Continent ){
        self.init()
        self.restTime = restTime
        self.goneTime = goneTime
        allTime = gender.avarageAge + continent.avarageContinentAge/3
        
    }
}
