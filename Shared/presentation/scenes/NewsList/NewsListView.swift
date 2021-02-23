//
//  NewsListView.swift
//  Shared
//
//  Created by Lilia Chmola on 20.02.2021.
//

import SwiftUI

struct NewsListView: View {
    @StateObject var viewModel: NewsListVM
    
    var body: some View {
        NavigationView(content: {
            VStack {
                self.navigation
                self.sortPickerView
                SearchBar(text: self.$viewModel.searchText)
                    .onReceive(self.viewModel.$searchText, perform: { _ in
                        self.viewModel.fetchFirstPage()
                    })
                self.newsListView
            }.navigationBarTitle("News")
        }).navigationViewStyle(StackNavigationViewStyle())
    }
    
    var navigation: some View {
        NavigationLink(
            destination: NewsDetailsView(news: self.viewModel.selectedItem),
            isActive: self.$viewModel.isPresentedDetails) {}
    }
    
    var newsListView: some View {
        ScrollView {
            LazyVStack {
                ForEach(self.viewModel.news) { news in
                    NewsItemView(news: news,
                                 onTapGesture: { self.viewModel.openDetails(with: news) })
                        .onAppear(perform: {
                            if news == viewModel.news.last {
                                viewModel.fetchNextPage()
                            }
                        })
                }
            }
        }
    }
    
    var sortPickerView: some View {
        HStack {
            Spacer()
            Picker(selection: self.$viewModel.selectedSort, label: Image(systemName: "arrow.up.arrow.down"), content: {
                    ForEach(self.viewModel.sortedValues, id: \.self) {
                        Text($0)
                    }
                   }).pickerStyle(MenuPickerStyle())
        }.padding(.trailing)
        .onReceive(self.viewModel.$selectedSort, perform: { _ in
            self.viewModel.fetchFirstPage()
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NewsListView(viewModel: NewsListVM())
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
