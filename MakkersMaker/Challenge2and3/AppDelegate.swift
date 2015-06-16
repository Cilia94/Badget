//
//  Makkers Maker
//  Major 4 - Devine Howest
//
//  Eliot Colinet & Cilia Vandenameele
//  Copyright (c) 2015. All rights reserved.

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var navVC: UINavigationController?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        switch NSUserDefaults.standardUserDefaults().integerForKey("lastPage") {
        case 0:
            self.navVC = NavViewController(rootViewController: ConceptUitlegVC());
        case 1:
            self.navVC = NavViewController(rootViewController: CompassVC());
        case 2:
            self.navVC = NavViewController(rootViewController: FreeDrinkVC());
        case 3:
            self.navVC = NavViewController(rootViewController: C2IntroVC());
        case 4:
            self.navVC = NavViewController(rootViewController: GSintroVC());
        case 5:
            self.navVC = NavViewController(rootViewController: TrakteerIntroVC());
        default:
            self.navVC = NavViewController(rootViewController: ConceptUitlegVC());
        }
        
        //self.navVC = NavViewController(rootViewController: self.mainVC!);
        
        
        self.navVC = NavViewController(rootViewController: ConceptUitlegVC());
        
        self.navVC!.navigationBar.hidden = true;
        self.navVC!.interactivePopGestureRecognizer.enabled = false
        
        window?.rootViewController = self.navVC
        
        self.window!.backgroundColor = UIColor.whiteColor()
        
        self.window!.makeKeyAndVisible()
        
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        /*if (NSUserDefaults.standardUserDefaults().integerForKey("user_id") != 0 && NSUserDefaults.standardUserDefaults().integerForKey("partner_id") == 0) {
        println("DELETE USER FROM DB! 1")
        var user_id = NSUserDefaults.standardUserDefaults().integerForKey("user_id")
        self.mainVC!.deleteUser(user_id)
        let p = NSUserDefaults.standardUserDefaults().integerForKey("lastPage")
        let appDomain = NSBundle.mainBundle().bundleIdentifier!
        NSUserDefaults.standardUserDefaults().removePersistentDomainForName(appDomain)
        NSUserDefaults.standardUserDefaults().setInteger(p, forKey: "lastPage")
        }*/
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        if (NSUserDefaults.standardUserDefaults().integerForKey("user_id") != 0 && NSUserDefaults.standardUserDefaults().integerForKey("partner_id") == 0) {
            var user_id = NSUserDefaults.standardUserDefaults().integerForKey("user_id")
            let loginVC = LoginVC(nibName: nil, bundle: nil)
            loginVC.deleteUser(user_id)
            println("[applicationDidEnterBackground] DELETED USER \(user_id) FROM DB!")
            let p = NSUserDefaults.standardUserDefaults().integerForKey("lastPage")
            let appDomain = NSBundle.mainBundle().bundleIdentifier!
            NSUserDefaults.standardUserDefaults().removePersistentDomainForName(appDomain)
            NSUserDefaults.standardUserDefaults().setInteger(p, forKey: "lastPage")
        }
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        if (NSUserDefaults.standardUserDefaults().integerForKey("lastPage") < 0 ) {
            println("applicationDidBecomeActive")
            let introVC = C1IntroVC(nibName: nil, bundle: nil)
            self.navVC!.pushViewController(introVC, animated: true)
        }
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

