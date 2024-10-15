//
//  ViewController.swift
//  PuzzlePastry
//
//  Created by Андрей Сторожко on 02.09.2024.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let backgroundImageView = UIImageView(image: UIImage(named: "loaderBackground"))
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.frame = view.bounds
        backgroundImageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(backgroundImageView, at: 0)
        
        let loadingView = OnboardingScreen(viewModel: .init())
        let hostingController = UIHostingController(rootView: loadingView)
                
        addChild(hostingController)
        view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)

        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func openApp() {
        DispatchQueue.main.async {
            print("ViewController openApp()")
            let view = RootScreen()
            let hostingController = UIHostingController(rootView: view)
            self.setRootViewController(hostingController)
        }
    }
    
    func openWeb(stringURL: String) {
        DispatchQueue.main.async {
            print("ViewController openWeb()")
            let webView = ADJWebHandler(url: stringURL)
            self.setRootViewController(webView)
        }
    }
    
    func setRootViewController(_ viewController: UIViewController) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.window?.rootViewController = viewController
        }
    }
    
    func createURL(mainURL: String, deviceID: String, advertiseID: String) -> (String) {
        var url = ""
        
        url = "\(mainURL)?cmgj=\(deviceID)&qihy=\(advertiseID)"
        
        return url
    }
}
