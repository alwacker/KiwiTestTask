//
//  CacheImageView.swift
//  KiwiTestTask
//
//  Created by Oleksandr Vaker on 01.12.2022.
//

import Foundation
import SwiftUI

struct CacheImage: View {
    @StateObject private var loader: CacheImageAdapter

    init(url: URL) {
        _loader = StateObject(wrappedValue: CacheImageAdapter(url: url))
    }

    var body: some View {
        ZStack {
            if loader.image != nil {
                Image(uiImage: loader.image!)
                    .resizable()

            } else {
                Image(uiImage: UIImage(named: "placeholderImage") ?? UIImage())
                    .resizable()
            }
        }.onAppear {
            loader.load()
        }
    }
}
