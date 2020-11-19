//
//  SongsPVC.swift
//  Lotr
//
//  Created by Natalija on 12/11/2020.
//  Copyright © 2020 Natalija. All rights reserved.
//

import UIKit

class SongsPVC: UIPageViewController, UIPageViewControllerDelegate{
    
    var pages = [UIViewController]()
    let pageControl = UIPageControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.dataSource = self
        self.delegate = self
        
        setPagesAndControl()
       
    }
    
    func setPagesAndControl(){
        let initialPage = 0
        let page1 = SongsVC()
        let page2 = Songs2VC()
        
        // add the individual viewControllers to the pageViewController
        pages.append(page1)
        pages.append(page2)
        setViewControllers([pages[initialPage]], direction: .forward, animated: true, completion: nil)
        
        // pageControl
        pageControl.frame = CGRect()
        pageControl.currentPageIndicatorTintColor = UIColor.black
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = initialPage
        
        self.view.addSubview(pageControl)
        
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pageControl.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -100),
            pageControl.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -20),
            pageControl.heightAnchor.constraint(equalToConstant: 20),
            pageControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
    }
    
}


extension SongsPVC: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        if let viewControllerIndex = pages.firstIndex(of: viewController) {
                if viewControllerIndex == 0 {
                    // wrap to last page in array
                    return pages.last
                } else {
                    // go to previous page in array
                    return pages[viewControllerIndex - 1]
                }
            }
            return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        if let viewControllerIndex = pages.firstIndex(of: viewController) {
               if viewControllerIndex < self.pages.count - 1 {
                   // go to next page in array
                   return pages[viewControllerIndex + 1]
               } else {
                   // wrap to first page in array
                   return pages.first
               }
           }
           return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
            
    // set the pageControl.currentPage to the index of the current viewController in pages
        if let viewControllers = pageViewController.viewControllers {
            if let viewControllerIndex = pages.firstIndex(of: viewControllers[0]) {
                self.pageControl.currentPage = viewControllerIndex
            }
        }
    }
}
