//
//  GameScene.swift
//  BabaIsYou-F19
//
//  Created by Parrot on 2019-10-17.
//  Copyright © 2019 Parrot. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate
{
    var player : SKSpriteNode!
    let PLAYER_SPEED : CGFloat = 32
    var wall1 : SKSpriteNode!
    var wall2 : SKSpriteNode!
    var wall3 : SKSpriteNode!
    var wall4 : SKSpriteNode!
    var flag : SKSpriteNode!
    var wallBox : SKSpriteNode!
    var flagBox : SKSpriteNode!
    var winBox : SKSpriteNode!
    var stopBox : SKSpriteNode!
    var isBox1 : SKSpriteNode!
    var isBox2 : SKSpriteNode!

    override func didMove(to view: SKView)
    {
        self.physicsWorld.contactDelegate = self
        self.player = self.childNode(withName: "coelho") as! SKSpriteNode
        self.wall1 = self.childNode(withName: "wall1") as! SKSpriteNode
        self.wall2 = self.childNode(withName: "wall2") as! SKSpriteNode
        self.wall3 = self.childNode(withName: "wall3") as! SKSpriteNode
        self.wall4 = self.childNode(withName: "wall4") as! SKSpriteNode
        self.flag = self.childNode(withName: "flag") as! SKSpriteNode
        self.wallBox = self.childNode(withName: "wallblock") as! SKSpriteNode
        self.flagBox = self.childNode(withName: "flagblock") as! SKSpriteNode
        self.winBox = self.childNode(withName: "winblock") as! SKSpriteNode
        self.stopBox = self.childNode(withName: "stopblock") as! SKSpriteNode
        self.isBox1 = self.childNode(withName: "isblock1") as! SKSpriteNode
        self.isBox2 = self.childNode(withName: "isblock2") as! SKSpriteNode
    }
   
    func didBegin(_ contact: SKPhysicsContact)
    {
        print("Something collided!")
    }
    
    override func update(_ currentTime: TimeInterval)
    {
        if(self.checkRulesCollision(first: wallBox, second: stopBox))
        {
            wall1.physicsBody?.collisionBitMask = 1
            wall2.physicsBody?.collisionBitMask = 1
            wall3.physicsBody?.collisionBitMask = 1
            wall4.physicsBody?.collisionBitMask = 1
            player.physicsBody?.collisionBitMask = 9 + 4
        }
        else
        {
            player.physicsBody?.collisionBitMask = 9
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        let mouseTouch = touches.first
        if (mouseTouch == nil) { return }
        let location = mouseTouch!.location(in: self)
        let nodeTouched = atPoint(location).name
        
        if (nodeTouched == "moveUp") { self.player.position.y = self.player.position.y + PLAYER_SPEED }
        else if (nodeTouched == "moveDown") { self.player.position.y = self.player.position.y - PLAYER_SPEED }
        else if (nodeTouched == "moveLeft") { self.player.position.x = self.player.position.x - PLAYER_SPEED }
        else if (nodeTouched == "moveRight") { self.player.position.x = self.player.position.x + PLAYER_SPEED }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    func checkRulesCollision(first : SKSpriteNode, second : SKSpriteNode) -> Bool
    {
        return self.isFramesLeftToRight(first: first, second: second) && self.isFramesAlign(first: first, second: second) && (first.frame.intersects(isBox1.frame) && self.isBox1.frame.intersects(second.frame) ||  first.frame.intersects(isBox2.frame) && self.isBox2.frame.intersects(second.frame))
    }
    
    func isFramesLeftToRight(first : SKSpriteNode, second : SKSpriteNode) -> Bool
    {
        return first.frame.midX < isBox1.frame.midX && isBox1.frame.midX < second.frame.midX || first.frame.midX < isBox2.frame.midX && isBox2.frame.midX < second.frame.midX
    }
    
    func isFramesAlign(first : SKSpriteNode, second : SKSpriteNode) -> Bool
    {
        return (first.frame.midY + 32 >= isBox1.frame.midY && first.frame.midY - 32 <= isBox1.frame.midY) && (second.frame.midY + 32 >= isBox1.frame.midY && second.frame.midY - 32 <= isBox1.frame.midY) || (first.frame.midY + 32 >= isBox2.frame.midY && first.frame.midY - 32 <= isBox2.frame.midY) && (second.frame.midY + 32 >= isBox2.frame.midY && second.frame.midY - 32 <= isBox2.frame.midY)
    }
}
