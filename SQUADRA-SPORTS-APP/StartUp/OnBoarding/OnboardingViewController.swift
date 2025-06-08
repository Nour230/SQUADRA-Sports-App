//
//  OnboardingViewController.swift
//  SQUADRA-SPORTS-APP
//
//  Created by Adham Mohamed on 03/06/2025.
//

import UIKit

class OnboardingViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    lazy var vcArray: [UIViewController] = {
        let storyBoard = UIStoryboard(name: "OnBoardingScreens", bundle: nil)
        
        let one = storyBoard.instantiateViewController(withIdentifier: "one")
        let two = storyBoard.instantiateViewController(withIdentifier: "two")
        let three = storyBoard.instantiateViewController(withIdentifier: "three")
        
        return [one,two,three]
    }()
    
    var currentPage = 0
    var pageindicappearance = UIPageControl.appearance(whenContainedInInstancesOf: [UIPageViewController.self])
    
    override func viewDidLayoutSubviews() {
        for subview in self.view.subviews {
            if subview is UIScrollView {
                subview.frame = self.view.bounds
            }
        }
        super.viewDidLayoutSubviews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageindicappearance.pageIndicatorTintColor = .lightGray
        pageindicappearance.currentPageIndicatorTintColor = .black
        self.dataSource = self
        if let vc = vcArray.first{
            self.setViewControllers([vc], direction: .forward, animated: true)
        }
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = vcArray.lastIndex(of: viewController) else { return nil }
        let previousIndex = index - 1
        guard previousIndex >= 0 else {return nil}
        guard previousIndex < vcArray.count else {return nil}
        currentPage = index - 1
        return vcArray[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = vcArray.lastIndex(of: viewController) else { return nil }
        let previousIndex = index + 1
        guard previousIndex >= 0 else {return nil}
        guard previousIndex < vcArray.count else {return nil}
        currentPage = index + 1
        return vcArray[previousIndex]
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return currentPage
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return vcArray.count
    }
    
    
}
