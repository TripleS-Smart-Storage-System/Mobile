//
//  BarcodeViewController.swift
//  TripleS
//
//  Created by Mykhailo Zorin on 17.11.2021.
//

import SwiftUI
import UIKit

struct ActivityIndicator: UIViewRepresentable {
    @Binding var isAnimating: Bool
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let v = UIActivityIndicatorView()
        return v
    }
    
    func updateUIView(_ activityIndicator: UIActivityIndicatorView, context: Context) {
        isAnimating ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
    }
}

struct PageControl: UIViewRepresentable {
    var numberOfPages: Int
    @Binding var currentPage: Int
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> UIPageControl {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = numberOfPages
        pageControl.addTarget(context.coordinator,
                              action: #selector(Coordinator.updateCurrentPage(sender:)),
                              for: .valueChanged)
        return pageControl
    }
    
    func updateUIView(_ pageControl: UIPageControl, context: Context) {
        pageControl.currentPage = currentPage
    }
    
    class Coordinator: NSObject {
        var pageControl: PageControl
        
        init(_ pageControl: PageControl) {
            self.pageControl = pageControl
        }
        
        @objc func updateCurrentPage(sender: UIPageControl) {
            pageControl.currentPage = sender.currentPage
        }
    }
}

struct PageViewController: UIViewControllerRepresentable {
  
//    var controllers: [UIViewController]
//    @Binding var currentPage: Int
    
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<PageViewController>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<PageViewController>) {
    }
    
//    class Coordinator: NSObject, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
//        var parent: PageViewController
//
//        init(_ pageViewController: PageViewController) {
//            self.parent = pageViewController
//        }
//
//        func pageViewController(
//            _ pageViewController: UIPageViewController,
//            viewControllerBefore viewController: UIViewController) -> UIViewController?
//        {
//            guard let index = parent.controllers.firstIndex(of: viewController) else {
//                return nil
//            }
//            if index == 0 {
//                return parent.controllers.last
//            }
//            return parent.controllers[index - 1]
//        }
//
//        func pageViewController(
//            _ pageViewController: UIPageViewController,
//            viewControllerAfter viewController: UIViewController) -> UIViewController?
//        {
//            guard let index = parent.controllers.firstIndex(of: viewController) else {
//                return nil
//            }
//            if index + 1 == parent.controllers.count {
//                return parent.controllers.first
//            }
//            return parent.controllers[index + 1]
//        }
//
//        func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
//            if completed,
//               let visibleViewController = pageViewController.viewControllers?.first,
//               let index = parent.controllers.firstIndex(of: visibleViewController)
//            {
//                parent.currentPage = index
//            }
//        }
//    }
}

