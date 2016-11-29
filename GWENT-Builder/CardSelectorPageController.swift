//
//  CardSelectorPageController.swift
//  GWENT-Builder
//
//  Created by Jose Carlos on 11/3/16.
//  Copyright © 2016 Jose Carlos. All rights reserved.
//

import Foundation
import UIKit

class CardSelectorPageController:UIPageViewController
{
    
    //Properties 
    var selectorDelegate: CardSelectorPageControllerDelegate?
    var pageViewControllers:[UIViewController] =
       [ UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DeckCardSelector") , UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CardSelector") ]
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        selectorDelegate?.PageViewController( PageViewController: self, didUpdatePageCount: pageViewControllers.count)
        
        if let firstViewController = pageViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
    }
    //Functions
    func scrollToNextViewController() {
        if let visibleViewController = viewControllers?.first,
            let nextViewController = pageViewController(self, viewControllerAfter: visibleViewController){
            scrollToViewController(viewController: nextViewController)
            }
    }
    
    func scrollToViewController(index newIndex: Int) {
        if let firstViewController = viewControllers?.first,
            let currentIndex = pageViewControllers.index(of: firstViewController) {
            let direction: UIPageViewControllerNavigationDirection = newIndex >= currentIndex ? .forward : .reverse
            let nextViewController = pageViewControllers[newIndex]
            scrollToViewController(viewController: nextViewController, direction: direction)
        }
    }
    private func scrollToViewController(viewController: UIViewController,
                                        direction: UIPageViewControllerNavigationDirection = .forward) {
        setViewControllers([viewController],
                           direction: direction,
                           animated: true,
                           completion: { (finished) -> Void in
                            // Setting the view controller programmatically does not fire
                            // any delegate methods, so we have to manually notify the
                            // 'tutorialDelegate' of the new index.
                            self.notifyTutorialDelegateOfNewIndex()
        })
    }

    private func notifyTutorialDelegateOfNewIndex() {
        if let firstViewController = viewControllers?.first,
            let index = pageViewControllers.index(of: firstViewController) {
            selectorDelegate?.PageViewController(PageViewController: self,didUpdatePageIndex: index)
        }
    }
    


}

extension CardSelectorPageController: UIPageViewControllerDataSource , UIPageViewControllerDelegate
 {
    
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if let firstViewController = viewControllers?.first,
            let index = pageViewControllers.index(of: firstViewController) {
            selectorDelegate?.PageViewController(PageViewController: self,
                                                         didUpdatePageIndex: index)
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pageViewControllers.index(of: viewController ) else {
            return nil
        }
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = pageViewControllers.count
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        return pageViewControllers[nextIndex]
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pageViewControllers.index(of:viewController ) else{
            return nil
        }
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else{
            return nil
        }
        guard pageViewControllers.count > previousIndex else{
            return nil
        }
        return pageViewControllers[previousIndex]
    }
}

protocol CardSelectorPageControllerDelegate:class
{
    func PageViewController(PageViewController: CardSelectorPageController,
                                    didUpdatePageCount count: Int)
    func PageViewController(PageViewController: CardSelectorPageController,
                                    didUpdatePageIndex index: Int)
}








