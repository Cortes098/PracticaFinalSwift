import SpriteKit
import GameplayKit
import AVFAudio

// swiftlint:disable force_cast
// swiftlint:disable for_where

class GameScene: SKScene {

    var player: SKSpriteNode!

    // ***BUTTONS VARIABLES***//
    enum Direction {
        case NONE, LEFT, RIGHT, UP, DOWN
    }    
    var newScene = SKScene()
    var transition = SKTransition()
    var createdEnemies : Int = 0
    let startSound = SKAudioNode(fileNamed: "startSound")
    var leftButton: SKSpriteNode!
    var rightButton: SKSpriteNode!
    var upButton: SKSpriteNode!
    var downButton: SKSpriteNode!
    var bulletButton: SKSpriteNode!

    var isTouchingButton: Bool = false
    var input: Direction = .RIGHT

    var arrayOfAvailableSpots = [CGPoint]()

    var playerSprite: SKSpriteNode = SKSpriteNode()
    var moveAction: SKAction = SKAction(named: "playerTank")!
    var playerVelocity: Int = 20
    
    var enemiesKilled : Int = 0
    let maxEnemies : Int = 10
    override func didMove(to view: SKView) {
        newScene = SKScene(fileNamed: "EndGameScene")!
        transition = SKTransition.fade(withDuration: 1)
       
        run(SKAction.repeatForever(SKAction.sequence([
            SKAction.run {( self.spawnEnemy() )},
            SKAction.wait(forDuration: 5)
            ])))
        newScene.scaleMode = .aspectFill
        backgroundColor = UIColor.init(red: 46/255, green: 46/255, blue: 46/255, alpha: 1)
        initButtons()

        for node in self.children {

            if node is SKTileMapNode {
                if let theMap: SKTileMapNode = node as? SKTileMapNode {
                    setUpSceneWithMap(map: theMap)
                }
            }

        }
        if self.childNode(withName: "Player") != nil {

            playerSprite = self.childNode(withName: "Player") as! SKSpriteNode
            playerSprite.physicsBody = SKPhysicsBody(texture: playerSprite.texture!, size: CGSize(width: 7, height: 7))
            playerSprite.physicsBody?.affectedByGravity = false
            playerSprite.physicsBody?.allowsRotation = false
            playerSprite.physicsBody?.linearDamping = 0
            playerSprite.name = "player"

        }

        self.physicsWorld.contactDelegate = self
        if startSound.parent == nil{self.addChild(startSound)}        
    }

    func touchDown(atPoint pos: CGPoint) {

    }

    func touchMoved(toPoint pos: CGPoint) {

    }

    func touchUp(atPoint pos: CGPoint) {

    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        for touch in touches {
            if !isTouchingButton {
                let location = touch.location(in: self)

                if leftButton.contains(location) {
                    isTouchingButton = true
                    playerSprite.zRotation = CGFloat(180 * Double.pi / 180)
                    playerSprite.physicsBody?.velocity = CGVector(dx: -playerVelocity, dy: 0)
                    playerSprite.run(moveAction, withKey: "playerTank")
                    input = .LEFT
                } else if rightButton.contains(location) {
                    isTouchingButton = true
                    playerSprite.zRotation = CGFloat(0 * Double.pi / 180)
                    playerSprite.physicsBody?.velocity = CGVector(dx: playerVelocity, dy: 0)
                    playerSprite.run(moveAction, withKey: "playerTank")
                    input = .RIGHT
                } else if upButton.contains(location) {
                    isTouchingButton = true
                    playerSprite.zRotation = CGFloat( 90 * Double.pi / 180)
                    playerSprite.physicsBody?.velocity = CGVector(dx: 0, dy: playerVelocity)
                    playerSprite.run(moveAction, withKey: "playerTank")
                    input = .UP
                } else if downButton.contains(location) {
                    isTouchingButton = true
                    playerSprite.zRotation = CGFloat( 270 * Double.pi / 180)
                    playerSprite.physicsBody?.velocity = CGVector(dx: 0, dy: -playerVelocity)
                    playerSprite.run(moveAction, withKey: "playerTank")
                    input = .DOWN
                } else if bulletButton.contains(location) {
                    createShoot(direction: input)
                }
            }
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)

            if leftButton.contains(location) {
                isTouchingButton = false
                playerSprite.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                playerSprite.removeAction(forKey: "playerTank")
            } else if rightButton.contains(location) {
                isTouchingButton = false
                playerSprite.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                playerSprite.removeAction(forKey: "playerTank")
            } else if upButton.contains(location) {
                isTouchingButton = false
                playerSprite.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                playerSprite.removeAction(forKey: "playerTank")
            } else if downButton.contains(location) {
                isTouchingButton = false
                playerSprite.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                playerSprite.removeAction(forKey: "playerTank")
            }
        }
    }

    override func update(_ currentTime: TimeInterval) {
    }
}
// swiftlint:disable force_cast
// swiftlint:enable for_where
