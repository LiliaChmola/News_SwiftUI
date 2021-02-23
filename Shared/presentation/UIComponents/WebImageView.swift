//
//  WebImageView.swift
//  News_SwiftUI
//
//  Created by Lilia Chmola on 21.02.2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct WebImageView: View {
    let url: URL
    
    var body: some View {
        WebImage(url: self.url)
        .resizable()
            .placeholder {
                Image("placeholder")
                    .resizable()
            }
        .indicator(.activity)
        .transition(.fade(duration: 0.5))
        .scaledToFill()
    }
}

struct WebImageView_Previews: PreviewProvider {
    static var previews: some View {
        WebImageView(url: URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/1920px-Image_created_with_a_mobile_phone.png")!)
    }
}
