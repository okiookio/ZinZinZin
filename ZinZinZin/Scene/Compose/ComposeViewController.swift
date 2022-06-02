//
//  ComposeViewController.swift
//  BasicCoordinator
//
//  Created by hsncr on 21.12.2020.
//

import UIKit
import Combine

final class ComposeViewController: BaseViewController {
    class ViewModel {
        let completed = PassthroughSubject<Bool, Never>()
        
        let present = PassthroughSubject<Void, Never>()
        deinit {
            print(Self.self, #function)
        }
    }
    
        
    private var viewModel: ViewModel!
    private let tab: Tab
    
    public init(tab: Tab, viewModel: ViewModel) {
        self.tab = tab
        self.viewModel = viewModel
        super.init()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var buttonContainerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [cancelButton, okButton])
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.spacing = 32
        return stackView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [label, buttonContainerStackView, presentTestButton, closeButton])
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.spacing = 32
        return stackView
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "You are about to create another \(tab.title). Are you sure?"
        label.font = UIFont.systemFont(ofSize: 24)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var okButton: UIButton = {
        let button = UIButton(type: .system, primaryAction: UIAction(handler: { [unowned self] _ in
            self.viewModel.completed.send(true)
        }))
        button.contentHorizontalAlignment = .center
        button.setTitle("OK", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 22)
        return button
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system, primaryAction: UIAction(handler: { [unowned self] _ in
//            self.viewModel.completed.send(false)
            NotificationCenter.default.post(name: Notification.Name("UserLoggedOut"), object: nil)
        }))
        button.contentHorizontalAlignment = .center
        button.setTitle("Cancel", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 22)
        return button
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system, primaryAction: UIAction(handler: { [unowned self] _ in
            self.dismiss(animated: true)
        }))
        button.contentHorizontalAlignment = .center
        button.setTitle("Dissmiss", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 22)
        return button
    }()
    private lazy var presentTestButton: UIButton = {
        let button = UIButton(type: .system, primaryAction: UIAction(handler: { [unowned self] _ in
            self.viewModel.present.send(())
        }))
        button.contentHorizontalAlignment = .center
        button.setTitle("Present Test", for: .normal)
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
        title = tab.title
    }
}
