//
//  PaddleNode.swift
//  Pong
//
//  Created by Nico Hämäläinen on 29/03/16.
//  Copyright © 2016 sizeof.io. All rights reserved.
//

import Foundation
import SpriteKit

/// Visual representation of a moveable paddle object
class PaddleNode: SKSpriteNode {
  /// The movement speed of this paddle node
  var movementSpeed: CGFloat = 10.0
  
  /// Whether or not we need to move down on the next render cycle
  var shouldMoveDown = false
  
  /// Whether or not we need to move up on the next render cycle
  var shouldMoveUp = false
  
  /// Create a new PaddleNode
  ///
  /// - parameter sceneSize: The size of the scene the paddle will be in (used in size calculation)
  ///
  /// - returns: The newly created PaddleNode
  convenience init(sceneSize: CGSize) {
    self.init(color: SKColor.paddleColor(), size: PaddleNode.sizeForSceneSize(sceneSize))
    
    // Create a static physics body for the paddle
    physicsBody = SKPhysicsBody(rectangleOfSize: self.size)
    physicsBody!.categoryBitMask = PhysicsBitMask.Paddle.rawValue
    physicsBody!.contactTestBitMask = PhysicsBitMask.Ball.rawValue
    physicsBody!.friction = 0.0
    physicsBody!.mass = 500.0
    physicsBody!.velocity = CGVector.zero
    physicsBody!.usesPreciseCollisionDetection = true
  }
  
  /// Called on every update loop of the scene
  func update(currentTime: NSTimeInterval) {
    if shouldMoveUp {
      self.moveUp()
    }
    
    if shouldMoveDown {
      self.moveDown()
    }
  }
}

// MARK: - Movement

extension PaddleNode {
  /// Move the paddle up by the current movement speed
  func moveUp() {
    if !isTouchingTopEdge() {
      position.y += movementSpeed
    }
  }
  
  /// Move the paddle down by the current movement speed
  func moveDown() {
    if !isTouchingBottomEdge() {
      position.y -= movementSpeed
    }
  }
  
  /// Check if we can move up
  /// - returns: True if the paddle can be moved up from current position
  func isTouchingTopEdge() -> Bool {
    guard let parent = parent else {
      fatalError("PaddleNode must belong to a parent node")
    }
    
    return parent.frame.height <= (position.y + size.height / 2.0)
  }
  
  /// Check if we can move down
  /// - returns: True if the paddle can be moved down from current position
  func isTouchingBottomEdge() -> Bool {
    return 0 >= (position.y - size.height / 2.0)
  }
}

// MARK: - Utilities

extension PaddleNode {
  /// Calculates the proper paddle node size for a given scene size
  ///
  /// - parameter sceneSize: The size of the scene we're playing in
  /// - returns: The appropriate size for the paddle sprite
  static func sizeForSceneSize(sceneSize: CGSize) -> CGSize {
    let height = sceneSize.height * 0.23
    let width  = height * 0.1619
    return CGSize(width: width, height: height)
  }
}