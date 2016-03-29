//
//  GameEntity.swift
//  Pong
//
//  Created by Nico Hämäläinen on 29/03/16.
//  Copyright © 2016 sizeof.io. All rights reserved.
//

import Foundation
import SpriteKit

/// Base protocol for all game entities
protocol GameEntity {
  /// The sprite associated with this entity
  var sprite: SKSpriteNode? { get }
  
  /// The position of this entity (more specifically the position of this entity's sprite)
  var position: CGPoint { get set }
}

extension GameEntity {
  /// Custom accessors for the position of the sprite, gets and sets the sprite's instead
  var position: CGPoint {
    get {
      return sprite?.position ?? CGPoint.zero
    }
    
    set(newValue) {
      sprite?.position = newValue
    }
  }
}