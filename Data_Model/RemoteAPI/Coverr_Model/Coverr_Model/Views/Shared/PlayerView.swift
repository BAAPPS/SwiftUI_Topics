//
//  PlayerView.swift
//  Coverr_Model
//
//  Created by D F on 9/15/25.
//

import AVKit
import UIKit

class PlayerView: UIView {
    private let playerLayer = AVPlayerLayer()

    var player: AVPlayer? {
        get { playerLayer.player }
        set { playerLayer.player = newValue }
    }

    var fillMode: Bool = true {
        didSet {
            playerLayer.videoGravity = fillMode ? .resizeAspectFill : .resizeAspect
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        layer.addSublayer(playerLayer)
        playerLayer.videoGravity = .resizeAspectFill
    }

    required init?(coder: NSCoder) { fatalError() }

    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
}
