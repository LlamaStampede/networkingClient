//
//  GameViewController.swift
//  TestClient
//
//  Created by Tyler Chermely on 8/3/17.
//  Copyright © 2017 TylerC. All rights reserved.
//

import UIKit
import SwiftSocket

class GameViewController: UIViewController {

    var client : TCPClient?
    var timer : Timer = Timer()
    
    @IBAction func connectToServer(_ sender: Any) {
        client = TCPClient(address: "18.187.5.181", port: 8080)
        
        switch client?.connect(timeout: 10) {
        case .success?:
            scheduledTimerWithTimeInterval()
            print("Connection Success")
        case .failure(let error)?:
            print(error)
        default:
            print("Unknown error")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func scheduledTimerWithTimeInterval(){
        // Scheduling timer to Call the function "updateCounting" with the interval of 1 seconds
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateCounting), userInfo: nil, repeats: true)
    }
    
    //Check for messages from server
    func updateCounting()
    {
        if let data = client?.read(1024*10, timeout: 1)
        {
            if let response = String(bytes: data, encoding: .utf8)
            {
                print(response)
            }
        }
    }
}
