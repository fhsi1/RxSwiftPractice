import Foundation
import RxSwift

let disposeBag = DisposeBag()

// MARK: - ignoreElements

print("-----ignoreElements-----")
let sleepMode๐ด = PublishSubject<String>()

sleepMode๐ด
    .ignoreElements() // next event ๋ฌด์
    .subscribe {
        print($0)
    }
    .disposed(by: disposeBag)

sleepMode๐ด.onNext("๐")
sleepMode๐ด.onNext("๐")
sleepMode๐ด.onNext("๐")

sleepMode๐ด.onCompleted() // completed

// MARK: - elementAt

print("-----elementAt-----")
let wakesUpAfterRingTwice = PublishSubject<String>()

wakesUpAfterRingTwice
    .element(at: 2)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

wakesUpAfterRingTwice.onNext("๐")
wakesUpAfterRingTwice.onNext("๐")
wakesUpAfterRingTwice.onNext("๐ณ") // element at index ๋ง ์ถ๋ ฅ
wakesUpAfterRingTwice.onNext("๐")

// MARK: - filter

print("-----filter-----")
Observable.of(1, 2, 3, 4, 5, 6, 7, 8) // [1, 2, 3, 4, 5, 6, 7, 8]
    .filter { $0 % 2 == 0 }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

// MARK: - skip

print("-----skip-----")
Observable.of("๐", "๐", "๐ฅน", "๐ค", "๐ป", "๐ป")
    .skip(5)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

// MARK: - skipWhile

print("-----skipWhile-----")

Observable.of("๐", "๐", "๐ฅน", "๐ค", "๐ป", "๐ป", "๐น", "๐ฆ")
    .skip(while: {
        $0 != "๐ป"
    })
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

// MARK: - skipUntil

print("-----skipUntil-----")

let guest = PublishSubject<String>()
let openTime = PublishSubject<String>()

guest
    .skip(until: openTime)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

guest.onNext("๐")
guest.onNext("๐คฉ")

openTime.onNext("Open!")
guest.onNext("๐ก")

// MARK: - take

print("-----take-----")

Observable.of("๐ฅ", "๐ฅ", "๐ฅ","๐", "๐")
    .take(3)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

// MARK: - takeWhile

print("-----takeWhile-----")

Observable.of("๐ฅ", "๐ฅ", "๐ฅ","๐", "๐")
    .take(while: {
        $0 != "๐ฅ"
    })
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

// MARK: - enumerated

print("-----enumerated-----")

Observable.of("๐ฅ", "๐ฅ", "๐ฅ","๐", "๐")
    .enumerated()
    .takeWhile {
        $0.index < 3
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

// MARK: - takeUntil

print("-----takeUntil-----")

let register = PublishSubject<String>()
let deadline = PublishSubject<String>()

register
    .take(until: deadline)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

register.onNext("๐๐ปโโ๏ธ")
register.onNext("๐๐ป")

deadline.onNext("The end!")
register.onNext("๐๐ผโโ๏ธ")


// MARK: - distinctUntilChanged

print("-----distinctUntilChanged")
Observable.of("I", "am", "am", "parrot", "parrot", "Am", "Am", "i", "parrot?", "parrot?")
    .distinctUntilChanged()
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)
