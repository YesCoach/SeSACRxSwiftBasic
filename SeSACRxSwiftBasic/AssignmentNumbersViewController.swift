//
//  AssignmentNumbersViewController.swift
//  SeSACRxSwiftBasic
//
//  Created by 박태현 on 2023/10/31.
//

import UIKit
import RxSwift
import RxCocoa

final class AssignmentNumbersViewController: UIViewController {

    @IBOutlet var numberTextField1: UITextField!
    @IBOutlet var numberTextField2: UITextField!
    @IBOutlet var numberTextField3: UITextField!
    
    @IBOutlet var resultLabel: UILabel!
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        // combineLatest
        //  Merges the specified observable sequences into one observable sequence by using the selector function whenever any of the observable sequences produces an element.
        // 특정 시퀀스들을 하나의 시퀀스로 병합

        Observable.combineLatest(
            numberTextField1.rx.text.orEmpty,
            numberTextField2.rx.text.orEmpty,
            numberTextField3.rx.text.orEmpty
        ) { text1, text2, text3 -> Int in
            return (Int(text1) ?? 0) + (Int(text2) ?? 0) + (Int(text3) ?? 0)
        }
        .map { $0.description } // Int를 문자열로 변환하는 메서드
        .bind(to: resultLabel.rx.text) // 방출된 이벤트 값을 label에 적용
        .disposed(by: disposeBag)
    }

}
