import Foundation
import SpriteKit
import GameplayKit

extension GameScene {

    func setUpSceneWithMap(map: SKTileMapNode) {
        let tileMap = map
        let tileSize = tileMap.tileSize

        let halfWidth = CGFloat(tileMap.numberOfColumns) / 2.0*tileSize.width
        let halfHeight = CGFloat(tileMap.numberOfRows) / 2.0*tileSize.height

        let cameraNode = SKCameraNode()
        cameraNode.position = CGPoint(x: 0, y: -64)
        cameraNode.setScale(0.28)
        self.addChild(cameraNode)
        self.camera = cameraNode

        for col in 0..<tileMap.numberOfColumns {
            for row in 0..<tileMap.numberOfRows {
                if let _ = tileMap.tileDefinition(atColumn: col, row: row) {
                    // painted tile
                    if let tileDef = tileMap.tileDefinition(atColumn: col, row: row) {
                        let constx = CGFloat(col) * tileSize.width - halfWidth + (tileSize.width/2)
                        let consty = CGFloat(row) * tileSize.height - halfHeight + (tileSize.height/2)
                        setMapPhysics(tileDefiniton: tileDef, tileSize: tileSize, coX: constx, coY: consty, startingLocation: tileMap.position)

                    }
                } else {
                    // nonpainted tile

                    let consx = CGFloat(col) * tileSize.width - halfWidth + (tileSize.width/2)
                    let consy = CGFloat(row) * tileSize.height - halfHeight + (tileSize.height/2)

                    let newPoint: CGPoint = CGPoint(x: consx, y: consy )
                    let newPointConverted: CGPoint = self.convert(newPoint, from: tileMap)
                    arrayOfAvailableSpots.append(newPointConverted)
                }

            }
        }
    }
    func initButtons() {
        // ***LEFT BUTTON***//
        leftButton = SKSpriteNode(imageNamed: "left")
        leftButton.position = CGPoint(x: -30, y: -180)
        leftButton.setScale(0.2)
        addChild(leftButton)

        // ***RIGHT BUTTON***//
        rightButton = SKSpriteNode(imageNamed: "right")
        rightButton.position = CGPoint(x: 30, y: -180)
        rightButton.setScale(0.2)
        addChild(rightButton)

        // ***UP BUTTON***//
        upButton = SKSpriteNode(imageNamed: "up")
        upButton.position = CGPoint(x: 0, y: -150)
        upButton.setScale(0.2)
        addChild(upButton)

        // ***UP BUTTON***//
        downButton = SKSpriteNode(imageNamed: "down")
        downButton.position = CGPoint(x: 0, y: -210)
        downButton.setScale(0.2)
        addChild(downButton)

        // ***UP BUTTON***//
        bulletButton = SKSpriteNode(imageNamed: "bulletButton")
        bulletButton.position = CGPoint(x: 0, y: -180)
        bulletButton.setScale(0.2)
        addChild(bulletButton)
    }

    func createShoot(direction: Direction) {
        let bullet = SKSpriteNode(imageNamed: "bullet")
        bullet.physicsBody = SKPhysicsBody(texture: bullet.texture!, size: bullet.size)
        bullet.name = "bullet"
        addChild(bullet)
        switch direction {
        case .NONE:
            break
        case .LEFT:
            bullet.zRotation = CGFloat(180 * Double.pi / 180)
            bullet.physicsBody?.velocity = CGVector(dx: -50, dy: 0)
            bullet.position = CGPoint(x: self.playerSprite.position.x - 15, y: self.playerSprite.position.y)
        case .RIGHT:
            bullet.zRotation = CGFloat(0 * Double.pi / 180)
            bullet.physicsBody?.velocity = CGVector(dx: 50, dy: 0)
            bullet.position = CGPoint(x: self.playerSprite.position.x+15, y: self.playerSprite.position.y)
        case .UP:
            bullet.zRotation = CGFloat(90 * Double.pi / 180)
            bullet.physicsBody?.velocity = CGVector(dx: 0, dy: 50)
            bullet.position = CGPoint(x: self.playerSprite.position.x, y: self.playerSprite.position.y+15)
        case .DOWN:
            bullet.zRotation = CGFloat(270 * Double.pi / 180)
            bullet.physicsBody?.velocity = CGVector(dx: 0, dy: -50)
            bullet.position = CGPoint(x: self.playerSprite.position.x, y: self.playerSprite.position.y-15)
        }

        bullet.zPosition = 1

        bullet.physicsBody?.affectedByGravity = false
        bullet.physicsBody?.linearDamping = 0
        bullet.physicsBody?.categoryBitMask = 0x00000010

        bullet.physicsBody?.contactTestBitMask = 0x00000100
    }

    func spawnEnemy() {
        let startPosition = CGPoint(x: CGFloat.random(in: -95..<95), y: 85)
        let enemy : Enemy = Enemy(startPosition: startPosition)
        addChild(enemy)
        allEnemiesArray.append(enemy)
    }
}

// swiftlint:enable force_cast
