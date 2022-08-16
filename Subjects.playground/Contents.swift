import Foundation
import RxSwift

let disposeBag = DisposeBag()

// MARK: - PublishSubject

print("-----publishSubject-----")
let publishSubject = PublishSubject<String>()

publishSubject.onNext("1. Hello, everyone!")

let subscriber1 = publishSubject
    .subscribe(onNext: {
        print("1st subscriber: ", $0)
    })

publishSubject.onNext("2. Can you hear me?")
publishSubject.on(.next("3. Can't you hear me?"))

subscriber1.dispose()

let subscriber2 = publishSubject
    .subscribe(onNext: {
        print("2nd subscriber: ", $0)
    })

publishSubject.onNext("4. Hello!")
publishSubject.onCompleted()

publishSubject.onNext("5. Are you done?")

subscriber2.dispose()

publishSubject
    .subscribe {
        print("3rd subscriber:", $0.element ?? $0)
    }
    .disposed(by: disposeBag)

publishSubject.onNext("6. Will it be printed?")

// MARK: - BehaviorSubject

print("-----behaviorSubject-----")

enum SubjectError: Error {
    case error1
}

let behaviorSubject = BehaviorSubject<String>(value: "0. init")
behaviorSubject.onNext("1. 1st value")

behaviorSubject.subscribe {
    print("1st subscriber: ", $0.element ?? $0)
}
.disposed(by: disposeBag)

behaviorSubject.onError(SubjectError.error1)

behaviorSubject.subscribe {
    print("2nd subscriber: ", $0.element ?? $0)
}
.disposed(by: disposeBag)

//let value = try? behaviorSubject.value()
//print(value)

// MARK: - ReplaySubject
let replaySubject = ReplaySubject<String>.create(bufferSize: 2)

replaySubject.onNext("1. Everyone,")
replaySubject.onNext("2. stay storng!")
replaySubject.onNext("3. difficult but")

replaySubject.subscribe {
    print("1st subscriber: ", $0.element ?? $0)
}
.disposed(by: disposeBag)

replaySubject.subscribe {
    print("2nd subscriber: ", $0.element ?? $0)
}
.disposed(by: disposeBag)

replaySubject.onNext("4. You can do it!")

replaySubject.onError(SubjectError.error1)
replaySubject.dispose()

replaySubject.subscribe {
    print("3nd subscriber: ", $0.element ?? $0)
}
.disposed(by: disposeBag)
