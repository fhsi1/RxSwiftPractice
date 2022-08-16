import Foundation
import RxSwift

let disposeBag = DisposeBag()

// MARK: - ignoreElements

print("-----ignoreElements-----")
let sleepMode😴 = PublishSubject<String>()

sleepMode😴
    .ignoreElements() // next event 무시
    .subscribe {
        print($0)
    }
    .disposed(by: disposeBag)

sleepMode😴.onNext("🔊")
sleepMode😴.onNext("🔊")
sleepMode😴.onNext("🔊")

sleepMode😴.onCompleted() // completed

// MARK: - elementAt

print("-----elementAt-----")
let wakesUpAfterRingTwice = PublishSubject<String>()

wakesUpAfterRingTwice
    .element(at: 2)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

wakesUpAfterRingTwice.onNext("🔊")
wakesUpAfterRingTwice.onNext("🔊")
wakesUpAfterRingTwice.onNext("😳") // element at index 만 출력
wakesUpAfterRingTwice.onNext("🔊")

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
Observable.of("😀", "🙃", "🥹", "🤓", "👻", "🐻")
    .skip(5)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

// MARK: - skipWhile

print("-----skipWhile-----")

Observable.of("😀", "🙃", "🥹", "🤓", "👻", "🐻", "🐹", "🦁")
    .skip(while: {
        $0 != "🐻"
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

guest.onNext("😊")
guest.onNext("🤩")

openTime.onNext("Open!")
guest.onNext("😡")

// MARK: - take

print("-----take-----")

Observable.of("🥇", "🥈", "🥉","🎖", "🏅")
    .take(3)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

// MARK: - takeWhile

print("-----takeWhile-----")

Observable.of("🥇", "🥈", "🥉","🎖", "🏅")
    .take(while: {
        $0 != "🥉"
    })
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

// MARK: - enumerated

print("-----enumerated-----")

Observable.of("🥇", "🥈", "🥉","🎖", "🏅")
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

register.onNext("🙋🏻‍♀️")
register.onNext("🙋🏻")

deadline.onNext("The end!")
register.onNext("🙋🏼‍♂️")


// MARK: - distinctUntilChanged

print("-----distinctUntilChanged")
Observable.of("I", "am", "am", "parrot", "parrot", "Am", "Am", "i", "parrot?", "parrot?")
    .distinctUntilChanged()
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)
