//
//  ViewController.swift
//  CoreDataRx
//
//  Created by Rogerio de Paula Assis on 1/11/19.
//  Copyright © 2019 Rogerio de Paula Assis. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Persistence
import Model

class ProductListViewController: UIViewController {

    private let repository = Env.productRepository
    private let bag = DisposeBag()

    @IBOutlet var tableView: UITableView!
    @IBOutlet var createNewButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.repository
            .fetchProducts()
            .bind(to: tableView.rx.items(
                cellIdentifier: ProductTableViewCell.storyboardIdentifier,
                cellType: UITableViewCell.self)) {  row, element, cell in
                    let title = element.title
                    cell.textLabel?.text = title
            }
            .disposed(by: bag)

        createNewButton.rx.tap
            .map { Product(uuid: UUID().uuidString, title: "User created") }
            .flatMap { [repository] p in repository.save(p).map { p } }
            .asDriver(onErrorDriveWith: .empty())
            .map { "New product added \($0.uuid)" }
            .drive()
            .disposed(by: bag)

        }
}

extension ProductListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let product: Product = try? tableView.rx.model(at: indexPath) else { return }
        let vc = ProductDetailViewController.configured(with: product)
        navigationController?.pushViewController(vc, animated: true)
    }
}
