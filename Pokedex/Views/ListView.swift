//
//  ListView.swift
//  Pokedex
//
//  Created by Omar Regalado Mendoza on 23/01/24.
//

import SwiftUI

struct ListView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
