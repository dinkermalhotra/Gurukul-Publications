import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        IQKeyboardManager.shared.enable = true
        if UserDefaults.standard.string(forKey: user_Id) != nil {
            let initialViewControlleripad : UIViewController = storyboard.instantiateViewController(withIdentifier: STORYBOARDS_ID.HOME_VC) as UIViewController
            let navigationController = UINavigationController(rootViewController: initialViewControlleripad)
            self.window?.rootViewController = navigationController
            self.window?.makeKeyAndVisible()
        }else{
            let initialViewControlleripad : UIViewController = storyboard.instantiateViewController(withIdentifier: STORYBOARDS_ID.SIGNIN_VC) as UIViewController
            let navigationController = UINavigationController(rootViewController: initialViewControlleripad)
            self.window?.rootViewController = navigationController
            self.window?.makeKeyAndVisible()
        }
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.backgroundColor = #colorLiteral(red: 0.5333333333, green: 0, blue: 0.6078431373, alpha: 1)
            navBarAppearance.shadowImage = nil
            navBarAppearance.shadowColor = nil
            navBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            UINavigationBar.appearance(whenContainedInInstancesOf: [UINavigationController.self]).standardAppearance = navBarAppearance
            UINavigationBar.appearance(whenContainedInInstancesOf: [UINavigationController.self]).scrollEdgeAppearance = navBarAppearance
            
        }
        return true
    }
}

