//
//
//  CardsController.swift
//
//  Copyright (c) 2021 Tinkoff Bank
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//   http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//


import Foundation

protocol CardsControllerListener: AnyObject {
    var customerKey: String { get }
    
    func cardsControllerDidStartLoadCards(_ cardsController: CardsController)
    func cardsControllerDidStopLoadCards(_ cardsController: CardsController)
}

protocol CardsController {
    var cards: [PaymentCard] { get }
    func loadCards(completion: @escaping (Result<[PaymentCard], Error>) -> Void)
    func willDeinitListener(_ listener: CardsControllerListener)
}

protocol UpdatableCardsController: CardsController {
    func addListener(_ listener: CardsControllerListener)
    func removeListener(_ listener: CardsControllerListener)
}
