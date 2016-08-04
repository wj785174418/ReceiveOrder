//
//  HtmlJumpSwift.swift
//  QueueCall
//
//  Created by HuayuNanyan on 16/6/23.
//
//

import UIKit

@objc(TrusitInteraction) class CDVInteraction: CDVPlugin {
    
    func pushViewController(command: CDVInvokedUrlCommand) {
        let rootVC = UIApplication.sharedApplication().keyWindow?.rootViewController as! UINavigationController
        let dict = command.arguments[0] as! NSDictionary
        
        let parameter = dict["parameter"] as? NSDictionary
        
        let className = dict["className"] as! String
        //获取appName
        let appName: String = NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleName") as! String
        let classStringName = "\(appName).\(className)"
        
        let classType: UIViewController.Type?
        
        if let anyClass = NSClassFromString(className) {
            classType = anyClass as? UIViewController.Type
            print("OC控制器")
        } else if let anyClass = NSClassFromString(classStringName) {
            classType = anyClass as? UIViewController.Type
            print("swift控制器")
        } else {
            print("无此控制器")
            return
        }
        let viewController = classType!.init()
        viewController.setValue(parameter, forKey: "parameter")
        rootVC.pushViewController(viewController, animated: true)
    }
    
    func userDefaults(command: CDVInvokedUrlCommand) {
        NSOperationQueue().addOperationWithBlock {
            
            if let key = command.arguments[0] as? String {
                let userDefaults = NSUserDefaults.standardUserDefaults()
                
                if let value = userDefaults.valueForKey(key) as? String {
                    var pluginResult: CDVPluginResult
                    pluginResult = CDVPluginResult.init(status: CDVCommandStatus_OK, messageAsString: value)
                    
                    //发送结果
                    self.commandDelegate.sendPluginResult(pluginResult, callbackId: command.callbackId)
                }
            }
        }
    }
}










