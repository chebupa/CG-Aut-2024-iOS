//
//  SearchScreen.swift
//  CallibriDemo
//
//  Created by aristarh on 24.11.2024.
//

import SwiftUI

struct SearchScreen: View {
    
    // MARK: - Properties
    
    @StateObject var state: SearchState
    @Environment(\.dismiss) var dismiss
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            List {
                if state.devices.isEmpty {
                    ProgressView()
                } else {
                    ForEach(state.devices, id: \.self) { device in
                        Button(device.name) {
                            state.connect(to: device)
                        }
                    }
                }
            }
            .navigationTitle("Sensors")
            .onAppear { state.onAppear() }
        }
    }
}
