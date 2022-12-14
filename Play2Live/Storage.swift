//
//  Storage.swift
//  Play2Live
//
//  Created by Алексей on 24.08.2022.
//

import RealmSwift

class RealmStorage {
   private let localRealm: Realm? = try? Realm()
    
    func save(data: UserData) {
        
        guard let localRealm = localRealm else {
            return
        }

        do {
            try localRealm.write{
                localRealm.add(data)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func load() -> UserData? {
        guard let localRealm = localRealm else {
            return nil
        }
        return localRealm.object(ofType: UserData.self, forPrimaryKey: 123)
    }
    
    func update(restTime: Int, goneTime: Int){ // входные параметры
        guard let localRealm = localRealm else { return }
        let data = localRealm.object(ofType: UserData.self, forPrimaryKey: 123)
        do {
            try localRealm.write{
                data?.goneTime = goneTime
                data?.restTime = restTime
            }
        } catch {
            print(error.localizedDescription)
        }
    }
 }
