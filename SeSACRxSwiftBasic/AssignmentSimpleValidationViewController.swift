//
//  AssignmentSimpleValidationViewController.swift
//  SeSACRxSwiftBasic
//
//  Created by 박태현 on 2023/10/31.
//

import UIKit
import RxSwift

final class AssignmentSimpleValidationViewController: UIViewController {

    private let minimalUsernameLength = 5
    private let minimalPasswordLength = 5

    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var usernameValidLabel: UILabel!

    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var passwordValidLabel: UILabel!

    @IBOutlet var submitButton: UIButton!

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        usernameValidLabel.text = "유저 이름은 적어도 \(minimalUsernameLength)자 이상이여야 합니다"
        passwordValidLabel.text = "패스워드는 적어도 \(minimalPasswordLength)자 이상이어야 합니다"

        let usernameValid = usernameTextField.rx.text.orEmpty
            .map { $0.count >= self.minimalUsernameLength }
            .share(replay: 1)

        let passwordValid = passwordTextField.rx.text.orEmpty
            .map { $0.count >= self.minimalPasswordLength }
            .share(replay: 1)

        let everyThingValid = Observable.combineLatest(
            usernameValid,
            passwordValid
        ) { $0 && $1 }
            .share(replay: 1)

        usernameValid
            .bind(to: passwordValidLabel.rx.isEnabled)
            .disposed(by: disposeBag)

        usernameValid
            .bind(to: usernameValidLabel.rx.isHidden)
            .disposed(by: disposeBag)

        passwordValid
            .bind(to: usernameValidLabel.rx.isHidden)
            .disposed(by: disposeBag)

        everyThingValid
            .bind(to: submitButton.rx.isEnabled)
            .disposed(by: disposeBag)

        submitButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.showAlert()
            })
            .disposed(by: disposeBag)
    }

    func showAlert() {
        let alert = UIAlertController(
            title: "RxExample",
            message: "This is wonderful",
            preferredStyle: .alert
        )
        let defaultAction = UIAlertAction(title: "Ok",
                                          style: .default,
                                          handler: nil)
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
    }

}
