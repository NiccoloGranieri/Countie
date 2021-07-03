//
//  AddCounterView.swift
//  Countie
//
//  Created by Niccolo Granieri on 26/06/2021.
//

import SwiftUI

class EmojiButton: ObservableObject {
    var limit: Int = 1

    @Published var emoji: String = "" {
        didSet {
            if emoji.count > limit {
                emoji = String(emoji.prefix(limit))
            }
        }
    }
}

struct AddCounterView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var emojiButton = EmojiButton()
    @ObservedObject var elements: Elements
    
    @State private var name = ""
    @State private var increment = 1
    @State private var step = "1"
    @State private var customStep = ""
    @State private var startCount = ""
    @State private var showButton = false
    
    let steps = ["1", "2", "5", "10", "Custom"]
    
    var body: some View {
        NavigationView {
            Form {
                Section (header: Text("What do you want to count?")) {
                    TextField("Name", text: $name)
                }
                Section (header: Text("What increment do you want to count by?")) {
                    Picker("Increment Steps", selection: $step) {
                        ForEach(steps, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())

                    if step == "Custom" {
                        TextField("Steps", text: $customStep)
                            .keyboardType(.decimalPad)
                    }
                }

                Section (header: Text("Optional:")) {
                    TextField("Start counting from:", text: $startCount)
                        .keyboardType(.decimalPad)
                    Toggle(isOn: $showButton) {
                        Text("Enable custom button")
                    }
                    if showButton {
                        TextField("Use custom emoji as button", text: $emojiButton.emoji)
                    }
                }
            }
            .navigationBarTitle(Text("Add Countable"))
            .navigationBarItems(trailing:
                Button("Save") {
                    if self.step == "Custom" {
                        self.step = self.customStep
                    }
                    
                    let counter = Counter(name: self.name, count: Int(self.startCount) ?? 0, step: Int(self.step) ?? 1, button: self.emojiButton.emoji != "" ? self.emojiButton.emoji : "🔴")
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
