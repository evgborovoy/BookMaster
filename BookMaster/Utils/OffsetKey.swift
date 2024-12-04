//
//  OffsetKey.swift
//  BookMaster
//
//  Created by Evgeniy Borovoy on 12/4/24.
//

import SwiftUI

struct OffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
