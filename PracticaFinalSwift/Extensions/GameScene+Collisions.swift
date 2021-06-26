import Foundation
import SpriteKit
import GameplayKit
// swiftlint:disable force_cast
extension GameScene: SKPhysicsContactDelegate {

    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }
       
        
        
        guard let nameA = nodeA.name, let nameB = nodeB.name else { return }

        let oneNodeIsEnemy = nameA.hasPrefix("enemy") || nameB.hasPrefix("enemy")
        let oneNodeIsShoot = nameA == "bullet" || nameB == "bullet"
        let oneNodeIsBricks = nameA == "brick" || nameB == "brick"
        let oneNodeIsIron = nameA == "iron" || nameB == "iron"
        let oneNodeIsEnd = nameA.hasPrefix("end") || nameB.hasPrefix("end")
        let oneNodeIsBorder = nameA == "png" || nameB == "png"
        let oneNodeIsWater = nameA == "water" || nameB == "water"
        let oneNodeIsPlayer = nameA.hasPrefix("player") || nameB.hasPrefix("player")

        if oneNodeIsBricks, oneNodeIsShoot {
            nodeA.removeFromParent()
            nodeB.removeFromParent()
            return
        }

        if oneNodeIsBorder, oneNodeIsShoot {
            if nodeA.name == "bullet" { nodeA.removeFromParent()}
            else{ nodeB.removeFromParent() }
            return
        }

        if oneNodeIsShoot, oneNodeIsIron {
            if nodeA.name == "bullet" { nodeA.removeFromParent()}
            else{ nodeB.removeFromParent() }
            return
        }
        if oneNodeIsShoot, oneNodeIsWater {
            if nodeA.name == "bullet" { nodeA.removeFromParent()}
            else{ nodeB.removeFromParent() }
            return
        }
        if oneNodeIsShoot, oneNodeIsEnd {
            if nodeA.name == "bullet" { nodeA.removeFromParent()}
            else{ nodeB.removeFromParent() }
            self.view?.presentScene(newScene, transition: transition)
            return
        }
        if oneNodeIsShoot, oneNodeIsShoot {
            nodeA.removeFromParent()
            nodeB.removeFromParent()
        }
        if oneNodeIsShoot, oneNodeIsPlayer {
            if nodeA.name == "player" {
                createExplosion(position: nodeA.position)
                nodeA.removeAllActions()
                nodeA.removeAllChildren()
                nodeA.removeFromParent()
            }
            else {
                createExplosion(position: nodeB.position)
                nodeB.removeAllActions()
                nodeB.removeAllChildren()
                nodeB.removeFromParent()
            }
            self.view?.presentScene(newScene, transition: transition)
        }
        if oneNodeIsShoot, oneNodeIsEnemy {
            enemiesKilled += 1
            if nodeA.name == "enemy" {
                createExplosion(position: nodeA.position)
                nodeA.removeFromParent()
                nodeB.removeFromParent()
            }
            else {
                createExplosion(position: nodeB.position)
                nodeA.removeFromParent()
                nodeB.removeFromParent()
            }
            
            if (enemiesKilled >= maxEnemies)
            {
                newScene = SKScene(fileNamed: "WinScene")!
                newScene.scaleMode = .aspectFill
                self.view?.presentScene(newScene, transition: transition)
            }
            return
        }
        

    }
}
