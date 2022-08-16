import Foundation
import RxSwift

let disposeBag = DisposeBag()

// MARK: - toArray

print("-----toArray-----")

Observable.of("A", "B", "C")
    .toArray()
    .subscribe(onSuccess: {
        print($0)
    })
    .disposed(by: disposeBag)

// MARK: - map

print("-----map-----")

Observable.of(Date())
    .map { date -> String in
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        
        return dateFormatter.string(from: date)
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

// MARK: - flatMap

print("-----flatMap-----")

protocol player {
    var score: BehaviorSubject<Int> { get }
}

struct archer: player {
    var score: BehaviorSubject<Int>
}

let korea = archer(score: BehaviorSubject<Int>(value: 10))
let america = archer(score: BehaviorSubject<Int>(value: 8))

let olympic = PublishSubject<player>()

olympic
    .flatMap { player in
        player.score
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

olympic.onNext(korea)
korea.score.onNext(10)

olympic.onNext(america)
korea.score.onNext(10)
america.score.onNext(9)

// MARK: - flatMapLatest

print("-----flatMapLatest-----")

struct highJumper: player {
    var score: BehaviorSubject<Int>
}

let seoul = highJumper(score: BehaviorSubject<Int>(value: 7))
let jeju = highJumper(score: BehaviorSubject<Int>(value: 6))

let nationalChampionship = PublishSubject<player>()

nationalChampionship
    .flatMapLatest { player in
        player.score
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

nationalChampionship.onNext(seoul)
seoul.score.onNext(9)

nationalChampionship.onNext(jeju)
seoul.score.onNext(10)
jeju.score.onNext(8)


// MARK: - materialize and dematerialize

print("-----meterialize and demeterialize-----")

enum foul: Error {
    case falseStart
}

struct runner: player {
    var score: BehaviorSubject<Int>
}

let rabbit = runner(score: BehaviorSubject<Int>(value: 0))
let cheetah = runner(score: BehaviorSubject<Int>(value: 1))

let runningCompetition = BehaviorSubject<player>(value: rabbit)

runningCompetition
    .flatMapLatest { player in
        player.score
            .materialize()
    }
    .filter {
        guard let error = $0.error else {
            return true
        }
        print(error)
        return false
    }
    .dematerialize()
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

rabbit.score.onNext(1)
rabbit.score.onError(foul.falseStart)
rabbit.score.onNext(2)

runningCompetition.onNext(cheetah)

// MARK: - example

print("-----11 digit phone number-----")

let input = PublishSubject<Int?>()

let list: [Int] = [1]

input
    .flatMap {
        $0 == nil ? Observable.empty() : Observable.just($0)
    }
    .map { $0! }
    .skip(while: { $0 != 0 }) // 010 으로 시작하므로 첫자리 0 이 나오기 전까지 skip
    .take(11)
    .toArray()
    .asObservable()
    .map {
        $0.map { "\($0)" }
    }
    .map { numbers in
        var numberList = numbers
        numberList.insert("-", at: 3) // 010-
        numberList.insert("-", at: 8) // 010-0000-
        let number = numberList.reduce(" ", +)
        return number
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

input.onNext(10)
input.onNext(0)
input.onNext(nil)
input.onNext(1)
input.onNext(0)
input.onNext(4)
input.onNext(2)
input.onNext(3)
input.onNext(nil)
input.onNext(1)
input.onNext(8)
input.onNext(9)
input.onNext(2)
input.onNext(1)
