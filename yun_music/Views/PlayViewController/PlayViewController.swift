//
//  PlayViewController.swift
//  GitHubClient_Example
//
//  Created by yang on 13/11/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import SnapKit

class PlayViewController: UIViewController {

    var player = FSAudioStream(configuration: FSStreamConfiguration())

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var discPlayView: DiscPlayView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var playSlider: PlaySlider!

    var isPlaying = false {
        didSet {
            if isPlaying {
                playButton.setImage(#imageLiteral(resourceName: "cm2_fm_btn_pause"), for: .normal)
                playButton.setImage(#imageLiteral(resourceName: "cm2_fm_btn_pause_prs"), for: .highlighted)
            } else {
                playButton.setImage(#imageLiteral(resourceName: "cm2_fm_btn_play"), for: .normal)
                playButton.setImage(#imageLiteral(resourceName: "cm2_fm_btn_play_prs"), for: .highlighted)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        playButton.addTarget(self, action: #selector(onBtnPlay), for: .touchUpInside)

        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.layer.masksToBounds = true
        backgroundImageView.image = #imageLiteral(resourceName: "1706442046308353")

        discPlayView.dataSource = self
        discPlayView.delegate = self

        playSlider.timeLong = 10
        playSlider.addTarget(self, action: #selector(onChangeProgress), for: .valueChanged)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

@objc extension PlayViewController {
    func onBtnPlay() {
        playSlider.downloadProgress = playSlider.downloadProgress == 1 ? 0.5 : 1
        isPlaying = !isPlaying
        if discPlayView.isPlaying {
            discPlayView.pause()
            playSlider.pause()
        } else {
            discPlayView.resume()
            playSlider.resume()
        }
    }

    func onChangeProgress(slider: PlaySlider) {
        print(slider.progress)
    }
}

let array = [#imageLiteral(resourceName: "1706442046308353"), #imageLiteral(resourceName: "1"), #imageLiteral(resourceName: "2")]

extension PlayViewController: DiscPlayViewDataSource {
    func discPlayView(_ discPlayView: DiscPlayView, imgForIndex index: Int) -> UIImage? {
        let index = ((index % 3) + 3) % 3
        return array[index]
    }
}

extension PlayViewController: DiscPlayViewDelegate {
    func discPlayViewDidPre(_ discPlayView: DiscPlayView) {
        DispatchQueue(label: "img", qos: DispatchQoS.background).async { [weak self] in
            let img = self?.discPlayView(discPlayView,
                                         imgForIndex: discPlayView.currentIndex)
            DispatchQueue.main.async(execute: {
                if img != nil, let `self` = self {
                    UIView.transition(with: self.backgroundImageView,
                                      duration: 1,
                                      options: .transitionCrossDissolve, animations: {
                                          self.backgroundImageView.image = img
                                      })
                }
            })
        }
    }

    func discPlayViewDidNext(_ discPlayView: DiscPlayView) {
        DispatchQueue(label: "img", qos: DispatchQoS.background).async { [weak self] in
            let img = self?.discPlayView(discPlayView,
                                         imgForIndex: discPlayView.currentIndex)
            DispatchQueue.main.async(execute: {
                if img != nil, let `self` = self {
                    UIView.transition(with: self.backgroundImageView, duration: 1, options: .transitionCrossDissolve, animations: {
                        self.backgroundImageView.image = img
                    })
                }
            })
        }
    }
}
