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
    var pageViewControllers:[UIViewController] =
       [ UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DeckCardSelector") as! UIViewController , UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CardSelector") as! UIViewController ]
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        
        if let firstViewController = pageViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
        
    }
    
    
    //Functions
    
}

extension CardSelectorPageController: UIPageViewControllerDataSource
{
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
        
        return nil
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        
        guard let viewControllerIndex = pageViewControllers.index(of: viewController ) else {
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
    
    //Dots 
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pageViewControllers.count
    }
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first else {return 0} 
        guard let firstViewControllerIndex = pageViewControllers.index(of: firstViewController) else {
            return 0
        }
        return firstViewControllerIndex
    }
    
    
    
    
    
    
    
}
