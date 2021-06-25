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
        let oneNodeIsPlayer = nameA.hasPrefix("player") || nameB.hasPrefix("player")

        if oneNodeIsBricks, oneNodeIsShoot {
            nodeA.removeFromParent()
            nodeB.removeFromParent()
            print("YEEEEEEEEEEEEEEEEEEY")
            return
        }

        if oneNodeIsBorder, oneNodeIsShoot {
            if nodeA.name == "bullet"
            {
                nodeA.removeFromParent()
            } else{ nodeB.removeFromParent()
                
            }
            
            print("YEEEEEEEEEEEEEEEEEEY")
            return
        }
        
        if oneNodeIsEnemy, oneNodeIsBricks {
            if nodeA.name == "enemy" {
                //let enemyReference = nodeA as! Enemy

            } else {
                //let enemyReference = nodeB as! Enemy
            }

            return
        }

        if oneNodeIsShoot, oneNodeIsIron {
            nodeB.removeFromParent()
            return
        }
        if oneNodeIsShoot, oneNodeIsEnd {
            return
        }

        // if oneNodeIsPlayer, oneNodeIsShoot {
            // nodeA.removeFromParent()
            // nodeB.removeFromParent()
            // print("YEEEEEEEEEEEEEEEEEEY")
            // return
        // }

    }
}
