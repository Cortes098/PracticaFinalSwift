import SpriteKit
import GameplayKit
// swiftlint:disable force_cast
class LevelOneScene: SKScene {
    var newScene: SKScene = SKScene(fileNamed: "GameScene")!
    var transition: SKTransition = SKTransition.fade(withDuration: 1)

    var textNode: SKLabelNode = SKLabelNode()
    var tank1: SKSpriteNode = SKSpriteNode()
    var tank2: SKSpriteNode = SKSpriteNode()

    var moveAction: SKAction = SKAction(named: "playerTank")!

    override func didMove(to view: SKView) {
        backgroundColor = UIColor.black
        newScene.scaleMode = .aspectFill
        if self.childNode(withName: "TextNode") != nil {
            textNode = self.childNode(withName: "TextNode") as! SKLabelNode

        }
        if self.childNode(withName: "Tank1") != nil {
            tank1 = self.childNode(withName: "Tank1") as! SKSpriteNode
            tank1.run(SKAction.repeatForever(moveAction))
        }
        if self.childNode(withName: "Tank2") != nil {
            tank2 = self.childNode(withName: "Tank2") as! SKSpriteNode
            tank2.run(SKAction.repeatForever(moveAction))
        }

        let timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { _ in
            self.view?.presentScene(self.newScene, transition: self.transition)
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view?.presentScene(newScene, transition: transition)
    }
    override func update(_ currentTime: TimeInterval) {

    }
}
// swiftlint:enable force_cast
