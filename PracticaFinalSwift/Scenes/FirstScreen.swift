import SpriteKit
import GameplayKit

// swiftlint:disable force_cast

class FirstScreen: SKScene {
    var mainmenu: SKSpriteNode = SKSpriteNode()
    var text: SKLabelNode = SKLabelNode()

    var tank1: SKSpriteNode = SKSpriteNode()
    var tank2: SKSpriteNode = SKSpriteNode()

    var firstTouch: Bool = false

    var moveAction: SKAction = SKAction(named: "playerTank")!

    var newScene: SKScene = SKScene(fileNamed: "LevelOneScene")!
    var transition: SKTransition = SKTransition.fade(withDuration: 1)

    let fadeAnim = SKAction.sequence([

        SKAction.fadeOut(withDuration: 0.5),
        SKAction.wait(forDuration: 0.5),
        SKAction.fadeIn(withDuration: 0.5),
        SKAction.wait(forDuration: 0.5)
    ])

    override func didMove(to view: SKView) {
        backgroundColor = UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
        newScene.scaleMode = .aspectFill
        if self.childNode(withName: "MainMenu") != nil {
            mainmenu = self.childNode(withName: "MainMenu") as! SKSpriteNode
            mainmenu.physicsBody = SKPhysicsBody(texture: mainmenu.texture!, size: mainmenu.size)
            mainmenu.physicsBody?.affectedByGravity = false
            mainmenu.physicsBody?.velocity = CGVector(dx: 0, dy: 300)
        }

        if self.childNode(withName: "Tank1") != nil {
            tank1 = self.childNode(withName: "Tank1") as! SKSpriteNode
            tank1.physicsBody = SKPhysicsBody(texture: tank1.texture!, size: tank1.size)
            tank1.physicsBody?.affectedByGravity = false
            tank1.physicsBody?.velocity = CGVector(dx: 0, dy: 300)
            tank1.run(moveAction, withKey: "playerTank")
            tank1.run(SKAction.repeatForever(moveAction))
        }

        if self.childNode(withName: "Tank2") != nil {
            tank2 = self.childNode(withName: "Tank2") as! SKSpriteNode
            tank2.physicsBody = SKPhysicsBody(texture: tank2.texture!, size: tank2.size)
            tank2.physicsBody?.affectedByGravity = false
            tank2.physicsBody?.velocity = CGVector(dx: 0, dy: 300)
            tank2.run(SKAction.repeatForever(moveAction))
        }

        if self.childNode(withName: "TextNode") != nil {
            text = self.childNode(withName: "TextNode") as! SKLabelNode
            text.alpha = 0

        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !firstTouch {
            mainmenu.position.y = 300
            text.run(SKAction.repeatForever(fadeAnim))
            tank1.position = CGPoint(x: tank1.position.x, y: 150)
            tank2.position = CGPoint(x: tank2.position.x, y: 150)
            tanksOut()
            } else if firstTouch {
            self.view?.presentScene(newScene, transition: transition)
        }

    }

    override func update(_ currentTime: TimeInterval) {
        if mainmenu.position.y >= 300 && !firstTouch {
            mainmenu.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            tanksOut()
            text.run(SKAction.repeatForever(fadeAnim))

            firstTouch = true
        }
        if firstTouch {

        }
    }

    func tanksOut() {
        sceneShake(shakeCount: 1, intensity: CGVector(dx: 0, dy: -2), shakeDuration: 0.1)
        tank1.physicsBody?.velocity = CGVector(dx: -100, dy: 0)
        tank1.zRotation = CGFloat(180 * Double.pi / 180)

        tank2.physicsBody?.velocity = CGVector(dx: 100, dy: 0)
        tank2.zRotation = CGFloat(0 * Double.pi / 180)
    }

    func sceneShake(shakeCount: Int, intensity: CGVector, shakeDuration: Double) {
           let sceneView = self.scene!.view! as UIView
           let shakeAnimation = CABasicAnimation(keyPath: "position")

           shakeAnimation.duration = shakeDuration / Double(shakeCount)
           shakeAnimation.repeatCount = Float(shakeCount)
           shakeAnimation.autoreverses = true
           shakeAnimation.fromValue = NSValue(cgPoint: CGPoint(x: sceneView.center.x - intensity.dx, y: sceneView.center.y - intensity.dy))
           shakeAnimation.toValue = NSValue(cgPoint: CGPoint(x: sceneView.center.x + intensity.dx, y: sceneView.center.y + intensity.dy))

           sceneView.layer.add(shakeAnimation, forKey: "position")
         }
}
// swiftlint:enable force_cast
