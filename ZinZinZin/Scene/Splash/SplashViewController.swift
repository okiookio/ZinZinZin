//
//  SplashViewController.swift
//  BasicCoordinator
//
//  Created by hsncr on 21.12.2020.
//

import UIKit
import Combine


final class SplashViewController: BaseViewController {
    
    class ViewModel {
        let completedSubject = PassthroughSubject<Bool, Never>()
        deinit {
            print(Self.self, #function)
        }
    }
    
    var viewModel: ViewModel!
    
    init(viewModel: ViewModel, nibName nibNameOrNil: String? = nil, bundle nibBundleOrNil: Bundle? = nil) {
        super.init()
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: view.frame)
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .white
        imageView.image = UIImage(named: "LizardMan")
        return imageView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(imageView)
        
        imageView.addConstraints(equalToSuperview())
        
        navigationController?.setNavigationBarHidden(true,
                                                     animated: false)
        
        nextPage()
            .subscribe(viewModel.completedSubject)
            .store(in: &bag)
    }
    
    // do some work and publish an event
    private func nextPage() -> AnyPublisher<Bool, Never> {
        Just(true)
            .delay(for: .seconds(1), scheduler: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
