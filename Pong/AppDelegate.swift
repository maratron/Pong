//
//  AppDelegate.swift
//  Pong
//
//  Created by Nico Hämäläinen on 29/03/16.
//  Copyright (c) 2016 sizeof.io. All rights reserved.
//


import Cocoa
import SpriteKit

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
  
  @IBOutlet weak var window: NSWindow!
  @IBOutlet weak var skView: SKView!
  
  func applicationDidFinishLaunching(aNotification: NSNotification) {
    skView!.ignoresSiblingOrder = true
    skView!.showsFPS = true
    skView!.showsNodeCount = true

    let scene = GameScene()
    scene.scaleMode = .AspectFit
    skView!.presentScene(scene)
  }
  
  func applicationShouldTerminateAfterLastWindowClosed(sender: NSApplication) -> Bool {
    return true
  }
}
