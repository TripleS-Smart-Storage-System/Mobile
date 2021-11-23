//
//  BarcodeViewController.swift
//  TripleS
//
//  Created by Mykhailo Zorin on 17.11.2021.
//

import SwiftUI
import UIKit



struct BarcodeReaderVC: UIViewControllerRepresentable {
    
    @Binding var qrCode: String?
    
    func makeUIViewController(context: Context) -> BarcodeReaderViewController {
        let reader = BarcodeReaderViewController()
        return reader
    }
    
    func updateUIViewController(_ uiViewController: BarcodeReaderViewController, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate {
        
    }
}


// MARK: - ActivityIndicator
//
//ActivityIndicator(isAnimating: $isAnimating)
//
//struct ActivityIndicator: UIViewRepresentable {
//    @Binding var isAnimating: Bool
//
//    func makeUIView(context: Context) -> UIActivityIndicatorView {
//        return UIActivityIndicatorView()
//    }
//
//    func updateUIView(_ activityIndicator: UIActivityIndicatorView, context: Context) {
//        isAnimating ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
//    }
//}


// MARK: - PageViewController

//struct PageViewController: UIViewControllerRepresentable {
//
//    var controllers: [UIViewController]
//    @Binding var currentPage: Int
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//
//    func makeUIViewController(context: UIViewControllerRepresentableContext<PageViewController>) -> UIImagePickerController {
//        let picker = UIImagePickerController()
//        return picker
//    }
//
//    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<PageViewController>) {
//    }
//
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
//}
