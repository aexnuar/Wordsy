//
//  StudyCardsView.swift
//  Wordsy
//
//  Created by aex on 16.09.2026.
//

import SwiftUI

struct StudyCardsView: View {
    @State private var viewModel: StudyCardsViewModel

    init(viewModel: StudyCardsViewModel) {
        self._viewModel = State(wrappedValue: viewModel)
    }

    var body: some View {
        if viewModel.isFinished {
            //
        } else if let card = viewModel.currentCard {
            //
        }
    }
}

#Preview {
    //
}
