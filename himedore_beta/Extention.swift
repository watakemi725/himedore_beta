//
//  Extention.swift
//  himedore_beta
//
//  Created by Takemi Watanuki on 2015/02/26.
//  Copyright (c) 2015年 watakemi725. All rights reserved.
//

import Foundation

extension Array {
    mutating func shuffle(count: Int) {
        for _ in 0..<count {
            sortInPlace { (_,_) in arc4random() < arc4random() }
        }
    }
}

extension NSMutableArray {
    func shuffle(count: Int) {
        for i in 0..<count {
            let nElements: Int = count - i
            let n: Int = Int(arc4random_uniform(UInt32(nElements))) + i
            self.exchangeObjectAtIndex(i, withObjectAtIndex: n)
        }
    }
    
}
