// DetailsView.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// DetailsView
struct DetailsView: View {
    @StateObject var presenter: DetailPresenter

    var body: some View {
        backgroundStackView {
            VStack {
                Spacer()
                    .frame(height: 70)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button(action: {
                                presenter.popViewController()
                            }) {
                                Image(systemName: "chevron.backward")
                            }
                        }

                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {
                                presenter.isFavorite.toggle()
                            }) {
                                Image(
                                    systemName: presenter.isFavorite ? "heart.fill" : "heart"
                                )
                            }
                        }
                    }
                    .padding(8)
                ScrollView {
                    switch presenter.stateView {
                    case .initial:
                        Text("init")
                    case .loading:
                        shimmer
                    case .success:
                        VStack {
                            filmView
                                .foregroundStyle(.white)
                            lookButtonView
                                .padding(2)
                            aboutFilmView
                            actorsView
                                .padding(.top, 5)
                            moreDataView
                                .foregroundStyle(.white)
                        }
                        .padding(.leading, 15)
                        .padding(.bottom, 30)
                    case .failure:
                        Text("error")
                    }
                }

            }.onAppear {
                presenter.fetch()
            }.foregroundStyle(.white)
                .navigationBarBackButtonHidden(true)
        }.ignoresSafeArea()
    }

    private var filmView: some View {
        HStack {
            AsyncImage(url: URL(string: presenter.film?.poster ?? "")) { image in
                image
                    .resizable()
                    .frame(width: 170, height: 200)
                    .cornerRadius(8)

            } placeholder: {
                ProgressView()
                    .frame(width: 170, height: 200)
            }
            VStack(spacing: 5) {
                Text(presenter.film?.name ?? "")
                    .font(.system(size: 18, weight: .semibold))
                Text("⭐ \(presenter.film?.rating ?? "")")
                    .font(.system(size: 16))
            }.padding()
            Spacer()
        }
    }

    private var lookButtonView: some View {
        Button {
            presenter.isTapLookButton = true
        } label: {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.greenGrad)
                .frame(height: 48)
                .overlay {
                    Text("Смотреть")
                }
                .padding(.horizontal, 5)
        }
        .alert("УПС!", isPresented: $presenter.isTapLookButton) {} message: {
            Text("Функционал в разработке?")
        }.padding(.trailing, 15)
    }

    private var aboutFilmView: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .bottom) {
                Text(presenter.film?.description ?? "")
                    .font(.system(size: 14))
                    .frame(height: 100)
                Button {
                    presenter.isFullDescription.toggle()
                } label: {
                    Image(presenter.isFullDescription ? .chevronDown : .chevronUp)
                        .frame(width: 30, height: 30)
                }
            }
            Text(
                "\(presenter.film?.year ?? 0) / \(presenter.film?.country ?? "") / \(presenter.film?.type ?? "")"
                    .replacingOccurrences(of: ",", with: "")
            )
            .font(.system(size: 14))
            .foregroundStyle(.black.opacity(0.7))
        }
    }

    private var actorsView: some View {
        VStack(alignment: .leading) {
            Text("Актеры и съемочная группа")
                .font(.system(size: 14, weight: .bold))

            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(presenter.film?.actor ?? [], id: \.name) { object in
                        VStack {
                            AsyncImage(url: URL(string: object.poster)) { image in
                                image
                                    .resizable()
                                    .frame(width: 46, height: 72)
                            } placeholder: {
                                ProgressView()
                                    .frame(width: 46, height: 72)
                            }
                            Text(object.name)
                                .font(.system(size: 8))
                                .multilineTextAlignment(.center)

                        }.frame(width: 60)
                    }
                }
            }
        }
    }

    private var moreDataView: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Язык")
                .font(.system(size: 14, weight: .bold))
            Text(presenter.film?.language ?? "")
                .font(.system(size: 14))
                .foregroundStyle(.black.opacity(0.7))
            Text("Смотрите также")
                .font(.system(size: 14, weight: .bold))
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(presenter.film?.similarMovies ?? [], id: \.name) { film in
                        VStack {
                            AsyncImage(url: URL(string: film.poster)) { image in
                                image
                                    .resizable()
                                    .frame(width: 170, height: 200)
                            } placeholder: {
                                ProgressView()
                                    .frame(width: 270, height: 300)
                            }
                            Text(film.name)
                                .font(.system(size: 16))
                                .multilineTextAlignment(.leading)

                        }.padding(.horizontal, 4)
                    }
                }.offset(x: -5)
            }
        }
    }

    private var shimmer: some View {
        VStack(alignment: .leading) {
            HStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.white.opacity(0.3))
                    .frame(width: 170, height: 200)
                    .shimmering()
                VStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.white.opacity(0.3))
                        .frame(width: 200, height: 30)
                        .shimmering()
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.white.opacity(0.3))
                        .frame(width: 200, height: 30)
                        .shimmering()
                }
            }
            VStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.white.opacity(0.3))
                    .frame(height: 48)
                    .shimmering()

                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.white.opacity(0.3))
                    .frame(height: 100)
                    .shimmering()

                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.white.opacity(0.3))
                    .frame(width: 150, height: 25)
                    .shimmering()
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.white.opacity(0.3))
                    .frame(width: 150, height: 25)
                    .shimmering()
            }
            ScrollView(.horizontal) {
                HStack {
                    ForEach(0 ..< 7) { _ in
                        VStack {
                            Rectangle()
                                .fill(Color.white.opacity(0.3))
                                .frame(width: 46, height: 72)
                                .shimmering()
                            Rectangle()
                                .fill(Color.white.opacity(0.3))
                                .frame(width: 46, height: 20)
                                .shimmering()
                                .offset(y: -5)
                        }.frame(width: 60, height: 95)
                    }
                }
            }
            VStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.white.opacity(0.3))
                    .frame(width: 150, height: 25)
                    .shimmering()
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.white.opacity(0.3))
                    .frame(width: 150, height: 25)
                    .shimmering()
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.white.opacity(0.3))
                    .frame(width: 150, height: 25)
                    .shimmering()
            }
        }.padding(.horizontal, 25)
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
