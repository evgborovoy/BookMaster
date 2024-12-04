//
//  Booking.swift
//  BookMaster
//
//  Created by Evgeniy Borovoy on 12/4/24.
//

import Foundation

class Timeslot: Identifiable {
    var id: UUID = UUID()
    var clientID: UUID?
    var date: Date
    var masterID: UUID
    
    init(date: Date, masterID: UUID) {
        self.date = date
        self.masterID = masterID
    }
}

extension Timeslot {
    static let mockMasterID = UUID()
    static var mockData: [Timeslot] = [
        Timeslot(date: .init(timeIntervalSince1970: 1), masterID: mockMasterID),
        Timeslot(date: .init(timeIntervalSince1970: 57), masterID: mockMasterID),
        Timeslot(date: .init(timeIntervalSince1970: 98), masterID: mockMasterID),
        Timeslot(date: .init(timeIntervalSince1970: 358), masterID: mockMasterID),
        ]
}
