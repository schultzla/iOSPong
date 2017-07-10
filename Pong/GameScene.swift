//
//  GameScene.swift
//  Pong
//
//  Created by Logan Schultz on 7/8/17.
//  Copyright © 2017 Logan Schultz. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var ball = SKSpriteNode()
    var enemyPaddle = SKSpriteNode()
    var userPaddle = SKSpriteNode()
    
    var userScore = SKLabelNode()
    var enemyScore = SKLabelNode()
    
    var score = [Int]()
    
    override func didMove(to view: SKView) {
        
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        enemyPaddle = self.childNode(withName:"enemyPdl") as! SKSpriteNode
        userPaddle = self.childNode(withName: "userPdl") as! SKSpriteNode
        userScore = self.childNode(withName: "userScore") as! SKLabelNode
        enemyScore = self.childNode(withName: "enemyScore") as! SKLabelNode
        
        
        ball.physicsBody?.applyImpulse(CGVector(dx: 20, dy: 20))
        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        border.friction = 0
        border.restitution = 1
        
        self.physicsBody = border
        
        startGame()
        
    }
    
    func startGame() {
        score = [0,0]
    }
    
    func addScore(playerWhoWon: SKSpriteNode) {
        ball.position = CGPoint(x: 0, y: 0)
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)

        
        if playerWhoWon == userPaddle {
            score[0] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: 20, dy: 20))
        } else {
            score[1] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: -20, dy: -20))
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            userPaddle.run(SKAction.moveTo(x: location.x, duration: 0.2))
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            userPaddle.run(SKAction.moveTo(x: location.x, duration: 0.2))
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        enemyPaddle.run(SKAction.moveTo(x: ball.position.x, duration: 0.5))
        
        userScore.text = "\(score[0])"
        enemyScore.text = "\(score[1])"
        
        if ball.position.y <= userPaddle.position.y - 30 {
            addScore(playerWhoWon: enemyPaddle)
        } else if ball.position.y >= enemyPaddle.position.y + 30 {
            addScore(playerWhoWon: userPaddle)
        }
    }
}
