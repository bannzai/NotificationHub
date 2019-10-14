//
//  PageViewController.swift
//  GitHubNotificationManager
//
//  Created by Yudai.Hirose on 2019/09/30.
//  Copyright © 2019 bannzai. All rights reserved.
//

import UIKit
import SwiftUI

struct PageViewController: UIViewControllerRepresentable {
    var viewControllers: [UIViewController]
    @Binding var currentPage: Int

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> UIPageViewController {
        let pageViewController = UIPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal
        )
        pageViewController.dataSource = context.coordinator
        pageViewController.delegate = context.coordinator
        return pageViewController
    }

    func updateUIViewController(_ pageViewController: UIPageViewController, context: Context) {
        if viewControllers.isEmpty {
            return
        }

        context.coordinator.parent = self
        switch viewControllers.count <= currentPage  {
        case true:
            // FIXME: Reset current page and page view content in order to setViewControllers -> currentPage
            pageViewController.setViewControllers([viewControllers[0]], direction: .forward, animated: false)
            currentPage = 0
        case false:
            pageViewController.setViewControllers([viewControllers[currentPage]], direction: .forward, animated: false)
        }
        
    }

    class Coordinator: NSObject, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
        var parent: PageViewController
        
        init(_ pageViewController: PageViewController) {
            self.parent = pageViewController
        }
        
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
            guard let index = parent.viewControllers.firstIndex(of: viewController) else {
                return nil
            }
            if index <= 0 {
                return nil
            }
            return parent.viewControllers[index - 1]
        }

        func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
            guard let index = parent.viewControllers.firstIndex(of: viewController) else {
                return nil
            }
            if index + 1 >= parent.viewControllers.endIndex {
                return nil
            }
            return parent.viewControllers[index + 1]
        }
        
        func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
            guard
                let displayedViewController = pageViewController.viewControllers?.first,
                let index = parent.viewControllers.firstIndex(of: displayedViewController)
                else {
                    return
            }
            parent.currentPage = index
        }
    }
}
