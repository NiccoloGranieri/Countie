//
//  Counter.swift
//  Countie
//
//  Created by Niccolo Granieri on 26/06/2021.
//

import Foundation

struct Counter: Identifiable, Codable {
    let id = UUID()
    var name = ""
}

class Elements: ObservableObject, Codable {
    enum CodingKeys: CodingKey {
        case counters
    }
    
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    
    @Published var counters = [Counter]()
    
    init() { }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        counters = try container.decode([Counter].self, forKey: .counters)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(counters, forKey: .counters)
    }
    
}
