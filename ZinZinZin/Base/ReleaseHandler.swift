//
//  DismissHandler.swift
//  BasicCoordinator
//
//  Created by hsncr on 20.12.2020.
//

import UIKit

public typealias ReleaseClosure = (() -> ())

// MARK: Release Handler
@objc public protocol ReleaseHandler:  UINavigationControllerDelegate {
    
    var keys: [String] { get }
    
    func configureRelease(for viewController: UIViewController,
                          using completion: @escaping ReleaseClosure)
    
    func configurePopRelease(for viewController: UIViewController,
                             using completion: @escaping ReleaseClosure)
    
    func completeRelease(for viewController: UIViewController)
    
    func removeRelease(for viewController: UIViewController)
    
}

extension ReleaseHandler {
    
    @discardableResult
    public func detectPopedController(on navigationController: UINavigationController) -> [String] {
        
        guard (navigationController.transitionCoordinator?.viewController(forKey: .from)) != nil else {
            return []
        }
        
        let missing = keys.filter { key in
            navigationController.viewControllers.contains { viewController in
                viewController.description == key
            } == false
        }
        
        return missing
    }
}
