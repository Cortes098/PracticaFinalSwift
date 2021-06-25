import Foundation
import SpriteKit
import GameplayKit
// swiftlint:disable trailing_whitespace

extension GameScene {
    class Enemy: SKSpriteNode {
        var tankDirection: Direction = Direction.DOWN
        init(startPosition: CGPoint) {
            super.init(texture: SKTexture(imageNamed: "enemy1"), color: .clear, size: CGSize(width: 10, height: 10))
            
            let spawnSprite = SKSpriteNode(imageNamed: "init1")
            spawnSprite.position = startPosition
            
            let moveAction: SKAction = SKAction(named: "enemyTank")!
            let enemy = SKSpriteNode(imageNamed: "enemy1")
            let spawnAction: SKAction = SKAction(named: "createTank")!
            
            enemy.physicsBody = SKPhysicsBody(texture: enemy.texture!, size: CGSize(width: 10, height: 10))
            enemy.name = "enemy"
            enemy.physicsBody?.affectedByGravity = false
            enemy.physicsBody?.allowsRotation = false
            enemy.physicsBody?.linearDamping = 0
            enemy.position = startPosition
                      
            let addSpawn = SKAction.run {
                self.addChild(spawnSprite)
                spawnSprite.run(spawnAction, completion: {self.addChild(enemy); spawnSprite.removeFromParent()})
                
            }
            run(addSpawn)
            //run(addSpawn, completion: { SKAction.wait(forDuration: 20000000); spawnSprite.removeFromParent() })

            enemy.position = startPosition
            enemy.run(moveAction, withKey: "enemyTank")

            enemy.physicsBody?.velocity = CGVector(dx: 0, dy: -50)
            enemy.zRotation = CGFloat(270 * Double.pi / 180)
            run(SKAction.repeatForever(SKAction.sequence([
            SKAction.run {(self.createShoot(direction: self.tankDirection, enemy: enemy))},
            SKAction.wait(forDuration: 5)
            ])))
        }

        func changeDirection(enemy: Enemy) -> Direction {
            let direction: Int = Int.random(in: 0...3)
            switch direction {
            case 0:
                enemy.physicsBody?.velocity = CGVector(dx: -50, dy: 0)
                return Direction.LEFT
            case 1:
                enemy.physicsBody?.velocity = CGVector(dx: -50, dy: 0)
                return Direction.RIGHT
            case 2:
                enemy.physicsBody?.velocity = CGVector(dx: -50, dy: 0)
                return Direction.UP
            case 3:
                enemy.physicsBody?.velocity = CGVector(dx: -50, dy: 0)
                return Direction.DOWN
            default:
                return Direction.NONE
            }
        }
        func createShoot(direction: Direction, enemy: SKSpriteNode) {
            let bullet = SKSpriteNode(imageNamed: "bullet")
            bullet.physicsBody = SKPhysicsBody(texture: bullet.texture!, size: bullet.size)
            bullet.name = "bullet"
            addChild(bullet)
            switch direction {
            case .NONE:
                break
            case .LEFT:
                print("LEFT")
                bullet.zRotation = CGFloat(180 * Double.pi / 180)
                bullet.physicsBody?.velocity = CGVector(dx: -50, dy: 0)
                bullet.position = CGPoint(x: enemy.position.x - 15, y: enemy.position.y)
            case .RIGHT:
                print("RIGHT")
                bullet.zRotation = CGFloat(0 * Double.pi / 180)
                bullet.physicsBody?.velocity = CGVector(dx: 50, dy: 0)
                bullet.position = CGPoint(x: enemy.position.x+15, y: enemy.position.y)
            case .UP:
                print("UP")
                bullet.zRotation = CGFloat(90 * Double.pi / 180)
                bullet.physicsBody?.velocity = CGVector(dx: 0, dy: 50)
                bullet.position = CGPoint(x: enemy.position.x, y: enemy.position.y+15)
            case .DOWN:
                print("DOWN")
                bullet.zRotation = CGFloat(270 * Double.pi / 180)
                bullet.physicsBody?.velocity = CGVector(dx: 0, dy: -50)
                bullet.position = CGPoint(x: enemy.position.x, y: enemy.position.y-15)
            }

            bullet.zPosition = 1

            bullet.physicsBody?.affectedByGravity = false
            bullet.physicsBody?.linearDamping = 0
            bullet.physicsBody?.categoryBitMask = 0x00000010

            bullet.physicsBody?.contactTestBitMask = 0x00000100
        }
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }

}
