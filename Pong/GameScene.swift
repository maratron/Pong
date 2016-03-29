//
//  GameScene.swift
//  Pong
//
//  Created by Nico Hämäläinen on 29/03/16.
//  Copyright (c) 2016 sizeof.io. All rights reserved.
//

import SpriteKit

/// Our main game scene where the magic happens
class GameScene: SKScene {
  /// The player's manually controller paddle
  var playerPaddle: PaddleNode!
  
  /// The ball that we're playing with
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
    playerPaddle.update(currentTime)
  }
}

// MARK: - Keyboard

extension GameScene {
  override func keyUp(theEvent: NSEvent) {
    self.handleKeyEvent(theEvent, isKeyDown: false)
  }
  
  override func keyDown(theEvent: NSEvent) {
    self.handleKeyEvent(theEvent, isKeyDown: true)
  }
  
  func handleKeyEvent(theEvent: NSEvent, isKeyDown: Bool) {
    guard let keyCode = KeyCode(rawValue: Int(theEvent.keyCode)) else {
      return
    }
    
    // Handle movement via keyboard events
    switch keyCode {
    case .ArrowUp, .W:
      playerPaddle.shouldMoveUp = isKeyDown
    case .ArrowDown, .S:
      playerPaddle.shouldMoveDown = isKeyDown
    }
  }
}
