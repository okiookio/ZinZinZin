//
//  SplashCoordinator.swift
//  BasicCoordinator
//
//  Created by hsncr on 21.12.2020.
//

import UIKit
import Combine

final class SplashCoordinator: BaseCoordinator<Void> {
    
    lazy var viewModel: SplashViewController.ViewModel = {
        return .init()
    }()
    lazy var viewController = {
        return SplashViewController(viewModel: viewModel)
    }()
    
    override var source: UIViewController  {
        get { viewController }
        set {}
    }
    
    override func start() -> AnyPublisher<Void, Never> {
        return viewModel.completedSubject
            .map { _ in () }
            .eraseToAnyPublisher()
    }
}
