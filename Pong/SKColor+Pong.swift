//
//  SKColor+Pong.swift
//  Pong
//
//  Created by Nico Hämäläinen on 29/03/16.
//  Copyright © 2016 sizeof.io. All rights reserved.
//

import Foundation
import SpriteKit

extension SKColor {
  class func backgroundColor() -> SKColor {
    return SKColor(red: 30/255.0, green: 30/255.0, blue: 32/255.0, alpha: 1.0)
  }
  
  class func paddleColor() -> SKColor {
    return SKColor(red: 217/255.0, green: 203/255.0, blue: 158/255.0, alpha: 1.0)
  }
  
  class func ballColor() -> SKColor {
    return SKColor(red: 220/255.0, green: 53/255.0, blue: 34/255.0, alpha: 1.0)
  }
}