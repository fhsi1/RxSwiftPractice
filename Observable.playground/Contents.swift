import Foundation
import RxSwift

// MARK: - Observable 생성
print("-----just-----")
Observable<Int>.just(1)
    .subscribe(onNext: {
        print($0)
    })

print("-----of 1-----")
Observable<Int>.of(1, 2, 3, 4, 5)
    .subscribe(onNext: {
        print($0)
    })

print("-----of 2-----")
Observable.of([1, 2, 3, 4, 5])
    .subscribe(onNext: {
        print($0)
    })

print("-----from-----")
Observable.from([1, 2, 3, 4, 5])
    .subscribe(onNext: {
        print($0)
    })

print("-----empty 1-----")
Observable.empty()
    .subscribe {
        print($0)
    }

print("-----empty 2-----")
Observable<Void>.empty()
    .subscribe {
        print($0)
    }

print("-----empty 3-----")
Observable<Void>.empty()
    .subscribe(onNext: {
        
    },
    onCompleted: {
        print("completed")
    })

print("-----never 1-----")
Observable.never()
    .subscribe(
        onNext: {
            print($0)
        },
        onCompleted: {
            print("completed")
        }
    )

print("-----never 2-----")
Observable<Void>.never()
    .debug("never")
    .subscribe(
        onNext: {
            print($0)
        },
        onCompleted: {
            print("completed")
        }
    )

print("-----range-----")
Observable.range(start: 1, count: 9)
    .subscribe(onNext: {
        print("2 * \($0) = \(2 * $0)")
    })

print("-----create 1-----")
let disposeBag = DisposeBag()
Observable.create { observer -> Disposable in
    observer.onNext(1) // observer.on(.next(1))
    observer.onCompleted() // observer.on(.completed)
    observer.onNext(2) // complete 로 종료되었기 때문에 방출 x
    return Disposables.create()
}
.subscribe {
    print($0)
}
.disposed(by: disposeBag)

print("-----create 2-----")
enum myError: Error {
    case anError
}

Observable.create { observer -> Disposable in
    observer.onNext(1)
    observer.onError(myError.anError)
    observer.onCompleted()
    observer.onNext(2)
    return Disposables.create()
}
.subscribe(
    onNext: {
        print($0)
    },
    onError: {
        print($0.localizedDescription)
    },
    onCompleted: {
        print("completed")
    },
    onDisposed: {
        print("disposed")
    }
)
.disposed(by: disposeBag)

print("-----deferred 1-----")
Observable.deferred {
    Observable.of(1, 2, 3)
}
.subscribe {
    print($0)
}
.disposed(by: disposeBag)

print("-----deffered 2-----")
var flipOver: Bool = false

let factory: Observable<String> = Observable.deferred {
    flipOver = !flipOver
    
    if flipOver {
        return Observable.of("☝🏻")
    } else {
        return Observable.of("👇🏻")
    }
}

for _ in 0..<4 {
    factory.subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)
}

// MARK: - subscribe

print("-----subscribe1-----")
Observable.of(1, 2, 3)
    .subscribe {
        print($0)
    }

print("-----subscribe2-----")
Observable.of(1, 2, 3)
    .subscribe {
        if let element = $0.element {
            print(element)
        }
    }

print("-----subscribe3-----")
Observable.of(1, 2, 3)
    .subscribe(onNext: {
        print($0)
    })

// MARK: - dispose
print("-----dispose 1-----")
Observable.of(1, 2, 3)
    .subscribe(onNext: {
        print($0)
    })
    .dispose()

print("-----dispose 2-----")
Observable.of(1, 2, 3)
    .subscribe {
        print($0)
    }
    .dispose()

print("-----disposeBag-----")
//let disposeBag = DisposeBag()

Observable.of(1, 2, 3)
    .subscribe {
        print($0)
    }
    .disposed(by: disposeBag)
