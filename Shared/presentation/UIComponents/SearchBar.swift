//
//  SearchBar.swift
//  News_SwiftUI
//
//  Created by Lilia Chmola on 22.02.2021.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    
    @State private var isEditing = false
    
    var body: some View {
        HStack {
            TextField("Search", text: $text) { (isEditing) in
                self.isEditing = isEditing
            }
            .padding(7)
            .padding(.horizontal, 25)
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .overlay(
                HStack {
                    self.searchIcon
                    if isEditing && !self.text.isEmpty {
                        self.clearTextIcon
                    }
                }
            )
            .padding(.horizontal, 10)
            if isEditing {
                self.cancelButton
            }
        }
        .onChange(of: self.isEditing, perform: {
            if !$0 {
                UIApplication.shared.endEditing()
            }
        })
    }
    
    var searchIcon: some View {
        Image(systemName: "magnifyingglass")
            .foregroundColor(.gray)
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 8)
    }
    
    var clearTextIcon: some View {
        Button(action: {
                self.text = ""
        }) {
            Image(systemName: "multiply.circle.fill")
                .foregroundColor(.gray)
                .padding(.trailing, 8)
        }
    }
    
    var cancelButton: some View {
        Button(action: {
            self.isEditing = false
            self.text = ""
        }) {
            Text("Cancel")
        }
        .padding(.trailing, 10)
        .transition(.move(edge: .trailing))
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant(""))
    }
}
