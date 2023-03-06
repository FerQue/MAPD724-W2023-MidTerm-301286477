import SpriteKit
import GameplayKit
import AVFoundation
import UIKit

class GameScene: SKScene
{
    var ocean1: Ocean?
    //var ocean2: Ocean?
    var player: Player?
    var island: Island?
    var clouds : [Cloud] = []
    
    override func sceneDidLoad()
    {
        name = "GAME"
        
        self.scene?.size.height = CGFloat(750.0)
        self.scene?.size.width = CGFloat(1626.0)
        
        ocean1 = Ocean()
        ocean1?.Reset()
        ocean1?.zRotation = -Double.pi/2
        addChild(ocean1!)
        
//        ocean2 = Ocean()
//        ocean2?.position.y = -627
//        addChild(ocean2!)
        
        player = Player()
        player?.zRotation = -Double.pi/2
        addChild(player!)
        
        island = Island()
        island?.zRotation = -Double.pi/2
        addChild(island!)
        
        
        for _ in 0...1
        {
            let cloud = Cloud()
            clouds.append(cloud)
            island?.zRotation = -Double.pi/2
            addChild(cloud)
        }
        
        let engineSound = SKAudioNode(fileNamed: "engine.mp3")
        addChild(engineSound)
        engineSound.autoplayLooped = true
        engineSound.run(SKAction.changeVolume(to: 0.5, duration: 0))

        
        do
        {
            let sounds: [String] = ["thunder", "yay"]
            for sound in sounds
            {
                let path: String = Bundle.main.path(forResource: sound, ofType: "mp3")!
                let url:URL = URL(fileURLWithPath: path)
                let avPlayer: AVAudioPlayer = try AVAudioPlayer(contentsOf: url)
                avPlayer.prepareToPlay()
            }
        }
        catch
        {
            
        }
    }
    
    func touchDown(atPoint pos : CGPoint)
    {
        player?.TouchMove(newPos: CGPoint(x: -640, y: pos.y))
        //player?.TouchMove(newPos: CGPoint(x: pos.x, y: -640))
    }
    
    func touchMoved(toPoint pos : CGPoint)
    {
        player?.TouchMove(newPos: CGPoint(x: -640, y: pos.y))
        //player?.TouchMove(newPos: CGPoint(x: pos.x, y: -640))
    }
    
    func touchUp(atPoint pos : CGPoint)
    {
        player?.TouchMove(newPos: CGPoint(x: -640, y: pos.y))
        //player?.TouchMove(newPos: CGPoint(x: pos.x, y: -640))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval)
    {
        ocean1?.Update()
        //ocean2?.Update()
        player?.Update()
        island?.Update()
        
        CollisionManager.SquaredRadiusCheck(scene: self, object1: player!, object2: island!)
        
        for cloud in clouds
        {
            cloud.Update()
            CollisionManager.SquaredRadiusCheck(scene: self, object1: player!, object2: cloud)
        }
        
    }
    
//    override func didMove[to view: SKView]
//    {
//        Player?.position = CGPoint(x: 300, y: 300)
//        Player?.setScale(0.25)
//        Player?.zRotation = CGFloat(-M_PI_2)
//        addChild(Player)
//    }
}
