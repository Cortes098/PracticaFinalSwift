import Foundation
import SpriteKit
import GameplayKit
// swiftlint:disable trailing_whitespace

extension GameScene {
    class Enemy: SKSpriteNode {
        var tankDirection: Direction = Direction.DOWN
        let enemySprite = SKSpriteNode(imageNamed: "enemy1")
        init(startPosition: CGPoint) {
            super.init(texture: SKTexture(imageNamed: "emptyBrick"), color: .clear, size: CGSize(width: 10, height: 10))
            
            let spawnSprite = SKSpriteNode(imageNamed: "init1")
            spawnSprite.position = startPosition
            
            let moveAction: SKAction = SKAction(named: "enemyTank")!
            
            let spawnAction: SKAction = SKAction(named: "createTank")!
            
            enemySprite.physicsBody = SKPhysicsBody(texture: enemySprite.texture!, size: CGSize(width: 7, height: 7))
            
            enemySprite.name = "enemy"
            enemySprite.physicsBody?.affectedByGravity = false
            enemySprite.physicsBody?.allowsRotation = false
            enemySprite.physicsBody?.linearDamping = 0
            enemySprite.position = startPosition
              
            let a = SKAction.repeatForever(SKAction.sequence([
                SKAction.run { self.createShoot(direction: self.tankDirection, enemy: self.enemySprite)}, SKAction.wait(forDuration: 1)
            ]))
            
            let addSpawn = SKAction.run {
                self.addChild(spawnSprite)
                spawnSprite.run(spawnAction, completion: {self.addChild(self.enemySprite); spawnSprite.removeFromParent(); self.run(a); self.move() })
            }
            run(addSpawn)
            

            enemySprite.position = startPosition
            enemySprite.run(moveAction, withKey: "enemyTank")

            enemySprite.physicsBody?.velocity = CGVector(dx: 0, dy: -50)
            enemySprite.zRotation = CGFloat(270 * Double.pi / 180)
            
            
        }

        func changeDirection(enemy: SKSpriteNode) -> Direction {
            let direction: Int = Int.random(in: 0...3)
            switch direction {
            case 0:
                enemy.zRotation = CGFloat(180 * Double.pi / 180)
                enemy.physicsBody?.velocity = CGVector(dx: -20, dy: 0)
                return Direction.LEFT
            case 1:
                enemy.zRotation = CGFloat(0 * Double.pi / 180)
                enemy.physicsBody?.velocity = CGVector(dx: 20, dy: 0)
                return Direction.RIGHT
            case 2:
                enemy.zRotation = CGFloat(90 * Double.pi / 180)
                enemy.physicsBody?.velocity = CGVector(dx: 0, dy: 20)
                return Direction.UP
            case 3:
                enemy.zRotation = CGFloat(270 * Double.pi / 180)
                enemy.physicsBody?.velocity = CGVector(dx: 0, dy: -20)
                return Direction.DOWN
            default:
                return Direction.NONE
            }
        }
        func createShoot(direction: Direction, enemy: SKSpriteNode) {
            let bullet = SKSpriteNode(imageNamed: "bullet")
            bullet.physicsBody = SKPhysicsBody(texture: bullet.texture!, size: bullet.size)
            bullet.name = "bullet"
            
            if (enemySprite.parent != nil)
            {
                addChild(bullet)                
            }
            
            switch direction {
            case .NONE:
                break
            case .LEFT:
                print("LEFT")
                bullet.zRotation = CGFloat(180 * Double.pi / 180)
                bullet.physicsBody?.velocity = CGVector(dx: -50, dy: 0)
                bullet.position = CGPoint(x: enemy.position.x - 10, y: enemy.position.y)
            case .RIGHT:
                print("RIGHT")
                bullet.zRotation = CGFloat(0 * Double.pi / 180)
                bullet.physicsBody?.velocity = CGVector(dx: 50, dy: 0)
                bullet.position = CGPoint(x: enemy.position.x+10, y: enemy.position.y)
            case .UP:
                print("UP")
                bullet.zRotation = CGFloat(90 * Double.pi / 180)
                bullet.physicsBody?.velocity = CGVector(dx: 0, dy: 50)
                bullet.position = CGPoint(x: enemy.position.x, y: enemy.position.y+10)
            case .DOWN:
                print("DOWN")
                bullet.zRotation = CGFloat(270 * Double.pi / 180)
                bullet.physicsBody?.velocity = CGVector(dx: 0, dy: -50)
                bullet.position = CGPoint(x: enemy.position.x, y: enemy.position.y-10)
            }
            bullet.physicsBody?.affectedByGravity = false
            bullet.physicsBody?.linearDamping = 0
            bullet.physicsBody?.categoryBitMask = 0x00000010
            bullet.physicsBody?.contactTestBitMask = 0x00000100
        }
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        private func move()
        {
            let deltaTime = Int.random(in: 1..<3)
            
            let waitAction = SKAction.wait(forDuration: TimeInterval(deltaTime))
            
            run(SKAction.repeatForever(SKAction.sequence([
                SKAction.run {self.tankDirection = self.changeDirection(enemy: self.enemySprite)},
                SKAction.wait(forDuration: TimeInterval(deltaTime))
            ])))
            
            
        }
    }
}
