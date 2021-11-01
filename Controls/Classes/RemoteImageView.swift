//
//  RemoteImageView.swift
//  Controls
//
//  Created by djiang on 10/10/21.
//

import Combine
import UIKit

class RemoteImageView: UIImageView {
    var imageCancellable: AnyCancellable?

    func setImage(with url: URL) {
        cancelImageRequest()
        image = nil

        imageCancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .map { UIImage(data: $0) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .assign(to: \.image, on: self)
    }

    func cancelImageRequest() {
        imageCancellable = nil
    }
}
