//
//  NewsDetailsView.swift
//  News
//
//  Created by Lilia Chmola on 21.02.2021.
//

import SwiftUI

struct NewsDetailsView: View {
    let news: News?
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        self.news.map { (news) in
            GeometryReader { proxy in
                ZStack(alignment: .top) {
                    WebImageView(url: news.urlToImage)
                        .frame(width: proxy.size.width, height: 300)
                    ZStack(alignment: .bottom, content: {
                        self.contentView(news: news, proxy: proxy)
                        self.backButton
                    })
                }.edgesIgnoringSafeArea(.top)
            }.navigationBarHidden(true)
        }
    }
    
    func contentView(news: News, proxy: GeometryProxy) -> some View {
        ScrollView(.vertical, showsIndicators: false, content: {
            Spacer()
                .frame(height: 260)
            VStack {
                Text(news.title)
                    .font(.system(size: 15, weight: .bold, design: .rounded))
                    .multilineTextAlignment(.center)
                Text(news.content)
                    .font(.system(size: 14, weight: .semibold, design: .rounded))
                HStack {
                    Text(news.authorString)
                    Divider()
                    Text(news.publishedAt)
                }.frame(height: 18)
                .font(.system(size: 13, weight: .light, design: .rounded))
                Link("Visit \(news.name)",
                     destination: news.url)
                    .foregroundColor(.blue)
                    .font(.system(size: 15, weight: .bold, design: .rounded))
                Spacer()
            }.frame(maxWidth: .infinity, minHeight: proxy.size.height - 260)
            .padding(.vertical, 30)
            .padding(.horizontal, 15)
            .background(self.viewBackground)
        })
    }
    
    var backButton: some View {
        Button(action: { self.presentationMode.wrappedValue.dismiss() }, label: {
            Image(systemName: "xmark.circle.fill")
                .resizable()
                .frame(width: 50, height: 50)
        })
    }
    
    var viewBackground: some View {
        RoundedRectangle(cornerRadius: 30).foregroundColor(.white)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NewsDetailsView(news: News(name: "Name", authorString: "authorString", title: "title", description: "ttps://iat.kpi.ua/wp-content/uploads/2019/10/news-3.jpgttps://iat.kpi.ua/wp-content/uploads/2019/10/news-3.jpgttps://iat.kpi.ua/wp-content/uploads/2019/10/news-3.jpgttps://iat.kpi.ua/wp-content/uploads/2019/10/news-3.jpgttps://iat.kpi.ua/wp-content/uploads/2019/10/news-3.jpgttps://iat.kpi.ua/wp-content/uploads/2019/10/news-3.jpgttps://iat.kpi.ua/wp-content/uploads/2019/10/news-3.jpgttps://iat.kpi.ua/wp-content/uploads/2019/10/news-3.jpgttps://iat.kpi.ua/wp-content/uploads/2019/10/news-3.jpgttps://iat.kpi.ua/wp-content/uploads/2019/10/news-3.jpgttps://iat.kpi.ua/wp-content/uploads/2019/10/news-3.jpgttps://iat.kpi.ua/wp-content/uploads/2019/10/news-3.jpgttps://iat.kpi.ua/wp-content/uploads/2019/10/news-3.jpgttps://iat.kpi.ua/wp-content/uploads/2019/10/news-3.jpg", urlToImage: URL(string: "https://iat.kpi.ua/wp-content/uploads/2019/10/news-3.jpg")!, url: .init(fileURLWithPath: ""), publishedAt: "publishedAt", content: ""))
    }
}
