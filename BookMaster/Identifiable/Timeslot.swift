//
//  Timeslot.swift
//  BookMaster
//
//  Created by Evgeniy Borovoy on 12/4/24.
//

import Foundation

class Timeslot: Identifiable {
    var id: UUID = UUID()
    var clientID: UUID?
    var date: Date
    var endDate: Date
    var masterID: UUID
    
    init(date: Date, masterID: UUID) {
        self.date = date
        self.endDate = date.addingTimeInterval(7200)
        self.masterID = masterID
    }
}

extension Timeslot {
    static let mockMasterID = UUID()
    static var mockData: [Timeslot] = [
        Timeslot(date: .init(timeIntervalSince1970: 1), masterID: mockMasterID),
        Timeslot(date: .init(timeIntervalSince1970: 7200), masterID: mockMasterID),
        Timeslot(date: .init(timeIntervalSince1970: 14400), masterID: mockMasterID),
        Timeslot(date: .init(timeIntervalSince1970: 21600), masterID: mockMasterID),
        ]
}
