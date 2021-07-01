//
//  MementoCaretaker.swift
//  Millionaire
//
//  Created by Ilya on 21.06.2021.
//

import Foundation

class Caretaker<T: Codable> {

    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private var key = "key"
    
    init(key: String) {
        self.key = key
    }

    func save(array: [T]) {
        do {
            let data = try encoder.encode(array)
            UserDefaults.standard.setValue(data, forKey: key)
        } catch {
            print(error.localizedDescription)
        }
    }

    func load() -> [T]? {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return nil
        }

        do {
            return try decoder.decode([T].self, from: data)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
