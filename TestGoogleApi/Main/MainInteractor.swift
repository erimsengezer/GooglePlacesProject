//
//  MainInteractor.swift
//  TestGoogleApi
//
//  Created by Erim Şengezer on 23.05.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

protocol MainBusinessLogic {
    func doSomething(request: Main.Something.Request)
}

protocol MainDataStore {
    // var name: String { get set }
}

class MainInteractor: MainBusinessLogic, MainDataStore {
    var presenter: MainPresentationLogic?
    var worker: MainWorker?
    // var name: String = ""

    // MARK: - Do something

    func doSomething(request: Main.Something.Request) {
        worker = MainWorker()
        worker?.doSomeWork()

        let response = Main.Something.Response()
        presenter?.presentSomething(response: response)
    }
}
