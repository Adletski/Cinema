// MainView.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// MainView
struct MainView: View {
    @StateObject var presenter: MainPresenter

    var body: some View {
        backgroundStackView {
            VStack {
                Spacer()
                    .frame(height: 70)
                Text("Смотри исторические фильмы на")
                    .font(.system(size: 20))
                    + Text(" CINEMA STAR")
                    .font(.system(size: 20, weight: .bold))
                switch presenter.stateView {
                case .initial:
                    Text("init")
                case .loading:
                    shimmer
                case .success:
                    collectionView.padding(.bottom, 30)
                case .failure:
                    Text("error")
                }
            }
            .tint(.white)
            .navigationBarBackButtonHidden(true)
        }.ignoresSafeArea()
    }

    var shimmer: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                ForEach(0 ..< 6, id: \.self) { _ in
                    VStack {
                        Rectangle()
                            .fill(Color.white.opacity(0.3))
                            .frame(width: 170, height: 200)
                            .shimmering()
                        Rectangle()
                            .fill(Color.white.opacity(0.3))
                            .frame(width: 170, height: 40)
                            .shimmering()
                    }
                    .padding(.bottom, 16)
                }
            }
            .padding(.horizontal, 10)
        }
    }

    var collectionView: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                ForEach(presenter.films, id: \.name) { film in
                    VStack(alignment: .leading) {
                        AsyncImage(url: URL(string: film.poster)) { image in
                            image
                                .resizable()
                                .frame(width: 170, height: 220)
                                .cornerRadius(15)
                        } placeholder: {
                            ProgressView()
                                .frame(width: 170, height: 220)
                        }
                        Text(film.name)
                            .frame(height: 10)
                        Text("⭐ \(film.rating)")
                    }.padding(.horizontal, 10)
                        .onTapGesture {
                            presenter.router?.pushDetail(id: film.id)
                        }
                }
            }
        }
    }

    func backgroundStackView<Content: View>(content: () -> Content) -> some View {
        ZStack {
            Rectangle()
                .fill(LinearGradient(colors: [.brownGrad, .greenGrad], startPoint: .top, endPoint: .bottom))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            content()
        }
    }
}

extension View {
    func shimmering() -> some View {
        modifier(Shimmer())
    }
}
