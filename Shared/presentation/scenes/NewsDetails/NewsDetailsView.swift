//
//  NewsDetailsView.swift
//  News
//
//  Created by Lilia Chmola on 21.02.2021.
//

import SwiftUI

struct NewsDetailsView: View {
    let news: News?
    
    init(news: News?) {
        self.news = news
//        UINavigationBar.appearance().barTintColor = .clear
//        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
    }
    
    var body: some View {
        self.news.map { (news) in
            GeometryReader { proxy in
                VStack(spacing: -30) {
                WebImageView(url: news.urlToImage)
                    .frame(width: UIScreen.main.bounds.width, height: 300)
                ScrollView(.vertical, showsIndicators: false, content: {
//                    Spacer()
//                        .frame(height: 260)
                    VStack {
                    Text(news.title)
                        .font(.title)
                    Text(news.description)
                    HStack {
                    Text(news.authorString)
                        .font(.footnote)
                        Divider()
                    Text(news.publishedAt)
                        .font(.system(size: 13))
                    }.frame(height: 18)
                    Link("Visit source",
                         destination: news.url)
                        .foregroundColor(.blue)
                        .font(.system(size: 13))
                        Spacer()
                    }.frame(maxWidth: .infinity, minHeight: proxy.size.height - 270)
                    .padding(.vertical, 30)
                    .background(RoundedRectangle(cornerRadius: 30).foregroundColor(.white))
                    
                    
                })
            }.edgesIgnoringSafeArea(.top)
            }

        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NewsDetailsView(news: News(name: "Name", authorString: "authorString", title: "title", description: "ttps://iat.kpi.ua/wp-content/uploads/2019/10/news-3.jpgttps://iat.kpi.ua/wp-content/uploads/2019/10/news-3.jpgttps://iat.kpi.ua/wp-content/uploads/2019/10/news-3.jpgttps://iat.kpi.ua/wp-content/uploads/2019/10/news-3.jpgttps://iat.kpi.ua/wp-content/uploads/2019/10/news-3.jpgttps://iat.kpi.ua/wp-content/uploads/2019/10/news-3.jpgttps://iat.kpi.ua/wp-content/uploads/2019/10/news-3.jpgttps://iat.kpi.ua/wp-content/uploads/2019/10/news-3.jpgttps://iat.kpi.ua/wp-content/uploads/2019/10/news-3.jpgttps://iat.kpi.ua/wp-content/uploads/2019/10/news-3.jpgttps://iat.kpi.ua/wp-content/uploads/2019/10/news-3.jpgttps://iat.kpi.ua/wp-content/uploads/2019/10/news-3.jpgttps://iat.kpi.ua/wp-content/uploads/2019/10/news-3.jpgttps://iat.kpi.ua/wp-content/uploads/2019/10/news-3.jpg", urlToImage: URL(string: "https://iat.kpi.ua/wp-content/uploads/2019/10/news-3.jpg")!, url: .init(fileURLWithPath: ""), publishedAt: "publishedAt", content: ""))
    }
}
