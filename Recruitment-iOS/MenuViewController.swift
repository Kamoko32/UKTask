import UIKit

class MenuViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setTheme()
    }

    private func setTheme() {
        tabBar.unselectedItemTintColor = .black
    }
}
