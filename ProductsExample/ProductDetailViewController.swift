//
//  ProductDetailViewController.swift
//  CoreDataRx
//
//  Created by Rogerio de Paula Assis on 1/12/19.
//  Copyright © 2019 Rogerio de Paula Assis. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Model
import Persistence

class ProductDetailViewController: UIViewController {

    private var product: Product!
    private let repository = Env.productRepository
    private var bag = DisposeBag()

    @IBOutlet var textField: UITextField!
    @IBOutlet var saveButton: UIBarButtonItem!

    static func configured(with product: Product) -> Self {
        let vc = Storyboard.Main.instantiate(self)
        vc.product = product
        return vc
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        textField.text = product.title
        saveButton.rx.tap
            .withLatestFrom(textField.rx.text.orEmpty)
            .map { [unowned self] in Product(uuid: self.product.uuid, title: $0) }
            .flatMapLatest { [repository] in repository.save($0) }
            .asDriver(onErrorJustReturn: ())
            .do(onNext: { [navigationController] _ in
                navigationController?.popViewController(animated: true)
            })
            .drive()
            .disposed(by: bag)
    }
}
