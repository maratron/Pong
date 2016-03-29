//
//  BallNode.swift
//  Pong
//
//  Created by Nico Hämäläinen on 29/03/16.
//  Copyright © 2016 sizeof.io. All rights reserved.
//

import Foundation
import SpriteKit

/// Visual representation of the moving ball object
class BallNode: SKShapeNode {
  /// Create a new BallNode
  ///
  /// - parameter sceneSize: The size of the scene the ball will be in (used in size calculation)
  ///
  /// - returns: The newly created BallNode
  convenience init(sceneSize: CGSize) {
    self.init()
    
    // Create a round path and set the shape's path to it
    let ballSize = BallNode.sizeForSceneSize(sceneSize)
    let ballRect = CGRect(origin: CGPoint.zero, size: ballSize)
    let ballRadius = ballSize.width / 2.0
    path = CGPathCreateWithRoundedRect(ballRect, ballRadius, ballRadius, nil)
    
    // Colorize
    fillColor = .ballColor()
    strokeColor = .clearColor()
    
    // Create a static physics body for the ball
    physicsBody = SKPhysicsBody(circleOfRadius: ballRadius)
    physicsBody!.dynamic = false
  }
}

// MARK: - Utilities

extension BallNode {
  /// Calculates the proper ball node size for a given scene size
  ///
  /// - parameter sceneSize: The size of the scene we're playing in
  /// - returns: The appropriate size for the ball node
  static func sizeForSceneSize(sceneSize: CGSize) -> CGSize {
    let paddleWidth = PaddleNode.sizeForSceneSize(sceneSize).width
    return CGSize(width: paddleWidth, height: paddleWidth)
  }
}