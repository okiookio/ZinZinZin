//
//  SettingsViewController.swift
//  BasicCoordinator
//
//  Created by hsncr on 22.12.2020.
//

import UIKit
import Combine

final class SettingsViewController: BaseViewController {
    
    class ViewModel {
        let logoutSubject = PassthroughSubject<Bool, Never>()
        
        let presentSubject = PassthroughSubject<Void, Never>()
        
        let pushSubject = PassthroughSubject<Void, Never>()
        deinit {
            print(Self.self, #function)
        }
    }
    private var viewModel: ViewModel!
    public init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var stackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [label, logoutButton, presentButton, pushButton])
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.axis = .vertical
        return stackView
    }()

    private lazy var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "want some logout?"
        label.font = UIFont.systemFont(ofSize: 24)
        label.numberOfLines = 0
        return label
    }()

    private lazy var logoutButton: UIButton = {
        let button = UIButton(type: .system, primaryAction: UIAction(handler: { [unowned self] _ in
//            self.viewModel.logoutSubject.send(true)
            NotificationCenter.default.post(name: Notification.Name("UserLoggedOut"), object: nil)
        }))
        button.contentHorizontalAlignment = .center
        button.setTitle("Logout", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 22)
        return button
    }()
    
    private lazy var presentButton: UIButton = {
        let button = UIButton(type: .system, primaryAction: UIAction(handler: { [unowned self] _ in
            self.viewModel.presentSubject.send(())
        }))
        button.contentHorizontalAlignment = .center
        button.setTitle("Test Presenting", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 22)
        return button
    }()
    
    
    private lazy var pushButton: UIButton = {
        let button = UIButton(type: .system, primaryAction: UIAction(handler: { [unowned self] _ in
            self.viewModel.pushSubject.send(())
        }))
        button.contentHorizontalAlignment = .center
        button.setTitle("Test Pushing", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 22)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(stackView)
        view.backgroundColor = .white

        stackView.addConstraints(equalToSuperview(with: .init(top: 64,
                                                              left: 32,
                                                              bottom: -64,
                                                              right: -32)))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Settings"
    }
}
