//
//  NarcoCoordinator.swift
//  BasicCoordinator
//
//  Created by hsncr on 22.12.2020.
//

import UIKit
import Combine


final class LizardCoordinator: BaseCoordinator<Void> {
    
    private let tab: Tab
    
    lazy var viewModel: LizardViewController.ViewModel = {
        return .init()
    }()
    lazy var viewController = {
        return LizardViewController(tab: tab, viewModel: viewModel)
    }()
    
    override var source: UIViewController  {
        get {
            router.navigationController.viewControllers = [viewController]
            return router.navigationController
        }
        set {}
    }
    
    init(presenting navigationController: NavigationControllerReleaseHandler, tab: Tab) {
        
        self.tab = tab
        
        navigationController.tabBarItem = UITabBarItem(title: tab.title,
                                                       image: nil,
                                                       selectedImage: nil)
        
        super.init(presenting: navigationController)
    }
    
    override func start() -> AnyPublisher<Void, Never> {
        
        viewModel.composeSubject
            .map { [unowned self] _ in self.tab }
            .flatMap { [unowned self] tab in
                self.startCompose(tab: tab)
            }.sink { [unowned self] result in
                if result == true {
                    self.viewController.numberOfItems += 1
                }
            }.store(in: &bag)
        
        return Publishers.Never()
            .eraseToAnyPublisher()
    }
    
    private func startCompose(tab: Tab) -> AnyPublisher<Bool, Never> {
        let coordinator = ComposeCoordinator(presenting: NavigationController(), tab: tab)
        return present(to: coordinator)
    }
}
