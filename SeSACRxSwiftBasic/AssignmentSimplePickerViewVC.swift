//
//  AssignmentSimplePickerViewVC.swift
//  SeSACRxSwiftBasic
//
//  Created by 박태현 on 2023/10/31.
//

import UIKit
import RxSwift
import RxCocoa

final class AssignmentSimplePickerViewVC: UIViewController {

    @IBOutlet var topPickerView: UIPickerView!
    @IBOutlet var centerPickerView: UIPickerView!
    @IBOutlet var bottomPickerView: UIPickerView!

    private let disposBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Sequence 방출한 데이터를 피커뷰에 적용
        Observable.just([1, 2, 3])
            .bind(to: topPickerView.rx.itemTitles) { _, item in
                return "\(item)"
            }
            .disposed(by: disposBag)

        // PickerView Select 이벤트에 대한 구독
        topPickerView.rx.modelSelected(Int.self)
            .subscribe { models in
                print("models selected 1: \(models)")
            }
            .disposed(by: disposBag)

        // Sequence 방출한 데이터를 피커뷰에 적용 + NSAttributedString
        Observable.just([1, 2, 3])
            .bind(to: centerPickerView.rx.itemAttributedTitles) { _, item in
                return NSAttributedString(
                    string: "\(item)",
                    attributes: [
                        NSAttributedString.Key.foregroundColor: UIColor.cyan,
                        NSAttributedString.Key.underlineStyle: NSUnderlineStyle.double.rawValue
                    ]
                )
            }
            .disposed(by: disposBag)

        // PickerView Select 이벤트에 대한 구독
        centerPickerView.rx.modelSelected(Int.self)
            .subscribe { models in
                print("models selected 2: \(models)")
            }
            .disposed(by: disposBag)

        // Sequence 방출한 데이터를 피커뷰에 적용 + UIColor 타입, UIView
        Observable.just([UIColor.red, .green, .blue])
            .bind(to: bottomPickerView.rx.items) { _, item, _ in
                let view = UIView()
                view.backgroundColor = item
                return view
            }
            .disposed(by: disposBag)

        bottomPickerView.rx.modelSelected(UIColor.self)
            .subscribe {
                print("models selected 3: \($0)")
            }
            .disposed(by: disposBag)
    }

}
