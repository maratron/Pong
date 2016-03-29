//
//  Int+Randomness.swift
//  Pong
//
//  Created by Nico Hämäläinen on 29/03/16.
//  Copyright © 2016 sizeof.io. All rights reserved.
//

import Foundation

extension Int {
  static func random(from from: Int, to: Int) -> Int {
    return from + Int(arc4random_uniform(UInt32(to - from + 1)))
  }
}