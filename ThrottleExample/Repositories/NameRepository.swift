//
//  NameRepository.swift
//  ThrottleExample
//
//  Created by Fernando Mota e Silva on 25/04/2018.
//  Copyright © 2018 Fernando Mota e Silva. All rights reserved.
//

import Foundation
import RxSwift

class NameRepository {
    
    private let db = DB()
    
    private let dbSearchEngine = PublishSubject<[String]>()
    
    var observableData: Observable<[String]> {
        get {
            return dbSearchEngine.asObserver().delay(4, scheduler: MainScheduler.instance)
        }
    }
    
    func findByName(name: String) {
        dbSearchEngine.onNext(db.nameData.filter { (value) -> Bool in
            return value.contains(name)
        })
    }
    
    func closeConnection() {
        dbSearchEngine.onCompleted()
    }
}
