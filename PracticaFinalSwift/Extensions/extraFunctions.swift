import Foundation
import SpriteKit
import GameplayKit

// swiftlint:disable force_cast
// swiftlint:disable color
extension GameScene {
    func setMapPhysics(tileDefiniton: SKTileDefinition, tileSize: CGSize, coX: CGFloat, coY: CGFloat, startingLocation: CGPoint) {
        if tileDefiniton.name == "emptyBrick" {
            let brickTexture = SKTexture(imageNamed: "brick")

            let node = SKSpriteNode(texture: brickTexture)
            node.position = CGPoint(x: coX, y: coY)

            node.physicsBody = SKPhysicsBody(texture: brickTexture, size: CGSize(width: CGFloat(10), height: CGFloat(10)) )

            node.physicsBody?.linearDamping = 0
            node.physicsBody?.affectedByGravity = false
            node.zPosition = 1
            node.physicsBody?.allowsRotation = false
            node.physicsBody?.categoryBitMask = 0x00000100
            node.physicsBody?.collisionBitMask = 0x00000000
            node.physicsBody?.contactTestBitMask = 0x00000111
            node.physicsBody?.isDynamic = false
            node.name = "brick"
            self.addChild(node)

            node.position = CGPoint(x: node.position.x + startingLocation.x, y: node.position.y + startingLocation.y)
        } else if tileDefiniton.name == "iron" {
            let ironTexture = SKTexture(imageNamed: "iron")

            let node = SKNode()
            node.position = CGPoint(x: coX, y: coY)

            node.physicsBody = SKPhysicsBody(texture: ironTexture, size: CGSize(width: (ironTexture.size().width), height: (ironTexture.size().height)) )

            node.physicsBody?.linearDamping = 0
            node.physicsBody?.affectedByGravity = false
            node.zPosition = 1
            node.physicsBody?.allowsRotation = false
            node.physicsBody?.categoryBitMask = 0x00000100
            node.physicsBody?.collisionBitMask = 0x00000000
            node.physicsBody?.contactTestBitMask = 0x00000111
            node.physicsBody?.isDynamic = false
            node.name = "iron"
            self.addChild(node)

            node.position = CGPoint(x: node.position.x + startingLocation.x, y: node.position.y + startingLocation.y)
        } else if tileDefiniton.name == "water" {
            let waterTexture = SKTexture(imageNamed: "water")

            let node = SKNode()
            node.position = CGPoint(x: coX, y: coY)

            node.physicsBody = SKPhysicsBody(texture: waterTexture, size: CGSize(width: (waterTexture.size().width), height: (waterTexture.size().height)) )

            node.physicsBody?.linearDamping = 0
            node.physicsBody?.affectedByGravity = false
            node.zPosition = 1
            node.physicsBody?.allowsRotation = false
            node.physicsBody?.categoryBitMask = 0x00000100
            node.physicsBody?.collisionBitMask = 0x00000000
            node.physicsBody?.contactTestBitMask = 0x00000111
            node.physicsBody?.isDynamic = false
            node.name = "water"
            self.addChild(node)

            node.position = CGPoint(x: node.position.x + startingLocation.x, y: node.position.y + startingLocation.y)
        } else if tileDefiniton.name == "png" {
            let borderTexture = SKTexture(imageNamed: "emptyBrick")
            
            let node = SKNode()
            node.position = CGPoint(x: coX, y: coY)

            node.physicsBody = SKPhysicsBody(texture: borderTexture, size: CGSize(width: (borderTexture.size().width), height: (borderTexture.size().height)) )
            node.alpha=0
            node.physicsBody?.linearDamping = 0
            node.physicsBody?.affectedByGravity = false
            node.zPosition = 1
            node.physicsBody?.allowsRotation = false
            node.physicsBody?.categoryBitMask = 0x00000100
            node.physicsBody?.collisionBitMask = 0x00000000
            node.physicsBody?.contactTestBitMask = 0x00000111
            node.physicsBody?.isDynamic = false
            node.name = "png"
            self.addChild(node)

            node.position = CGPoint(x: node.position.x + startingLocation.x, y: node.position.y + startingLocation.y)
        } else if tileDefiniton.name == "end" {
            let endTexture = SKTexture(imageNamed: "end")
            let node = SKNode()
            node.position = CGPoint(x: coX, y: coY)
            node.physicsBody = SKPhysicsBody(texture: endTexture, size: CGSize(width: (endTexture.size().width), height: (endTexture.size().height)) )
            node.alpha=0
            node.physicsBody?.linearDamping = 0
            node.physicsBody?.affectedByGravity = false
            node.zPosition = 1
            node.physicsBody?.allowsRotation = false
            node.physicsBody?.categoryBitMask = 0x00000100
            node.physicsBody?.collisionBitMask = 0x00000000
            node.physicsBody?.contactTestBitMask = 0x00000111
            node.physicsBody?.isDynamic = false
            node.name = "end"
            self.addChild(node)
            node.position = CGPoint(x: node.position.x + startingLocation.x, y: node.position.y + startingLocation.y)
        }
    }
    func createExplosion(position: CGPoint)
    {
        let explosionSprite = SKSpriteNode(imageNamed: "expl5")
        explosionSprite.position = position
        addChild(explosionSprite)
        
        let explosion: SKAction = SKAction(named: "Explosion")!
        explosionSprite.run(explosion, completion: {explosionSprite.removeFromParent()})
        
    }
}
