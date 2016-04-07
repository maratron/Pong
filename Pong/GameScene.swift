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
  
  /// The fixed position for the player's paddle
  var playerPaddleFixedOriginX: CGFloat {
    return playerPaddle.size.width + 10.0
  }
  
  /// The computer's automatically controlled paddle
  var computerPaddle: PaddleNode!
  
  /// The fixed position for the computer's paddle
  var computerPaddleFixedOriginX: CGFloat {
    return size.width - (computerPaddle.size.width + 10)
  }
  
  /// The ball that we're playing with
  var ball: BallNode!
  
  /// Player score
  var playerScoreLabel = SKLabelNode(text: "0")
  var playerScore: Int = 0 {
    didSet {
      playerScoreLabel.text = "\(playerScore)"
    }
  }
  
  /// Computer score
  var computerScoreLabel = SKLabelNode(text: "0")
  var computerScore: Int = 0 {
    didSet {
      computerScoreLabel.text = "\(computerScore)"
    }
  }
  
  /// The restart countdown is 5 seconds, counting them here
  var restartCounter: Int = 5
  
  /// The label to display the restart countdown
  var restartCounterLabel = SKLabelNode(text: "5")
  
  /// If we're currently counting down to restart
  var restartCounterActive = false
  
  override func didMoveToView(view: SKView) {
    super.didMoveToView(view)
    
    // Configure scene colors
    backgroundColor = SKColor.backgroundColor()
    
    // Get the size of the scene
    let sceneSize = view.frame.size
    
    // Create and add the player's paddle node
    playerPaddle = PaddleNode(sceneSize: sceneSize)
    addChild(playerPaddle)
    
    // Create and add the computer's paddle node
    computerPaddle = PaddleNode(sceneSize: sceneSize)
    addChild(computerPaddle)

    // Create and add the ball node
    ball = BallNode(sceneSize: sceneSize)
    ball.position = CGPoint(x: size.width / 5, y: size.height / 2)
    ball.physicsBody?.usesPreciseCollisionDetection = true
    addChild(ball)
    
    // Setup player score label
    playerScoreLabel.horizontalAlignmentMode = .Right
    playerScoreLabel.position = CGPoint(x: size.width / 2.0 - 150, y: size.height - 50.0)
    addChild(playerScoreLabel)
    
    // Setup computer score label
    computerScoreLabel.horizontalAlignmentMode = .Left
    computerScoreLabel.position = CGPoint(x: size.width / 2.0 + 150, y: size.height - 50.0)
    addChild(computerScoreLabel)
    
    restartCounterLabel.fontSize = 64.0
    restartCounterLabel.position = CGPoint(x: size.width / 2, y: size.height / 2)
    addChild(restartCounterLabel)
    
    // No gravity physics world
    physicsWorld.contactDelegate = self
    physicsWorld.gravity = CGVector.zero
  }
  
  override func update(currentTime: NSTimeInterval) {
    if restartCounterActive {
      return
    }
    
    ball.update(currentTime)
    playerPaddle.update(currentTime)
    computerPaddle.updateWithTargetPosition(CGPoint(x: computerPaddleFixedOriginX, y: ball.movementVelocity.dy))
   
    if ball.movementVelocity.dx >= size.width + ball.frame.width * 2 {
      resetBallPosition()
      playerScore += 1
    }
    else if ball.movementVelocity.dx <= 0 {
      resetBallPosition()
      computerScore += 1
    }

    // Make sure paddles don't move horizontally (physics can cause it)
    playerPaddle.position.x = playerPaddleFixedOriginX
    computerPaddle.position.x = computerPaddleFixedOriginX
  }
  
  func restart() {
    resetPaddlePositions()
    resetBallPosition()
    restartCounterActive = false
  }
  
  func restartCountdown() {
    if restartCounter == 0 {
      restart()
      restartCounter = 5
    }
    else {
      self.restartCounterLabel.text = "\(restartCounter)"
      self.performSelector(#selector(restartCountdown), withObject: nil, afterDelay: 1)
    }
  }
  
  func resetPaddlePositions() {
    playerPaddle.position = CGPoint(x: playerPaddleFixedOriginX, y: size.height / 2)
    computerPaddle.position = CGPoint(x: computerPaddleFixedOriginX, y: size.height / 2)
  }
  
  func resetBallPosition() {
    ball.movementVelocity = CGVector(dx: size.width / 2.0, dy: size.height / 2.0)
    ball.position = CGPoint(x: size.width / 2.0, y: size.height / 2.0)
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

// MARK: - Physics

extension GameScene: SKPhysicsContactDelegate {
  func didBeginContact(contact: SKPhysicsContact) {
    let ballTouched = contact.bodyA.categoryBitMask == PhysicsBitMask.Paddle.rawValue
    let paddleTouched = contact.bodyB.categoryBitMask == PhysicsBitMask.Ball.rawValue
    
    guard let paddleNode = contact.bodyA.node as? PaddleNode else {
      return
    }
    
    if ballTouched && paddleTouched {
      ball.handleContactWithPaddle(paddleNode)
    }

  }
}