//
//  ActionEventEmitable.swift
//  AlamofirePractice
//
//  Created by 이숭인 on 6/14/24.
//

import RxSwift

public protocol ActionEventEmitable {
    var actionEventEmitter: PublishSubject<ActionEventItem> { get }
}

public protocol ActionEventItem { }
