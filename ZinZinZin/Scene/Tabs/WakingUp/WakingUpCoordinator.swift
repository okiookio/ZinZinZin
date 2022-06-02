//
//  WakingCoordinator.swift
//  BasicCoordinator
//
//  Created by hsncr on 22.12.2020.
//

import UIKit
import Combine


final class WakingUpCoordinator: BaseCoordinator<Void> {
    
    private lazy var viewModel: WakingUpViewController.ViewModel = {
        .init()
    }()
    private lazy var viewController: WakingUpViewController = {
        let viewController = WakingUpViewController(tab: tab, viewModel: viewModel)
        return viewController
    }()
    
    override var source: UIViewController  {
        get {
            router.navigationController.viewControllers = [viewController]
            return router.navigationController  
        }
        set {}
    }
    
    private let tab: Tab
    
    init(presenting navigationController: NavigationControllerReleaseHandler, tab: Tab) {
        
        self.tab = tab
        
        navigationController.tabBarItem = UITabBarItem(title: tab.title,
                                                       image: nil,
                                                       selectedImage: nil)
        
        super.init(presenting: navigationController)
    }
    
    override func start() -> AnyPublisher<Void, Never> {
        
        viewModel.openUrlSubject
            .flatMap { [unowned self] url in
                self.openUrl(url)
            }.sink(receiveValue: { _ in
                //
            })
            .store(in: &bag)
        
        let logoutAction = viewModel.settingsSubject
            .flatMap { _ in
                self.startSettings()
            }.filter { isLogout in
                isLogout == .loggedOut
            }.map { _ in () }
        
        return logoutAction
            .eraseToAnyPublisher()
    }
    
    private func openUrl(_ url: URL) -> AnyPublisher<Void, Never> {
        guard UIApplication.shared.canOpenURL(url) == true else {
            return Empty().eraseToAnyPublisher()
        }
        
        let coordinator = SafariCoordinator(presenting: router.navigationController, url: url)
        return present(to: coordinator)
    }
    
    private func startSettings() -> AnyPublisher<SettingsCoordinationResult, Never> {
        let coordinator = SettingsCoordinator(presenting: router.navigationController)
        return push(to: coordinator)
    }
}

