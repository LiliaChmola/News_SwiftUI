//
//  NewsItemView.swift
//  News_SwiftUI
//
//  Created by Lilia Chmola on 23.02.2021.
//

import SwiftUI

struct NewsItemView: View {
    let news: News
    let onTapGesture: () -> Void
    
    var body: some View {
        HStack {
            self.infoView
            Spacer()
            self.imageView
        }
        .padding()
        .background(self.roundedBackground)
        .onTapGesture {
            self.onTapGesture()
        }
    }
    
    var imageView: some View {
        WebImageView(url: self.news.urlToImage)
            .frame(width: 100)
            .cornerRadius(5)
            .clipped()
    }
    
    var infoView: some View {
        VStack {
            Text(self.news.publishedAt)
                .font(.system(size: 9, weight: .light, design: .rounded))
            Text(self.news.title)
                .font(.system(size: 15, weight: .bold, design: .rounded))
                .multilineTextAlignment(.leading)
                .padding(.vertical, 3)
            Text(self.news.description)
                .font(.system(size: 10, weight: .semibold, design: .rounded))
                .lineLimit(5)
            HStack() {
                Text(self.news.authorString)
                Spacer()
                Text(self.news.name)
                    .multilineTextAlignment(.trailing)
                    .minimumScaleFactor(0.1)
                    .lineLimit(1)
            }.foregroundColor(.gray)
            .font(.system(size: 13, weight: .light, design: .rounded))
            .padding(.top, 3)
        }.padding()
    }
    
    var roundedBackground: some View {
        return RoundedRectangle(cornerRadius: 5)
                        .foregroundColor(.white)
                        .padding()
                        .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 3)
    }
}

struct NewsItemView_Previews: PreviewProvider {
    static var previews: some View {
        NewsItemView(news: .init(name: "name", authorString: "authorString", title: "title", description: "description", urlToImage: URL(fileURLWithPath: ""), url: URL(fileURLWithPath: ""), publishedAt: "publishedAt", content: "content"), onTapGesture: {})
    }
}
