//
//  ProductCardView.swift
//  CountriesApp
//
//  Created by Frederick Lamoste on 5/7/25.
//
import SwiftUI
import Kingfisher

struct ProductCardView: View {
    
    var product: ProductModel

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            KFImage(URL(string: product.image))
                .placeholder {
                    Rectangle()
                        .fill(Color.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 180)
                        .overlay(
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: Color.blue))
                        )
                }
                .retry(maxCount: 3, interval: .seconds(2))
                .onFailure { error in
                    print("❌ Failed to load image: \(error)")
                }
                .onSuccess { result in
                    print("✅ Successfully loaded image from: \(result.source.url?.absoluteString ?? "")")
                }
                .cacheOriginalImage()
                .fade(duration: 0.25)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
                .frame(height: 180)
                .clipped()

            VStack(alignment: .leading, spacing: 8) {
                Text(product.title)
                    .font(.headline)
                    .lineLimit(2)
                    .padding(.top, 8)
                    .frame(maxHeight: .infinity, alignment: .top)
                
                HStack {
                    VStack(spacing: 2) {
                        HStack(spacing: 2) {
                            ForEach(0..<5) { index in
                                Image(systemName: index < Int(product.rating.rate.rounded()) ? "star.fill" : "star")
                                    .resizable()
                                    .frame(width: 12, height: 12)
                                    .foregroundColor(.yellow)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 2)
                        
                        Text("(\(product.rating.count) Reviews)")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .italic()
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    Spacer()
                    
                    Text("$\(product.price, specifier: "%.2f")")
                        .font(.subheadline)
                        .foregroundColor(.red)

                }
                .padding(.bottom, 8)
            }
            .padding(.horizontal, 8)
            .background(Color.white)
        }
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 2)
        .padding(.horizontal, 4)
        .padding(.vertical, 4)
    }
}

