//
//  DetailViewController.swift
//  RiMo
//
//  Created by Javier Calartrava on 9/6/24.
//

import UIKit
import SwiftUI

final class DetailViewController: UIViewController {
    internal var viewModel: DetailViewModelProtocol?
    
    lazy var host: UIViewController = {
        guard var viewModel = viewModel as? DetailViewModel else { return UIViewController() }
        //viewModel.delegate = self
        return UIHostingController(rootView: DetailView(detailViewModel: viewModel))
    }()
    
    // MARK: - Initializers
    init(viewModel: DetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        self.viewModel = nil
        super.init(coder: aDecoder)
    }

    // MARK: - App Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - Private/Internal methods
    private func setupView() {
        self.title = "title_characterDetails".localized
        addChild(host)
        view.addSubview(host.view)
        host.didMove(toParent: self)
        host.view.frame = view.frame
    }

}
