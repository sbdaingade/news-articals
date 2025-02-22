//
//  ArticleCell.swift
//  NewsArticals
//
//  Created by Sachin Daingade on 24/11/24.
//
import SwiftUI
import Combine

struct ArticleCell: View {
    @StateObject var viewModel: ArticleCellViewModel

    var body: some View {
        
        HStack(alignment: .center) {

            AsyncImage(url: URL(string: viewModel.urlString),content: asyncImageView)
                .frame(width:100, height:100)
                .cornerRadius(10.0)
            VStack(alignment: .leading) {
                Text(viewModel.title)
                    .multilineTextAlignment(.leading)
                    .lineLimit(1)
                    .font(.title3)
                Text(viewModel.description)
                    .multilineTextAlignment(.leading)
                    .lineLimit(0)
                    .font(.subheadline)
            }
        }
        .background(
            Color.gray.opacity(0.2)
        )
        .cornerRadius(10.0)

    }
    
    @ViewBuilder
    private func asyncImageView(for phase: AsyncImagePhase) -> some View {
        switch phase {
        case .empty:
            ProgressView.init("Loading..")
        case .success(let image):
            image.resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(10)
        case .failure(let error):
            VStack(spacing:16) {
                Image(systemName: "xmark.octagon.fill")
                    .foregroundColor(.red)
                Text(error.localizedDescription)
                    .multilineTextAlignment(.center)
            }
            
        @unknown default:
            Text("unknown")
                .foregroundColor(.gray)
        }
    }
}

#Preview {
    ArticleCell(viewModel: ArticleCellViewModel(withArticle: Article(source: Source.init(id: "1", name: "test"), author: "", title: "Sachin", description: "test", url: "", urlToImage: "https://avatars.githubusercontent.com/u/16917540?v=4", publishedAt: "", content: "")))
}
