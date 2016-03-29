//
//  CGFloat+Randomness.swift
//  Pong
//
//  Created by Nico Hämäläinen on 29/03/16.
//  Copyright © 2016 sizeof.io. All rights reserved.
//

import Foundation

extension CGFloat {
  static func randomAngle(from from: Int, to: Int) -> CGFloat {
    return CGFloat(Int.random(from: from, to: to)) * CGFloat(M_PI) / 180
  }
  
  static func randomPercentage(from from: Int, to: Int) -> CGFloat {
    return CGFloat(Int.random(from: from, to: to)) / 100.0
  }
  
  static func randomAngleTangent(from from: Int, to: Int) -> CGFloat {
    return CGFloat(tanf(Float(CGFloat.randomAngle(from: from, to: to))))
  }
}