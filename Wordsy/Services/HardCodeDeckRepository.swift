//
//  HardCodeDeckRepository.swift
//  Wordsy
//
//  Created by aex on 31.07.2026.
//

import Foundation

final class HardCodeDeckRepository: DeckRepositoryProtocol {
    private var folders: [Folder] = []
    private var decks: [Deck] = HardCodeDeckRepository.makeDecks()
    
    func fetchFolders() throws -> [Folder] {
        folders
    }
    
    func fetchDecks() throws -> [Deck] {
        decks
    }
    
    func fetchRecentlyOpened(limit: Int) throws -> [Deck] {
        let sorted = decks.sorted { $0.lastOpenedAt > $1.lastOpenedAt }
        return Array(sorted.prefix(limit))
    }
    
    func addDeck(_ deck: Deck) {
        decks.append(deck)
    }
    
    func deleteDeck(_ deck: Deck) {
        guard let index = decks.firstIndex(of: deck) else { return }
        decks.remove(at: index)
    }
    
    func addCard(_ card: Card, to deck: Deck) {
        card.deck = deck
        deck.cards.append(card)
    }
    
    func deleteCard(_ card: Card) {
        card.deck?.cards.removeAll { $0.id == card.id }
    }
    
    func save() throws {
        //
    }
    
    private static func makeDecks() -> [Deck] {
        let deck1 = makeDeck(title: "Английский: слова о характере", pairs: englishWordPairs, isPublic: false)
        let deck2 = makeDeck(title: "Испанский: базовые фразы", pairs: spanishWordPairs, isPublic: false)
        let deck3 = makeDeck(title: "Острое слово вместо привычного", pairs: expressionPairs, isPublic: false)
        return [deck1, deck2, deck3]
    }
    
    private static func makeDeck(title: String, pairs: [(term: String, definition: String)], isPublic: Bool) -> Deck {
        let cards = pairs.map { Card(term: $0.term, definition: $0.definition) }
        let deck = Deck(title: title, cards: cards, lastOpenedAt: .now, isPublic: isPublic)
        //for card in cards { card.deck = deck }
        return deck
    }
}

private extension HardCodeDeckRepository {
    static var englishWordPairs: [(term: String, definition: String)] {
        [
            ("ambitious", "целеустремлённый, амбициозный"),
            ("resilient", "стойкий, жизнестойкий"),
            ("meticulous", "дотошный, скрупулёзный"),
            ("candid", "искренний, прямой"),
            ("eloquent", "красноречивый"),
            ("assertive", "напористый, уверенный в своей позиции"),
            ("humble", "скромный"),
            ("resourceful", "находчивый"),
            ("diligent", "прилежный, старательный"),
            ("pragmatic", "прагматичный"),
            ("reserved", "сдержанный"),
            ("tenacious", "упорный, цепкий"),
            ("articulate", "умеющий чётко излагать мысли"),
            ("perceptive", "проницательный"),
            ("versatile", "разносторонний"),
            ("sincere", "искренний"),
            ("audacious", "дерзкий, отважный"),
            ("empathetic", "сопереживающий"),
            ("disciplined", "дисциплинированный"),
            ("shrewd", "проницательный, хитроумный")
        ]
    }
    
    static var spanishWordPairs: [(term: String, definition: String)] {
        [
            ("hola", "привет"),
            ("gracias", "спасибо"),
            ("por favor", "пожалуйста"),
            ("buenos días", "доброе утро"),
            ("buenas noches", "спокойной ночи"),
            ("¿cómo estás?", "как дела?"),
            ("lo siento", "извини"),
            ("de nada", "не за что"),
            ("sí", "да"),
            ("no", "нет"),
            ("adiós", "прощай"),
            ("hasta luego", "до встречи"),
            ("por supuesto", "конечно"),
            ("¿qué tal?", "как оно?"),
            ("mucho gusto", "приятно познакомиться"),
            ("ayuda", "помощь"),
            ("amigo", "друг"),
            ("familia", "семья"),
            ("trabajo", "работа"),
            ("tiempo", "время")
        ]
    }
    
    static var expressionPairs: [(term: String, definition: String)] {
        [
            ("Блин!", "Вот незадача!"),
            ("Чёрт возьми!", "Каков пассаж!"),
            ("Офигеть", "Вот это поворот!"),
            ("Капец", "Приехали!"),
            ("Задолбало", "Утомительно до крайности"),
            ("Достало", "Сверх всякой меры"),
            ("Фигня", "Сущий вздор"),
            ("Бред", "Абсурд чистой воды"),
            ("Жесть", "Форменное безобразие"),
            ("Кошмар", "Сущий ужас"),
            ("Не может быть", "Невероятно, но факт"),
            ("Вот это да", "Поразительно!"),
            ("Ёлки-палки", "Батюшки светы"),
            ("Обалдеть", "Диву даюсь"),
            ("Влип", "Оказался в затруднительном положении"),
            ("Прокол", "Досадная оплошность"),
            ("Облом", "Досадная неудача"),
            ("Затупил", "Дал маху"),
            ("Наглость какая", "Возмутительная дерзость"),
            ("Достало всё", "Терпение на исходе")
        ]
    }
}
