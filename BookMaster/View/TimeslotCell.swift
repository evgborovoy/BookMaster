//
//  TimeslotCell.swift
//  BookMaster
//
//  Created by Evgeniy Borovoy on 12/4/24.
//

import SwiftUI

struct TimeslotCell: View {
    @State var observed: Observed
    
    var body: some View {
        VStack(alignment: .leading, spacing: 7) {
            Text(observed.timeLabel)
                .font(.title3.bold())
            
            Text(observed.isAvailable)
                .font(.title2.bold())
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .background(.greenSlot)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .offset(x: 42)
    }
}

extension TimeslotCell {
    
    @Observable
    class Observed {
        var timeslot: Timeslot
        
        var timeLabel: String {
            "\(timeslot.date.formatted(date: .omitted, time: .shortened)) - \(timeslot.endDate.formatted(date: .omitted, time: .shortened))"
        }
        var isAvailable: String {
            guard timeslot.clientID != nil else {
                return "Available" }
            
            if timeslot.clientID == currentUserID {
                return "That's your slot"
            }
            
            return "Reserved"
        }
        
        var slotBgColor: Color {
            if timeslot.clientID == nil {
                return .greenSlot
            }
            
            return timeslot.clientID == currentUserID ? .yellowSlot : .redSlot
        }
        
        init(timeslot: Timeslot) {
            self.timeslot = timeslot
        }
    }
}

#Preview {
    TimeslotCell(observed: .init(timeslot: .init(date: .now, masterID: Timeslot.mockMasterID)))
}
