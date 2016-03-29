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
    
    // Create and add the player's paddle node
    playerPaddle = PaddleNode(sceneSize: view.frame.size)
    addChild(playerPaddle)
  }
  
  override func update(currentTime: NSTimeInterval) {
    // TODO: Game loop code
  }
}
