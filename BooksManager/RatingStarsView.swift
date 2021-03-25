//
//  RatingStarsView.swift
//  BooksManager
//
//  Created by Sebastian Staszczyk on 13/03/2021.
//

import SwiftUI

struct RatingStarsView: View {
    private let spacing: CGFloat
    private let rating: Double
    private let color: Color
    private let showRating: Bool
    
    private var fullStars: Int { Int(rating.whole) }
    private var halfStar: Bool { rating.fraction >= 0.5 ? true : false }
    private var emptyStars: Int { (5 - fullStars) - (halfStar ? 1 : 0) }
    
    var body: some View {
        HStack(spacing: spacing) {
            ForEach(0..<fullStars, id: \.self) { _ in
                Image(systemName: "star.fill")
            }
            
            if halfStar {
                Image(systemName: "star.leadinghalf.fill")
            }
            
            ForEach(0..<emptyStars, id: \.self) { _ in
                Image(systemName: "star")
            }
            
            if showRating {
                Text(String(rating)).bold()
                    .foregroundColor(.primary)
                    .padding(.leading, 10)
            }
        }
        .foregroundColor(color)
    }
    
    init(rating: Double, showRating: Bool = false, color: Color = .yellow, spacing: CGFloat = 0) {
        self.spacing = spacing
        self.rating = rating
        self.color = color
        self.showRating = showRating
    }
}

// MARK: -- Preview

struct RatingStarsView_Previews: PreviewProvider {
    static var previews: some View {
        RatingStarsView(rating: 2)
            .previewLayout(PreviewLayout.sizeThatFits)
    }
}
