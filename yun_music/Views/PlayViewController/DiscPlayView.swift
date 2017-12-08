//
//  DiscPlayView.swift
//  yun_music
//
//  Created by yang on 14/11/2017.
//  Copyright © 2017 ocean. All rights reserved.
//

import UIKit

class DiscPlayView: UIView {

    @IBOutlet weak var needleImageView: UIImageView!
    @IBOutlet weak var needleTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var needleCenterXConstraint: NSLayoutConstraint!

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var preDiscView: CircleView!
    @IBOutlet weak var curDiscView: CircleView!
    @IBOutlet weak var nextDiscView: CircleView!

    var currentIndex = 0
    var isPlaying = false
    weak var dataSource: DiscPlayViewDataSource?
    weak var delegate: DiscPlayViewDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()

        needleImageView.layer.anchorPoint = CGPoint(x: 54 / CGFloat(194), y: 54 / CGFloat(306))
        needleTopConstraint.constant -= 49
        needleCenterXConstraint.constant -= 21
        needleImageView.layer.transform = CATransform3DMakeRotation(-0.5, 0, 0, 1)

        scrollView.showsHorizontalScrollIndicator = false
        scrollView.setContentOffset(CGPoint(x: scrollView.bounds.width, y: 0), animated: false)
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    func setupImages() {
        preDiscView.img = dataSource?.discPlayView(self, imgForIndex: currentIndex - 1)
        curDiscView.img = dataSource?.discPlayView(self, imgForIndex: currentIndex)
        nextDiscView.img = dataSource?.discPlayView(self, imgForIndex: currentIndex + 1)
    }
}

extension DiscPlayView {
    func pause() {
        isPlaying = false
        curDiscView.pauseAnimation()
        UIView.animate(withDuration: 0.5, animations: {
            self.needleImageView.layer.transform = CATransform3DMakeRotation(-0.5, 0, 0, 1)
        })
    }

    func resume() {
        isPlaying = true
        UIView.animate(withDuration: 0.5, animations: {
            self.needleImageView.layer.transform = CATransform3DIdentity
        }, completion: { [weak self] (_) in
            self?.curDiscView.resumeAnimation()
        })
    }
}

extension DiscPlayView: UIScrollViewDelegate {

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        curDiscView.pauseAnimation()
        UIView.animate(withDuration: 1, animations: {
            self.needleImageView.layer.transform = CATransform3DMakeRotation(-0.5, 0, 0, 1)
        })
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                   withVelocity velocity: CGPoint,
                                   targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        scrollView.isUserInteractionEnabled = false
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollView.isUserInteractionEnabled = true
        if scrollView.contentOffset.x <= 0 {
            curDiscView.reset()
            scrollView.setContentOffset(CGPoint(x: scrollView.bounds.width, y: 0), animated: false)
            currentIndex -= 1
            setupImages()
            delegate?.discPlayViewDidPre(self)
        } else if scrollView.contentOffset.x >= scrollView.bounds.width * 2 {
            curDiscView.reset()
            scrollView.setContentOffset(CGPoint(x: scrollView.bounds.width, y: 0), animated: false)
            currentIndex += 1
            setupImages()
            delegate?.discPlayViewDidNext(self)
        }

        if isPlaying {
            UIView.animate(withDuration: 0.5, animations: {
                self.needleImageView.layer.transform = CATransform3DIdentity
            }, completion: { [weak self] (_) in
                self?.curDiscView.resumeAnimation()
            })
        }
    }
}

protocol DiscPlayViewDelegate: NSObjectProtocol {

    func discPlayViewDidPre(_ discPlayView: DiscPlayView)
    func discPlayViewDidNext(_ discPlayView: DiscPlayView)
}

protocol DiscPlayViewDataSource: NSObjectProtocol {
    func discPlayView(_ discPlayView: DiscPlayView, imgForIndex index: Int) -> UIImage?
}
