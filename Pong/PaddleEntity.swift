//
//  PaddleEntity.swift
//  Pong
//
//  Created by Nico Hämäläinen on 29/03/16.
//  Copyright © 2016 sizeof.io. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit

/// The player "paddle" that we move to protect our side
class PaddleEntity: GameEntity {
  /// The sprite associated with the paddle entity
  var sprite: SKSpriteNode?
  
  /// Create a new PaddleEntity
  ///
  /// - parameter sceneSize: The size of the scene the paddle will be in, used for calculating paddle size
  ///
  /// - returns: The newly created PaddleEntity
  init(sceneSize: CGSize) {
    // Create a white paddle sprite node
    self.sprite = SKSpriteNode(color: .whiteColor(), size: sceneSize)
    
    // Create a static physics body for the sprite
    let physicsBody = SKPhysicsBody(rectangleOfSize: self.sprite!.size)
    physicsBody.dynamic = false
    self.sprite!.physicsBody = physicsBody
  }
}

// MARK: Utilities

extension PaddleEntity {
  /// Calculates the proper paddle sprite size for a given scene size
  ///
  /// - parameter sceneSize: The size of the scene we're playing in
  /// - returns: The appropriate size for the paddle sprite
  static func sizeForSceneSize(sceneSize: CGSize) -> CGSize {
    let height = sceneSize.height * 0.23
    let width  = height * 0.1619
    return CGSize(width: width, height: height)
  }
}