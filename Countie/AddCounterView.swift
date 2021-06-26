//
//  AddCounterView.swift
//  Countie
//
//  Created by Niccolo Granieri on 26/06/2021.
//

import SwiftUI

struct AddCounterView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var elements: Elements
    
    @State private var name = ""
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name the thing you want to count", text: $name)
            }
            .navigationBarTitle(Text("Add Countable"))
            .navigationBarItems(trailing:
                Button("Save") {
                    let counter = Counter(name: self.name)
                    self.elements.counters.append(counter)
                    self.presentationMode.wrappedValue.dismiss()
                })
        }
    }
}

struct AddCounterView_Previews: PreviewProvider {
    static var previews: some View {
        AddCounterView(elements: Elements())
    }
}
