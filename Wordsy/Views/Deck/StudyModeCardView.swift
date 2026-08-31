//
//  StudyModeCardView.swift
//  Wordsy
//
//  Created by aex on 26.08.2026.
//

import SwiftUI

struct StudyModeCardView: View {
    let image: String
    let title: String
    let description: String
    let iconColor: Color
    let action: () -> Void
    
    @ScaledMetric private var iconSize: CGFloat = 22
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: image)
                    .frame(width: iconSize, height: iconSize)
                    .padding(8)
                    .background(iconColor.opacity(0.7))
                    .clipShape(.rect(cornerRadius: 8))
                
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.callout)
                    
                    Text(description)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(14)
            .overlay {
                RoundedRectangle(cornerRadius: 16)
                    .strokeBorder(Color(.systemGray4), lineWidth: 1)
            }
        }
        .buttonStyle(ScaleButtonStyle())
    }
}

#Preview {
    StudyModeCardView(image: "house", title: "Title", description: "Description", iconColor: .red, action: {})
        .environment(\.dynamicTypeSize, .accessibility3)
        .preferredColorScheme(.dark)
}

/*
 @ScaledMetric - про адаптацию
 
 Адаптация: два разных вопроса, которые легко перепутать
 
 Размер экрана — адаптировать не нужно, и это не ошибка.
 
 22 здесь — это не пиксели, а точки (points). iOS сама переводит их в пиксели с учётом плотности экрана: на устройстве @2x одна точка — 2 пикселя, на @3x — 3. Поэтому иконка 22pt физически одинакового размера на iPhone SE и на iPhone 16 Pro Max. Именно так и задумано: иконка — элемент управления, у неё есть комфортный размер для пальца и глаза, и он не должен зависеть от диагонали. Растягивать её на большом экране не надо — иначе на Pro Max получишь неуместно огромные плашки.
 
 Что действительно меняется от экрана к экрану — это ширина карточки целиком. Она у тебя уже адаптивная за счёт .frame(maxWidth: .infinity) на HStack: на широком экране карточка шире, иконка та же, текста в строку помещается больше.
 
 Размер шрифта — вот подо что адаптироваться нужно.
 
 В настройках iOS есть Dynamic Type: пользователь может увеличить системный шрифт, и это делают многие — из-за слабого зрения или просто из предпочтений. Твои Text с .font(.callout) и .font(.subheadline) вырастут автоматически, а иконка с жёстко зашитыми 22pt останется прежней. При крупных настройках она будет выглядеть непропорционально мелкой рядом с большим заголовком.
 
 @ScaledMetric решает ровно это:
 
 swift
 @ScaledMetric private var iconSize: CGFloat = 22
 
 Число 22 становится базовым значением для стандартного размера шрифта. При увеличении системного шрифта SwiftUI пересчитывает iconSize в той же пропорции — иконка растёт вместе с текстом. Обращаешься к нему как к обычной переменной.
 
 Как проверить: в превью добавь .environment(\.dynamicTypeSize, .accessibility3) — увидишь, что происходит при крупном шрифте. Сравни с версией на константе, разница наглядная.
 
 Тот же приём стоит применять и к отступам вокруг текста, если заметишь, что при крупном шрифте буквы упираются в края.
 */
