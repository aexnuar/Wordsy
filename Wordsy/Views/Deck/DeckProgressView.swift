//
//  DeckProgressView.swift
//  Wordsy
//
//  Created by aex on 04.09.2026.
//

import SwiftUI

struct DeckProgressView: View {
    let new: Int
    let learning: Int
    let learned: Int
    
    private var total: Int { new + learning + learned }
    private var percent: Int { total == 0 ? 0 : learned * 100 / total }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Прогресс")
            
            VStack(alignment: .leading, spacing: 10) {
                Text("\(percent) %")
                    .font(.headline)
                
                GeometryReader { geo in
                    HStack(spacing: 2) {
                        segment(new, Color(.systemGray4), geo.size.width)
                        segment(learning, Color(.systemOrange), geo.size.width)
                        segment(learned, Color(.systemGreen), geo.size.width)
                    }
                }
                .frame(height: 8)
                .clipShape(Capsule())
                
                
                
                HStack(spacing: 10) {
                    statusCounter(Color(.systemGray4), CardStatus.new.title, new)
                    statusCounter(Color(.systemOrange), CardStatus.learning.title, learning)
                    statusCounter(Color(.systemGreen), CardStatus.learned.title, learned)
                }
            }
            .padding()
            .overlay {
                RoundedRectangle(cornerRadius: 16)
                    .strokeBorder(Color(.systemGray4), lineWidth: 1)
            }
        }
    }
    
    @ViewBuilder
    private func segment(_ count: Int, _ color: Color, _ totalWidth: CGFloat) -> some View {
        if count > 0 && total > 0 && totalWidth > 0 {
            color.frame(width: CGFloat(count) / CGFloat(total) * totalWidth)
        }
    }
    
    private func statusCounter(_ color: Color, _ title: String, _ count: Int) -> some View {
        HStack(spacing: 5) {
            Circle()
                .fill(color)
                .frame(width: 7, height: 7)
            Text("\(title) \(count)")
                .font(.callout)
        }
    }
}

#Preview {
    DeckProgressView(new: 2, learning: 4, learned: 7)
}


