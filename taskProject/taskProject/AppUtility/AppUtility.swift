//
//  AppUtility.swift
//  taskProject
//
//  Created by Anjali bhatt on 27/04/24.
//

import Foundation
import UIKit

class AppUtility: NSObject {
    
    //MARK:- variables
    static var navigationBarAppearace = UINavigationBar.appearance()
    //MARK:- statusbar methods
    class func setStatusBarBackgroundColor(isNavigation: Bool) {
        var statusBar = UIView()
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first(where: { $0.isKeyWindow }) {
            // Use window here
        
        if #available(iOS 13.0, *) {
            statusBar = UIView(frame: window.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero)
            window.addSubview(statusBar)
        } else {
            guard let statusBarTemp = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView else { return }
            statusBar = statusBarTemp
        }
        statusBar.backgroundColor = .lightGray
        }
    }
    //MARK:- navigation bar methods
    class  func setNavigationbarColor(){
        // setup navBar.....
        UINavigationBar.appearance().barTintColor = .white
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().isTranslucent = false
    }
}
