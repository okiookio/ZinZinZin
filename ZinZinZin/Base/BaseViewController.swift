//
//  BaseViewController.swift
//  BasicCoordinator
//
//  Created by hsncr on 20.12.2020.
//

import UIKit
import Combine

open class BaseViewController: UIViewController {
    var bag = Set<AnyCancellable>()
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    deinit {
        print(Self.self, #function)
    }
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    }
    
}
