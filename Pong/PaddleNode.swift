//
//  PaddleNode.swift
//  Pong
//
//  Created by Nico Hämäläinen on 29/03/16.
//  Copyright © 2016 sizeof.io. All rights reserved.
//

import Foundation
import SpriteKit

class PaddleNode: SKSpriteNode {
  convenience init(sceneSize: CGSize) {
    self.init(color: SKColor.paddleColor(), size: PaddleNode.sizeForSceneSize(sceneSize))
    
    // Create a static physics body for the sprite
    let physicsBody = SKPhysicsBody(rectangleOfSize: self.size)
    physicsBody.dynamic = false
    self.physicsBody = physicsBody
  }
  
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