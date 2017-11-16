//
//  PlaySlider.swift
//  yun_music
//
//  Created by yang on 16/11/2017.
//  Copyright © 2017 ocean. All rights reserved.
//

import UIKit

class PlaySlider: UIControl {

    private let leftLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    private let rightLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    private let progressBar: ProgressBar = {
        let bar = ProgressBar()
        return bar
    }()

    var progress: Float = 0
    var downloadProgress: Float = 0 {
        didSet {
            progressBar.setProgress(downloadProgress, animation: true)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }

    private func commonInit() {
        addSubview(leftLabel)
        addSubview(rightLabel)
        layer.addSublayer(progressBar)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        leftLabel.frame = CGRect(x: 0, y: 0, width: 50, height: 25)
        progressBar.frame = CGRect(x: 50, y: 11.5, width: bounds.width - 100, height: 2)
        rightLabel.frame = CGRect(x: bounds.width - 50, y: 0, width: 100, height: 25)
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    private class ProgressBar: CALayer {
        @objc private var progress: Float = 0

        override class func needsDisplay(forKey key: String) -> Bool {
            if key == "progress" {
                return true
            }
            return super.needsDisplay(forKey: key)
        }

        func setProgress(_ progress: Float, animation: Bool = false) {
            self.removeAllAnimations()
            if animation {
                let animation = CABasicAnimation(keyPath: "progress")
                animation.duration = 0.5 * Double(fabs(progress - self.progress))
                animation.fromValue = self.progress
                animation.toValue = progress
                animation.isRemovedOnCompletion = false
                animation.fillMode = kCAFillModeForwards
                self.add(animation, forKey: "progress")
            }
            self.progress = progress
        }

        override func draw(in ctx: CGContext) {
            ctx.setFillColor(UIColor.blue.cgColor)
            ctx.addRect(CGRect(x: 0, y: 0, width: bounds.width * CGFloat(progress), height: bounds.height))
            ctx.fillPath()
        }
    }
}
