//
//  PebbleWatchManager.swift
//  TriggertrapSLR
//
//  Created by Valentin Kalchev on 07/04/2015.
//  Copyright (c) 2015 Triggertrap Ltd. All rights reserved.
//

import UIKit

protocol WearableManagerDelegate {
    func watchDidTrigger()
}

class WearablesManager: NSObject {
    private var isRunning: Bool = false
    static let sharedInstance = WearablesManager()
    var delegate: WearableManagerDelegate?
    
    func startSession() {
        isRunning = true
        
        AppleWatchManager.sharedInstance.startSession()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(WearablesManager.watchDidTrigger), name: constWatchDidTrigger, object: nil)
    }
    
    func endSession() {
        isRunning = false
        
        AppleWatchManager.sharedInstance.stopSession()
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: constWatchDidTrigger, object: nil)
    }
    
    func isWearablesModeRunning() -> Bool {
        return self.isRunning
    }
    
    func watchDidTrigger() {
        onMain {
            self.delegate?.watchDidTrigger()
        }
    }
}