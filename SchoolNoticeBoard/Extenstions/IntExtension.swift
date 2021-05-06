//
//  IntExtension.swift
//  SchoolNoticeBoard
//
//  Created by iOS Developer on 06/05/21.
//

import Foundation

extension Int {
    init(range: Range<Int> ) {
        let delta = range.startIndex < 0 ? abs(range.startIndex) : 0
        let min = UInt32(range.startIndex + delta)
        let max = UInt32(range.endIndex   + delta)
        self.init(Int(min + arc4random_uniform(max - min)) - delta)
    }
}
