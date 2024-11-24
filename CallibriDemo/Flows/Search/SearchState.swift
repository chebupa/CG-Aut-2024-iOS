//
//  SearchState.swift
//  CallibriDemo
//
//  Created by aristarh on 24.11.2024.
//

import Foundation
import neurosdk2

@MainActor
final class SearchState: ObservableObject {
    
    // MARK: - Screen
    
    var screen: SearchScreen { .init(state: self) }
    
    // MARK: - Properties
    
    @Published var devices: [NTSensorInfo] = []
}

// MARK: - Methods

extension SearchState {
    
    func onAppear() {
        CallibriController.shared.startSearch(sensorsChanged: { sensors in
            self.devices.removeAll()
            self.devices.append(contentsOf: sensors)
        })
    }
    
    func connect(to device: NTSensorInfo) {
        CallibriController.shared.createAndConnect(sensorInfo: device, onConnectionResult: { state in
            self.screen.dismiss()
        })
    }
}
