//
//  StudyCardsViewModel.swift
//  Wordsy
//
//  Created by aex on 14.09.2026.
//

import Foundation
import Observation

@Observable // чтобы экран обновлялся при изменениях
@MainActor // чтобы код шёл в главном потоке, где живёт UI
final class StudyCardsViewModel {
    private let deck: Deck // откуда брать карточки
    private let repository: DeckRepositoryProtocol // куда сохранять результат
    
    private(set) var currentIndex = 0 // на какой карточке сейчас
    private(set) var knownCount = 0 // сколько отметил «знаю» за сессию
    private(set) var unknownCount = 0 // сколько «ещё учу»
    
    private var history: [(card: Card, previousRepetitions: Int, wasKnown: Bool)] = [] // что менял — чтобы кнопка «назад» могла откатить
    
    let stageSize = 5 // по сколько карточек в этапе шкалы
    
    init(deck: Deck, repository: DeckRepositoryProtocol) { // получить колоду и репозиторий снаружи
        self.deck = deck
        self.repository = repository
    }
    
    var cards: [Card] { deck.cards } // короткий доступ к карточкам колоды
    
    var currentCard: Card? { // какую карточку показать прямо сейчас
        cards.indices.contains(currentIndex) ? cards[currentIndex] : nil
    }
    
    var isFinished: Bool { currentIndex >= cards.count } // закончились ли карточки
    
    var canGoBack: Bool { !history.isEmpty } // показывать ли кнопку «назад»
    
    func markKnown() { // пользователь свайпнул вправо
        guard let card = currentCard else { return }
        
        history.append((card: card, previousRepetitions: card.repetitions, wasKnown: true))
        
        card.repetitions += 1
        knownCount += 1
        currentIndex += 1
        
        save()
    }
    
    func markUnknown() { // свайпнул влево
        guard let card = currentCard else { return }
        
        history.append((card: card, previousRepetitions: card.repetitions, wasKnown: false))
        
        card.repetitions = 0
        unknownCount += 1
        currentIndex += 1
        
        save()
    }
    
    func goBack() { // вернуться к предыдущей карточке
        guard let last = history.popLast() else { return }
        
        last.card.repetitions = last.previousRepetitions
        
        if last.wasKnown {
            knownCount -= 1
        } else {
            unknownCount -= 1
        }
        
        currentIndex -= 1
        
        save()
    }
    
    private func save() {
        do {
            try repository.save()
        } catch {
            print("Не удалось сохранить: \(error)")
        }
    }
    
    func restart() { // начать сессию заново
        currentIndex = 0
        knownCount = 0
        unknownCount = 0
        history.removeAll()
    }
}

/*
 @Observable — макрос, который делает свойства отслеживаемыми. SwiftUI запоминает, какие из них прочитала вью, и перерисовывает её при их изменении. Без него экран не обновится ни разу.
 
 @MainActor — обещание, что весь код класса выполняется в главном потоке. UI можно менять только оттуда, а вью-модель напрямую влияет на UI. Без этой пометки компилятор будет ругаться при обращении из вью, а при работе с сетью можно получить обновление из фонового потока и падение.
 
 final — класс нельзя наследовать. Ставится по умолчанию, пока наследование реально не нужно: компилятор тогда вызывает методы напрямую, без таблицы виртуальных вызовов. Бесплатная оптимизация.
 
 class, а не struct — вью-модель должна жить дольше одной перерисовки и иметь один экземпляр на экран. Структура копировалась бы при каждой передаче.
 */
