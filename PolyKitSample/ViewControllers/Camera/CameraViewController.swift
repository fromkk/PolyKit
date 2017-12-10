//
//  CameraViewController.swift
//  PolyAPI
//
//  Created by Kazuya Ueoka on 2017/12/08.
//  Copyright © 2017 fromkk. All rights reserved.
//

import UIKit
import ARKit
import SceneKit
import SceneKit.ModelIO
import ModelIO
import PolyKit

final class CameraViewController: UIViewController {
    
    var asset: PolyAsset!
    
    static func make(with asset: PolyAsset) -> CameraViewController {
        let cameraViewController = CameraViewController()
        cameraViewController.asset = asset
        return cameraViewController
    }
    
    var floors: [Floor] = []
    
    var node: SCNNode?
    
    lazy var sceneView: ARSCNView = {
        let view = ARSCNView()
        view.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        view.delegate = self
        return view
    }()
    
    override func loadView() {
        super.loadView()
        
        view.addSubview(sceneView, layouts: [
            sceneView.widthAnchor.constraint(equalTo: view.widthAnchor),
            sceneView.heightAnchor.constraint(equalTo: view.heightAnchor),
            sceneView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            sceneView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            ])
        
        sceneView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap(gesture:))))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Download obj and mtl files from Poly
        asset.downloadObj { (result) in
            switch result {
            case .success(let localUrl):
                let mdlAsset = MDLAsset(url: localUrl)
                mdlAsset.loadTextures()
                let node = SCNNode(mdlObject: mdlAsset.object(at: 0))
                node.scale = SCNVector3(0.5, 0.5, 0.5)
                node.rotation = SCNVector4(0.0, 1.0, 0.0, CGFloat(180.0).toRadians)
                
                self.node = node
            case .failure(let error):
                debugPrint(#function, "error", error)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        configuration.isLightEstimationEnabled = true
        sceneView.session.run(configuration, options: [.removeExistingAnchors, .resetTracking])
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        sceneView.session.pause()
    }
    
    @objc private func handleTap(gesture: UITapGestureRecognizer) {
        let tapPosition = gesture.location(in: sceneView)
        let hitPosition = sceneView.hitTest(tapPosition, types: [.existingPlane, .existingPlaneUsingExtent, .estimatedHorizontalPlane])
        
        guard let position = hitPosition.first else { return }
        
        let scenePosition = SCNVector3(position.worldTransform.columns.3.x,
                                       position.worldTransform.columns.3.y,
                                       position.worldTransform.columns.3.z)
        
        if let node = node {
            node.position = scenePosition
            
            if nil == node.parent {
                sceneView.scene.rootNode.addChildNode(node)
            }
        }
    }
}

extension CameraViewController: ARSCNViewDelegate {
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
        
        let floor = Floor(anchor: planeAnchor)
        node.addChildNode(floor)
        floors.append(floor)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        for floor in floors {
            if floor.anchor.identifier == anchor.identifier,
                let planeAnchor = anchor as? ARPlaneAnchor {
                floor.update(anchor: planeAnchor)
            }
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {
        for (index, floor) in floors.enumerated().reversed() {
            if floor.anchor.identifier == anchor.identifier {
                floors.remove(at: index)
            }
        }
    }
    
}
