//
//  LLRainbowPopAnimator.swift
//  Pods
//
//  Created by Danis on 15/11/25.
//
//

class RainbowPopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    var animating = false
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
		// changed by cgi
		return TimeInterval(UINavigationControllerHideShowBarDuration)
	}
	
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        
        let fromColorSource = fromVC as? RainbowColorSource
        let toColorSource = toVC as? RainbowColorSource
        
        var nextColor:UIColor?
        nextColor = fromColorSource?.navigationBarOutColor?()
        nextColor = toColorSource?.navigationBarInColor?()
		
		// added by cgi
		var nextStatusBarColor:UIColor?
		nextStatusBarColor = fromColorSource?.statusBarOutMaskColor?()
		nextStatusBarColor = toColorSource?.statusBarInMaskColor?()
		
		var nextTintColor:UIColor?
		nextTintColor = fromColorSource?.tintOutColor?()
		nextTintColor = toColorSource?.tintInColor?()
		
		
        let containerView = transitionContext.containerView
        let shadowMask = UIView(frame: containerView.bounds)
        shadowMask.backgroundColor = UIColor.black
        shadowMask.alpha = 0.3
        
        let finalToFrame = transitionContext.finalFrame(for: toVC)
        toVC.view.frame = finalToFrame.offsetBy(dx: -finalToFrame.width/2, dy: 0)
        
        containerView.insertSubview(toVC.view, belowSubview: fromVC.view)
        containerView.insertSubview(shadowMask, aboveSubview: toVC.view)
        
        let duration = self.transitionDuration(using: transitionContext)
        
        animating = true
        UIView.animate(withDuration: duration, delay: 0, options: .curveLinear, animations: { () -> Void in
            fromVC.view.frame = fromVC.view.frame.offsetBy(dx: fromVC.view.frame.width, dy: 0)
            toVC.view.frame = finalToFrame
            shadowMask.alpha = 0
            if let navigationColor = nextColor {
                fromVC.navigationController?.navigationBar.rb.backgroundColor = navigationColor
				
				// added bei htr
				toVC.navigationController?.navigationBar.rb.backgroundColor = navigationColor
            }
			
			// added by cgi
			if let statusBarColor = nextStatusBarColor {
				fromVC.navigationController?.navigationBar.rb.statusBarColor = statusBarColor
				// added bei htr
				toVC.navigationController?.navigationBar.rb.statusBarColor = statusBarColor
			}
			
			if let tintColor = nextTintColor {
				fromVC.navigationController?.navigationBar.tintColor = tintColor
				// added bei htr
				toVC.navigationController?.navigationBar.tintColor = tintColor
			}
			
            }) { (finished) -> Void in
                self.animating = false
                shadowMask.removeFromSuperview()
                
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
