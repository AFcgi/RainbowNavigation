//
//  LLRainbowNavigationDelegate.swift
//  Pods
//
//  Created by Danis on 15/11/25.
//
//

// added by cgi
public protocol RainbowNavigationDelegate: class {
	func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool)
}

open class RainbowNavigation: NSObject, UINavigationControllerDelegate {
    
    fileprivate weak var navigationController:UINavigationController?
    
    fileprivate var pushAnimator:RainbowPushAnimator = RainbowPushAnimator()
    fileprivate var popAnimator:RainbowPopAnimator = RainbowPopAnimator()
    fileprivate var dragPop:RainbowDragPop = RainbowDragPop()
	
	// added by cgi
	fileprivate weak var navigationDelegate: RainbowNavigationDelegate?

	
    override public init() {
        super.init()
        
        dragPop.popAnimator = popAnimator
    }
    
	// changed by cgi
	open func wireTo(navigationController nc : UINavigationController, navigationDelegate: RainbowNavigationDelegate?) {
        self.navigationController = nc
        self.dragPop.navigationController = nc
        self.navigationController?.delegate = self
		
		// added by cgi
		self.navigationDelegate = navigationDelegate
    }
    
    open func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .pop {
            return popAnimator
        }
        return pushAnimator
    }
    open func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        
        return dragPop.interacting ? dragPop : nil
    }
	
	// added by cgi
	
	open func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
		self.navigationDelegate?.navigationController(navigationController, willShow: viewController, animated: animated)
	}
}
