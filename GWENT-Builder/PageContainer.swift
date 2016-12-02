//
//  PageContainer.swift
//  GWENT-Builder
//
//  Created by Jose Carlos on 11/4/16.
//  Copyright © 2016 Jose Carlos. All rights reserved.
//

import Foundation
import UIKit
class PageContainer: UIViewController
{
    
    @IBOutlet var containerView: UIView!
    @IBOutlet var pageControl: UIPageControl!
    var cardSelectorPageController: CardSelectorPageController? {
        didSet {
            cardSelectorPageController?.selectorDelegate = self
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageControl.addTarget(self, action: #selector(PageContainer.didChangePageControlValue), for: .valueChanged)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let PageViewController = segue.destination as? CardSelectorPageController {
            PageViewController.selectorDelegate = self
        }
    }
    
    
    func didChangePageControlValue() {
        cardSelectorPageController?.scrollToViewController(index: pageControl.currentPage)
    }
}


extension PageContainer: CardSelectorPageControllerDelegate
{
    func PageViewController(PageViewController: CardSelectorPageController,
                                    didUpdatePageCount count: Int) {
        pageControl.numberOfPages = count
    }
    
    func PageViewController(PageViewController: CardSelectorPageController,
                                    didUpdatePageIndex index: Int) {
        pageControl.currentPage = index
    }
    
    
}
