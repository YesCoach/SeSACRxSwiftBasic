//
//  RxViewController.swift
//  SeSACRxSwiftBasic
//
//  Created by jack on 2023/10/23.
//

import UIKit
import RxSwift
import RxCocoa

class RxViewController: UIViewController {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var changeButton: UIButton!
    var nickname = Observable.just("고래밥")
    
    @IBOutlet var timerLabel: UILabel!
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nickname
            .subscribe { value in
                print(value)
            } onError: { error in
                print(error)
            } onCompleted: {
                print("nickname - onCompleted")
            } onDisposed: {
                print("nickname - Disposed")
            }
            .dispose()
 
        changeButton.rx.tap
            .subscribe { value in
                print("버튼 클릭 \(value)")
            } onError: { error in
                print("changeButton - onError")
            } onCompleted: {
                print("changeButton - onCompleted")
            } onDisposed: {
                print("changeButton - Disposed")
            }
            .disposed(by: disposeBag)
        
        Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
            .subscribe { value in
                print("value")
                self.timerLabel.text = "\(value)"
            } onError: { error in
                print("interval - \(error)")
            } onCompleted: {
                print("interval completed")
            } onDisposed: {
                print("interval disposed")
            }
            .disposed(by: disposeBag)

        sample()
    }

    func sample() {

        let item = [2, 3, 4, 5, 6, 7, 100]
        let item2 = [3, 5, 7]

        // just, of, from

        Observable.repeatElement("jack")
            .take(5)
            .subscribe { value in
                print("subscribe - \(value)")
            } onError: { error in
                print("error - \(error)")
            } onCompleted: {
                print("onCompleted")
            } onDisposed: {
                print("onDisposed")
            }
            .disposed(by: disposeBag)
    }
}
