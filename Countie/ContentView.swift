//
//  ContentView.swift
//  Countie
//
//  Created by Niccolo Granieri on 26/06/2021.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var elements: Elements
    @State private var showingAddCounter = false
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            List {
                ForEach(Array(zip(elements.counters.indices, elements.counters)), id: \.1.id) { index, counter in
                    NavigationLink(destination: CounterView(counterIndex: index)) {
                        VStack {
                            HStack {
                                Text(counter.button)
                                Text(counter.name)
                                Spacer()
                                Text("\(counter.count)")
                            }
                        }
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
        .navigationViewStyle(StackNavigationViewStyle())
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
            .environment(\.locale, .init(identifier: "en"))
        ContentView()
            .environment(\.locale, .init(identifier: "it"))
    }
}
