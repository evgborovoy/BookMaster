//
//  ContentView.swift
//  BookMaster
//
//  Created by Evgeniy Borovoy on 12/4/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HomeView()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.bg)
    }
}

#Preview {
    ContentView()
}
