//
//  ContentView.swift
//  CountriesApp
//
//  Created by Frederick Lamoste on 5/6/25.
//

import SwiftUI

struct ProductListView: View {

    @StateObject private var countriesListViewModel = ProductListViewModel()
    @State private var searchText = ""
    @State private var countries: [ProductModel] = []

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
 
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 15) {
                    ForEach(
                        countriesListViewModel.filterProducts(by: searchText),
                        id: \.id
                    ) { product in
                        NavigationLink(destination: ProductDetailsView(product: product)) {
                            ProductCardView(product: product)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.horizontal, 12) 
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $searchText, prompt: "Search")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack(spacing: 8) {
                        Image(systemName: "cart.fill")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(.black)
                        Text("Products")
                            .font(.headline)
                            .foregroundColor(.primary)
                    }
                }
            }
            .onAppear {
                countriesListViewModel.loadProducts(
                    urlStr: "http://fakestoreapi.com/products")
            }
            .refreshable {
                countriesListViewModel.loadProducts(
                    urlStr: "http://fakestoreapi.com/products",
                    fromRefresh: true)
            }
        }
    }
}

#Preview {
    ProductListView()
}
