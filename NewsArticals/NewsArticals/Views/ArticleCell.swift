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
                .background(Color.gray)
                .cornerRadius(10.0)
            VStack(alignment: .leading) {
                Text(viewModel.title)
                    .multilineTextAlignment(.leading)
                    .lineLimit(1)
                    .font(.title3)
            }
        }
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
