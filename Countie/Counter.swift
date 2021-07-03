//
//  Counter.swift
//  Countie
//
//  Created by Niccolo Granieri on 26/06/2021.
//

import Foundation

struct Counter: Identifiable, Codable {
    private(set) var id = UUID()
    var name = ""
    var count = 0
    var step = 1
    var button = "🔴"
    
    mutating func increment(by increase: Int) {
        self.count += increase
    }
}

class Elements: ObservableObject {
    
    @Published var counters = [Counter]() {
        didSet {
            let encoder = JSONEncoder()
            
            if let encoded = try?
                encoder.encode(counters) {
                UserDefaults.standard.set(encoded, forKey: "Counters")
            }
        }
    }
    
    init() {
        
        if let counters = UserDefaults.standard.data(forKey: "Counters")
        
        {
            let decoder = JSONDecoder()
            
            if let decoded = try?
                decoder.decode([Counter].self, from: counters) {
                self.counters = decoded
                return
            }
        }
        
        self.counters = []
    }
    
}
