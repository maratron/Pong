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
  /// The movement speed of the ball node
  var movementSpeed: CGFloat = 3.5
  
  /// The movement velocity of the ball
  var movementVelocity: CGVector = CGVector.zero
  
  /// The movement velocity modifier of the ball
  var movementVelocityModifier: CGFloat = 0.0
  
  /// Whether the ball should bounce upwards next
  var shouldBounceUp: Bool = false
  
  /// Whether the ball should bounce left next
  var shouldBounceLeft: Bool = false
  
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
    
    // Default to velocity in the middle of the screen
    movementVelocity = CGVector(dx: sceneSize.width / 2.0, dy: sceneSize.height / 2.0)
  }
  
  func update(currentTime: NSTimeInterval) {
    guard let parent = parent else {
      fatalError("BallNode must belong to a parent node")
    }
    
    let adjustedHeight = frame.height / 2.0
    
    // Figure out where we want to bounce next and in what angle
    if movementVelocity.dy >= parent.frame.height - adjustedHeight {
      shouldBounceUp = true
      movementVelocityModifier = CGFloat.randomAngleTangent(from: 25, to: 35)
    }
    else if movementVelocity.dy <= adjustedHeight {
      shouldBounceUp = false
      movementVelocityModifier = CGFloat.randomAngleTangent(from: 25, to: 35)
    }
    
    // Move the ball
    let currentVelocity: CGFloat = movementSpeed * movementVelocityModifier
    let velocityDifference: CGFloat = movementSpeed - currentVelocity
    
    if shouldBounceUp {
      movementVelocity.dy += currentVelocity
    }
    else {
      movementVelocity.dy -= currentVelocity
    }
    
    if shouldBounceLeft {
      movementVelocity.dx -= movementSpeed + velocityDifference
    }
    else {
      movementVelocity.dx += movementSpeed + velocityDifference
    }
    
    position = CGPoint(x: movementVelocity.dx, y: movementVelocity.dy)
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