//
//  AssignmentViewController.swift
//  SeSACRxSwiftBasic
//
//  Created by 박태현 on 2023/10/31.
//

import UIKit
import RxSwift
import RxCocoa

final class AssignmentViewController: UIViewController {

    @IBOutlet var tableView: UITableView!

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        let items = Observable.just(
            (0..<20).map { "\($0)" }
        )

        // MARK: bind
        // DataSource
        items
            .bind(to: tableView.rx.items(
                cellIdentifier: "Cell", cellType: UITableViewCell.self
            )) { (row, element, cell) in
                cell.textLabel?.text = "\(element) @ row \(row)"
            }
            .disposed(by: disposeBag)

        // Delegate
        // didSelectRowAt
        tableView.rx
            .modelSelected(String.self)
            .subscribe {
                print("Tapped - \($0)")
            }
            .disposed(by: disposeBag)

        // accessoryButtonTappedAt
        tableView.rx
            .itemAccessoryButtonTapped
            .subscribe(onNext: {
                print("Tapped Detail - \($0.section), \($0.row)")
            })
            .disposed(by: disposeBag)
    }
}
