//
//  DIContainer.swift
//  Wordsy
//
//  Created by aex on 04.08.2026.
//

import Foundation
import Combine

@MainActor
final class DIContainer: ObservableObject {
    private let repository: DeckRepositoryProtocol
    
    init() {
        repository = HardCodeDeckRepository()
    }
    
    func makeHomeViewModel() -> HomeViewModel {
        HomeViewModel(repository: repository)
    }
    
    func makeLibraryViewModel() -> LibraryViewModel {
        LibraryViewModel(repository: repository)
    }
        
    func makeCreateDeckViewModel() -> CreateDeckViewModel {
        CreateDeckViewModel(repository: repository)
    }
}

/*
DI Container (Dependency Injection - Внедрение Зависимостей) — обычный класс, который один раз создаёт репозиторий (HardCodeDeckRepository сейчас), хранит его у себя и раздаёт через фабричные методы (makeHomeViewModel() и т.д.) всем экранам, которым он нужен. Работает не постоянно, а только в момент создания экрана — дальше ViewModel общается напрямую с репозиторием, а не с контейнером (это разбирали подробно на примере DeckListView/DeckDetailView).

 Почему так называется. "Dependency" — это то, что классу нужно для работы, но что он не создаёт сам (HomeViewModel нуждается в репозитории, но не должен сам решать, какой именно репозиторий использовать). "Injection" — способ передать эту зависимость снаружи, через параметр конструктора, а не создавать её внутри самого класса. "Container" — потому что это один объект, который "хранит" готовые зависимости и умеет их выдавать; это общепринятый термин в индустрии (в Java это Spring, в Android — Dagger, в Swift иногда Swinject) — идея одна и та же, просто разные реализации.

 Почему сейчас. У тебя уже есть данные (HardCodeDeckRepository с колодами), но пока ничто в приложении их не запрашивает — ни один экран ещё не создан с этим репозиторием внутри. DIContainer — это ровно то звено, которое соединяет "данные готовы" с "экран может их использовать". Без него HomeViewModel (следующий шаг после этого) физически неоткуда будет взять repository в свой конструктор.
 */
