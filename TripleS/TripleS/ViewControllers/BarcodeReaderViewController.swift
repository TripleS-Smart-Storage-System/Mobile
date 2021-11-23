//
//  BarVC.swift
//  TripleS
//
//  Created by Mykhailo Zorin on 19.11.2021.
//

import UIKit
import AVFoundation

class BarcodeReaderViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    var videoLayer = AVCaptureVideoPreviewLayer()
    let captureSession = AVCaptureSession()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVideoLayer()
    }
    
    func setupVideoLayer() {
        
        let captureDevice = AVCaptureDevice.default(for: AVMediaType.video)
        
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice!)
            captureSession.addInput(input)
        } catch {
            print("SomeError")
        }
        
        let output = AVCaptureMetadataOutput()
        captureSession.addOutput(output)
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
        
        videoLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoLayer.frame = view.layer.bounds
    }
    
    func startRunning() {
        view.layer.addSublayer(videoLayer)
        captureSession.startRunning()
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        guard metadataObjects.count > 0 else { return }
        if let object = metadataObjects.first as? AVMetadataMachineReadableCodeObject {
            if object.type == AVMetadataObject.ObjectType.qr {
                let alert = UIAlertController(title: "QR", message: object.stringValue, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Go", style: .default, handler: { (action) in
                    print(object.stringValue ?? "No")
                }))
                alert.addAction(UIAlertAction(title: "Copy", style: .default, handler: { (action) in
                    UIPasteboard.general.string = object.stringValue
                    print(object.stringValue ?? "No")
                }))
                present(alert, animated: true, completion: nil)
            }
        }
    }
}
