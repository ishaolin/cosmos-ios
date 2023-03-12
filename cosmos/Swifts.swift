//
//  Swifts.swift
//  cosmos
//
//  Created by Michael Lynn on 2023/3/9.
//

import Foundation
import UIKit
import CommonUI

@objcMembers class Swifts : NSObject {
    public static func testOpenPage(from: UIViewController) {
        NavigationConfig.setup()
        
        let viewController = HomePageViewController()
        let navigationController = NavigationController(rootViewController: viewController)
        from.present(navigationController, animated: true, completion: nil)
    }
}

class HomePageViewController : BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "首页"
        self.view.backgroundColor = UIColor.green
        
        weak var wself = self
        self.navigationBar.navigationItem.leftBarButtonItem = BarButtonItem(title: "关闭", actionHandler: { (item: BarButtonItem?) in
            wself?.dismiss(animated: true, completion: nil)
        })
        
        self.navigationBar.navigationItem.rightBarButtonItem = BarButtonItem(title: "打开百度", actionHandler: { (item: BarButtonItem?) in
            let viewController = SecondaryViewController()
            wself?.navigationController?.pushViewController(viewController, animated: true)
        })
    }
}

class SecondaryViewController : BaseWebViewController {
    override func viewDidLoad() {
        self.url = "https://www.baidu.com/"
        super.viewDidLoad()
    }
    
    override func animatedTransitioningType() -> AnimatedTransitioningType {
        return .CoverHorizontal
    }
}
