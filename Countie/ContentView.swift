//
//  ContentView.swift
//  Countie
//
//  Created by Niccolo Granieri on 26/06/2021.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var elements = Elements()
    @State private var showingAddCounter = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(elements.counters, id: \.id) { counter in
                    VStack {
                        Text(counter.name)
                    }
                }
                .onDelete(perform: deleteCounter)
            }
            .navigationBarTitle("Counters")
            .navigationBarItems(leading: EditButton())
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        self.showingAddCounter = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .sheet(isPresented: $showingAddCounter) {
            AddCounterView(elements: self.elements)
        }
    }
    
    func deleteCounter(at offsets: IndexSet) {
        elements.counters.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
        ContentView()
            .preferredColorScheme(.dark)
    }
}
