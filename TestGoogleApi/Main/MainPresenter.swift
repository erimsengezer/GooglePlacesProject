//
//  MainPresenter.swift
//  TestGoogleApi
//
//  Created by Erim Şengezer on 23.05.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

protocol MainPresentationLogic {
    func presentSomething(response: Main.Something.Response)
}

class MainPresenter: MainPresentationLogic {
    weak var viewController: MainDisplayLogic?

    // MARK: - Do something

    func presentSomething(response: Main.Something.Response) {
        let viewModel = Main.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
}
