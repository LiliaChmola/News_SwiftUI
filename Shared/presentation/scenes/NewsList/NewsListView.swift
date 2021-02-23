//
//  NewsListView.swift
//  Shared
//
//  Created by Lilia Chmola on 20.02.2021.
//

import SwiftUI

// delete test model
struct Test: Identifiable, Equatable {
    let id = UUID()
    let test: String
}

struct NewsListView: View {
    @StateObject var viewModel: NewsListVM
    @State var selectedItem: News?

    
    var body: some View {
        NavigationView(content: {
            VStack {
                self.navigation
                self.sortPickerView
                SearchBar(text: self.$viewModel.searchText)
                    .onReceive(self.viewModel.$searchText, perform: { _ in
                        self.viewModel.fetchFirstPage()
                    })
                ScrollView {
                    LazyVStack {
                        ForEach(self.viewModel.news) { value in
                            self.newsCell(model: value)
                                .onAppear(perform: {
                                    if value == viewModel.news.last {
                                        viewModel.fetchNextPage()
                                    }
                                })
                        }
                    }
                }
            }.navigationBarTitle("News")
        })
    }
    
    var navigation: some View {
        NavigationLink(
            destination: NewsDetailsView(news: self.viewModel.selectedItem),
            isActive: self.$viewModel.isPresentedDetails) {}
    }
    
    var sortPickerView: some View {
        HStack {
            Spacer()
            Picker(selection: self.$viewModel.selectedSort,
               label:                        Image(systemName: "arrow.up.arrow.down"), content: {
                ForEach(self.viewModel.sortedValues, id: \.self) {
                    Text($0)
                }
        }).pickerStyle(MenuPickerStyle())
        }.padding(.trailing)
        .onReceive(self.viewModel.$selectedSort, perform: { _ in
            self.viewModel.fetchFirstPage()
        })
    }
    
    func newsCell(model: News) -> some View {
        HStack {
            VStack {
                Text("icon")
                Text(model.title)
                    .font(.title)
                Text(model.description)
                HStack {
                    Text(model.authorString)
                        .font(.footnote)
                    Spacer()
                    Text(model.publishedAt)
                        .font(.system(size: 13))
                }
            }.padding()
            Spacer()
            WebImageView(url: model.urlToImage)
                .frame(width: 100)
                .cornerRadius(5)
                .clipped()
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 5)
                        .foregroundColor(.white)
                        .padding()
        
                        .shadow(color: Color.black.opacity(0.1), radius: 3  , x: 0, y: 3))
           
        .onTapGesture {
            self.viewModel.openDetails(with: model)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NewsListView(viewModel: NewsListVM())
    }
}
