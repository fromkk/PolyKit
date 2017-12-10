//
//  Floor.swift
//  PolyAPI
//
//  Created by Kazuya Ueoka on 2017/12/08.
//  Copyright © 2017 fromkk. All rights reserved.
//

import SceneKit
import ARKit

class Floor: SCNNode {
    var anchor: ARPlaneAnchor
    var floor: SCNBox
    
    init(anchor: ARPlaneAnchor) {
        self.anchor = anchor
        self.floor = SCNBox(width: CGFloat(self.anchor.extent.x), height: 0.0001, length: CGFloat(self.anchor.extent.z), chamferRadius: 0.0)
        
        super.init()
        
        let color: SCNMaterial = SCNMaterial()
        color.diffuse.contents = UIColor(white: 1.0, alpha: 0.1)
        color.lightingModel = .constant
        
        self.floor.materials = [color]
        
        let boxShape: SCNPhysicsShape = SCNPhysicsShape(geometry: self.floor, options: nil)
        let boxNode: SCNNode = SCNNode(geometry: self.floor)
        boxNode.physicsBody = SCNPhysicsBody(type: .kinematic, shape: boxShape)
        boxNode.position = SCNVector3Make(self.anchor.center.x, 0, self.anchor.center.z)
        
        self.addChildNode(boxNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(anchor: ARPlaneAnchor) {
        self.floor.width = CGFloat(anchor.extent.x)
        self.floor.length = CGFloat(anchor.extent.z)
        self.position = SCNVector3Make(anchor.center.x, 0, anchor.center.z)
        
        if let node = childNodes.first {
            let boxShape: SCNPhysicsShape = SCNPhysicsShape(geometry: self.floor, options: nil)
            node.physicsBody = SCNPhysicsBody(type: .kinematic, shape: boxShape)
        }
    }
}
