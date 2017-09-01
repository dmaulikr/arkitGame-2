//
//  ViewController.swift
//  arkitGame
//
//  Created by Александр Менщиков on 31.08.17.
//  Copyright © 2017 Александр Менщиков. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    var previousPoint: SCNVector3?
    var buttonHighlighted = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.delegate = self
        sceneView.showsStatistics = true
        
        let scene = SCNScene()
        sceneView.scene = scene
        
        spawnShape()
        spawnShape()
        spawnShape()
        spawnShape()
        spawnShape()
        spawnShape()
        spawnShape()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
    
    func spawnShape() {
        var geometry:SCNGeometry
        switch ShapeType.random() {
            case .sphere:
                geometry = SCNSphere(radius: 0.05)
            case .pyramid:
                geometry = SCNPyramid(width: 0.05, height: 0.05, length: 0.05)
            default:
                geometry = SCNBox(width: 0.05, height: 0.05, length: 0.05, chamferRadius: 0.0)
        }
        let geometryNode = SCNNode(geometry: geometry)
        geometryNode.position = ShapeType.randomPosition()
        geometryNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
        
        let randomX = Float.random(min: -0.02, max: 0.02)
        let randomY = Float.random(min: 0.010, max: 0.018)
        let force = SCNVector3(x: randomX, y: randomY , z: 0)
        let position = SCNVector3(x: 0.00, y: 0.00, z: 0.00)
        geometryNode.physicsBody?.applyForce(force, at: position, asImpulse: true)
        
        sceneView.scene.rootNode.addChildNode(geometryNode)
        
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let geometryAnchor = anchor as? ARPlaneAnchor else { return }
        
        let geometry = SCNPlane(width: CGFloat(geometryAnchor.extent.x), height: CGFloat(geometryAnchor.extent.z))
        let geometryNode = SCNNode(geometry: geometry)
        
        
        geometryNode.position = SCNVector3Make(geometryAnchor.center.x, 0, geometryAnchor.center.z)
        geometryNode.transform = SCNMatrix4MakeRotation(-Float.pi / 2, 1, 0, 0)
        
        
        
        node.addChildNode(geometryNode)
    }
}
