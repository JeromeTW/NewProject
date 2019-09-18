//
//  BaseViewController.swift
//  DDTDemo
//
//  Created by Allen Lai on 2019/7/29.
//  Copyright © 2019 Allen Lai. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    // MARK: - ViewController lifecycle
    deinit {
        logger.log("\(self.className) deinit")
    }
    
    override func loadView() {
        super.loadView()
        logger.log("\(self.className) loadView")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logger.log("\(self.className) viewDidLoad")
        
        setupAuth()
        setupBaseUI()
        setupBinding()
        setupData()
        updateUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        logger.log("\(self.className) viewWillAppear:")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        logger.log("\(self.className) viewDidAppear:")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        logger.log("\(self.className) viewWillLayoutSubviews")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        logger.log("\(self.className) viewDidLayoutSubviews")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        logger.log("\(self.className) viewWillDisappear:")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        logger.log("\(self.className) viewDidDisappear:")
    }
    
    // MARK: - Inherit method
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    // MARK: - Public method
    func setupAuth() {
        logger.log("\(self.className) setupAuth")
    }
    
    func setupBaseUI() {
        logger.log("\(self.className) setupUI")
        
        view.backgroundColor = .white
        title = self.className
    }
    
    func setupBinding() {
        logger.log("\(self.className) setupBinding")
    }
    
    func setupData() {
        logger.log("\(self.className) setupData")
    }
    
    func updateUI() {
        logger.log("\(self.className) updateUI")
    }
}
