import SpriteKit
import GameplayKit
// swiftlint:disable force_cast
class EndGameScene: SKScene {
    var endSprite: SKSpriteNode = SKSpriteNode()
    var endAnim: SKAction = SKAction(named: "EndAnimation")!

    var newScene: SKScene = SKScene(fileNamed: "LevelOneScene")!
    var transition: SKTransition = SKTransition.fade(withDuration: 1)

    var retryButton: SKSpriteNode!
    var exitGame: SKSpriteNode!

    override func didMove(to view: SKView) {
        newScene.scaleMode = .aspectFill

        retryButton = SKSpriteNode(imageNamed: "Play Again")
        retryButton.position = CGPoint(x: -280, y: -480)
        retryButton.setScale(0.5)
        addChild(retryButton)

        exitGame = SKSpriteNode(imageNamed: "ExitGame")
        exitGame.position = CGPoint(x: 280, y: -480)
        exitGame.setScale(0.5)
        addChild(exitGame)

        backgroundColor = UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
        newScene.scaleMode = .aspectFill
        if self.childNode(withName: "EndSprite") != nil {
            endSprite = self.childNode(withName: "EndSprite") as! SKSpriteNode
            endSprite.run(endAnim)
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
                let location = touch.location(in: self)

                if retryButton.contains(location) {
                    self.view?.presentScene(self.newScene, transition: self.transition)
                } else if exitGame.contains(location) {
                    exit(0)
                }
        }
    }

    override func update(_ currentTime: TimeInterval) {

    }

}
// swiftlint:enable force_cast
