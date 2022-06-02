//
//  CreateCoordinator.swift
//  BasicCoordinator
//
//  Created by hsncr on 21.12.2020.
//

import UIKit
import Combine

final class ComposeCoordinator: BaseCoordinator<Bool> {
    
    private let tab: Tab
    
    private lazy var viewModel: ComposeViewController.ViewModel = {
        .init()
    }()
    private lazy var viewController: ComposeViewController = {
        let viewController = ComposeViewController(tab: tab, viewModel: viewModel)
        return viewController
    }()
    
    override var source: UIViewController  {
        get {
            router.navigationController.viewControllers = [viewController]
            return router.navigationController
        }
        set {}
    }
    
    init(presenting navigationController: NavigationController, tab: Tab) {
        self.tab = tab
        super.init(presenting: navigationController)
        self.source = viewController
    }
    
    override func start() -> AnyPublisher<Bool, Never> {
        
        let dismiss = viewModel.completed
        
        let multiplePresentResult = viewModel.present
            .eraseToAnyPublisher()
            .flatMap { _ -> AnyPublisher<Bool, Never> in
                let coordinator = ComposeCoordinator(presenting: NavigationController(),
                                                     tab: self.tab)
                return self.present(to: coordinator)
            }.filter { $0 == true }
        
        return Publishers.Merge(dismiss, multiplePresentResult)
            .eraseToAnyPublisher()
    }
}


