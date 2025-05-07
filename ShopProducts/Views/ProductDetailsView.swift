//
//  ProductDetailsView.swift
//  ShopProducts
//
//  Created by Frederick Lamoste on 5/7/25.
//

import SwiftUI
import Kingfisher

struct ProductDetailsView: View {
    
    let product: ProductModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                KFImage(URL(string: product.image))
                    .placeholder {
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(maxWidth: .infinity)
                            .frame(height: 300)
                            .overlay(
                                ProgressView()
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
                
                Text(product.title)
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                
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
                }
                .padding(.horizontal)
                
                Text("$\(product.price, specifier: "%.2f")")
                    .font(.title3)
                    .foregroundColor(.pink)
                    .padding(.horizontal)
                
                Text(product.description)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .padding(.horizontal)
                
                Spacer()
                Spacer()
            }
            .padding(.top)
        }
        .navigationTitle("Product Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

