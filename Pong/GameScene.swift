//
//  GameScene.swift
//  Pong
//
//  Created by Nico Hämäläinen on 29/03/16.
//  Copyright (c) 2016 sizeof.io. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
  var playerPaddle: PaddleNode!
  var ball: BallNode!
  
  override init(size: CGSize) {
    super.init(size: size)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func didMoveToView(view: SKView) {
    super.didMoveToView(view)
    
    // Configure scene colors
    backgroundColor = SKColor.backgroundColor()
    
    // Get the size of the scene
    let sceneSize = view.frame.size
    
    // Create and add the player's paddle node
    playerPaddle = PaddleNode(sceneSize: sceneSize)
    playerPaddle.position = CGPoint(x: size.width / 2, y: size.height / 2)
    addChild(playerPaddle)

    // Create and add the ball node
    ball = BallNode(sceneSize: sceneSize)
    ball.position = CGPoint(x: size.width / 3, y: size.height / 2)
    addChild(ball)
  }
  
  override func update(currentTime: NSTimeInterval) {
    // TODO: Game loop code
  }
}
