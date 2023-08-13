//
//  Operators.swift
//  SymbioADY
//
//  Created by ady on 2023/8/12.
//

import RxSwift
import RxCocoa
#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

// Two way binding operator between control property and relay, that's all it takes.

infix operator <-> : DefaultPrecedence

#if os(iOS)
func nonMarkedText(_ textInput: UITextInput) -> String? {
    let start = textInput.beginningOfDocument
    let end = textInput.endOfDocument

    guard let rangeAll = textInput.textRange(from: start, to: end),
        let text = textInput.text(in: rangeAll) else {
            return nil
    }

    guard let markedTextRange = textInput.markedTextRange else {
        return text
    }

    guard let startRange = textInput.textRange(from: start, to: markedTextRange.start),
        let endRange = textInput.textRange(from: markedTextRange.end, to: end) else {
        return text
    }

    return (textInput.text(in: startRange) ?? "") + (textInput.text(in: endRange) ?? "")
}

func <-> <Base>(textInput: TextInput<Base>, relay: BehaviorRelay<String>) -> Disposable {
    let bindToUIDisposable = relay.bind(to: textInput.text)
    
    let bindToRelay = textInput.text
        .subscribe(onNext: { [weak base = textInput.base] _ in
            guard let base = base else {
                return
            }

            let nonMarkedTextValue = nonMarkedText(base)

            if let nonMarkedTextValue = nonMarkedTextValue, nonMarkedTextValue != relay.value {
                relay.accept(nonMarkedTextValue)
            }
        }, onCompleted: {
            bindToUIDisposable.dispose()
        })

    return Disposables.create(bindToUIDisposable, bindToRelay)
}
#endif

func <-> <T>(property: ControlProperty<T>, relay: BehaviorRelay<T>) -> Disposable {
    if T.self == String.self {
#if DEBUG && !os(macOS)
        fatalError("It is ok to delete this message, but this is here to warn that you are maybe trying to bind to some `rx.text` property directly to relay.\n" +
            "That will usually work ok, but for some languages that use IME, that simplistic method could cause unexpected issues because it will return intermediate results while text is being inputed.\n" +
            "REMEDY: Just use `textField <-> relay` instead of `textField.rx.text <-> relay`.\n" +
            "Find out more here: https://github.com/ReactiveX/RxSwift/issues/649\n"
            )
#endif
    }

    let bindToUIDisposable = relay.bind(to: property)
    let bindToRelay = property
        .subscribe(onNext: { n in
            relay.accept(n)
        }, onCompleted: {
            bindToUIDisposable.dispose()
        })

    return Disposables.create(bindToUIDisposable, bindToRelay)
}


