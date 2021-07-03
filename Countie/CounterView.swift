//
//  CounterView.swift
//  Countie
//
//  Created by Niccolo Granieri on 26/06/2021.
//

import SwiftUI

extension Character {
    var isSimpleEmoji: Bool {
        guard let firstScalar = unicodeScalars.first else { return false }
        return firstScalar.properties.isEmoji && firstScalar.value > 0x238C
    }

    var isCombinedIntoEmoji: Bool { unicodeScalars.count > 1 && unicodeScalars.first?.properties.isEmoji ?? false }

    var isEmoji: Bool { isSimpleEmoji || isCombinedIntoEmoji }
}

extension String {
    var isSingleEmoji: Bool { count == 1 && containsEmoji }
    var containsEmoji: Bool { contains { $0.isEmoji } }
}

struct CounterView: View {
    @EnvironmentObject var elements: Elements
    var counterIndex: Int
    
    var body: some View {
        VStack (alignment: .center) {
            Spacer()
            Text("\(elements.counters[counterIndex].count)")
                .font(.largeTitle)
            Spacer()
            Button(action: {
                elements.counters[counterIndex].increment(by: elements.counters[counterIndex].step)
            }) {
                Text(elements.counters[counterIndex].button)
                    .font(.system(size: 200))
            }
            Spacer()
        }
        .navigationBarTitle(Text(elements.counters[counterIndex].name))
    }
}

//struct CounterView_Previews: PreviewProvider {
//    static var previews: some View {
//        CounterView(counterIndex: 0)
//    }
//}
