//
//  DeckRepositoryProtocol.swift
//  Wordsy
//
//  Created by aex on 31.07.2026.
//

import Foundation
import Combine

protocol DeckRepositoryProtocol: AnyObject {
    var decksPublisher: AnyPublisher<[Deck], Never> { get }
    var foldersPublisher: AnyPublisher<[Folder], Never> { get }
    
    func fetchDecks() throws -> [Deck]
    func fetchFolders() throws -> [Folder]
    func fetchRecentlyOpened(limit: Int) throws -> [Deck]
    func addDeck(_ deck: Deck)
    func deleteDeck(_ deck: Deck)
    func addCard(_ card: Card, to deck: Deck)
    func deleteCard(_ card: Card)
    func save() throws
}

/*
 1. @Published — это на самом деле обёртка над Combine. Когда пишешь @Published private var decks: [Deck], компилятор создаёт для этого свойства скрытый Publisher — что-то вроде "радиостанции", которая транслирует новое значение КАЖДЫЙ раз, когда decks меняется. Обратиться к этой "радиостанции" можно через $decks — это и есть "projected value" (та же логика $, что мы видели у @State/@Binding, только тут $ даёт не Binding, а Publisher).

 2. Зачем AnyPublisher, а не просто $decks в протоколе. Протокол не может напрямую требовать @Published-свойство — property wrapper'ы это языковая магия конкретного типа, в протокол её не засунуть. Поэтому мы прячем детали за абстрактным типом:

 swift
 var decksPublisher: AnyPublisher<[Deck], Never> {
     $decks.eraseToAnyPublisher()
 }

 eraseToAnyPublisher() буквально "стирает" конкретный тип Published<[Deck]>.Publisher, превращая его в универсальный AnyPublisher<[Deck], Never> — снаружи (в протоколе, в ViewModel) никто не обязан знать, что внутри HardCodeDeckRepository использовался именно @Published. Завтра поменяешь на SwiftData-реализацию — протокол не изменится, ViewModel не заметит разницы. Второй параметр Never означает "этот Publisher никогда не завершится с ошибкой" — данные просто текут, ошибок тут не бывает по определению.

 3. Подписка в LibraryViewModel.init:

 swift
 repository.decksPublisher
     .receive(on: DispatchQueue.main)
     .sink { [weak self] decks in
         self?.myDecks = decks.filter { !$0.isPublic && $0.folder == nil }
         self?.communityDecks = decks.filter { $0.isPublic }
     }
     .store(in: &cancellables)
 .receive(on: DispatchQueue.main) — гарантирует, что замыкание внутри .sink выполнится на главном потоке. Это важно, потому что мы тут же трогаем @Published-свойства, а SwiftUI обязательно должен обновлять UI именно с главного потока — без этой строки, если сигнал вдруг прилетит с фонового потока, можно словить краш или непредсказуемое поведение.
 .sink { [weak self] decks in ... } — это и есть сама подписка: "как только decksPublisher пришлёт новое значение, выполни этот код, а decks внутри замыкания — это как раз то самое новое значение".
 [weak self] — без этого замыкание держало бы СИЛЬНУЮ ссылку на self (саму ViewModel). А поскольку сама ViewModel хранит эту подписку у себя в cancellables, получился бы замкнутый круг: ViewModel → cancellables → подписка → замыкание → ViewModel. Объект никогда не освободился бы из памяти, даже когда экран закрыт (утечка памяти). [weak self] разрывает этот круг — внутри замыкания self становится опциональным (self?), и если ViewModel уже уничтожена, код просто ничего не делает.
 .store(in: &cancellables) — сама подписка (AnyCancellable) должна где-то ХРАНИТЬСЯ, иначе Swift увидит, что на неё никто не ссылается, и сразу же её уничтожит (отпишется) прямо в момент создания. cancellables (Set<AnyCancellable>) — просто "коробка", которая держит все активные подписки живыми, пока жива сама ViewModel.

 4. Полная цепочка событий, когда пользователь сохраняет подборку:

 CreateDeckViewModel.save() вызывает repository.addDeck(deck).
 Внутри addDeck строка decks.append(deck) меняет @Published-массив.
 @Published автоматически шлёт новое значение через $decks (и, соответственно, через decksPublisher, который на него завязан).
 LibraryViewModel's .sink (подписанный ещё в init) получает новый массив и обновляет myDecks/communityDecks.
 Эти свойства помечены @Published У САМОЙ LibraryViewModel — значит, LibraryView (которая наблюдает за ней через @StateObject) узнаёт об изменении и перерисовывается.
 Всё это происходит СРАЗУ, в момент сохранения — независимо от того, была ли вкладка Library уже открыта или нет.

 То же самое одновременно происходит и в HomeViewModel, если она подписана точно так же — оба экрана обновляются параллельно, от одного и того же события.
 */
