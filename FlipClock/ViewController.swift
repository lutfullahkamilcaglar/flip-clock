//
//  ViewController.swift
//  FlipClock
//
//  Created by Kamil Caglar on 07/11/2022.
//

import UIKit
import Splitflap

class ViewController: UIViewController, SplitflapDataSource, SplitflapDelegate {
  @IBOutlet weak var splitflap: Splitflap!
  @IBOutlet weak var actionButton: UIButton!

  fileprivate let words        = ["Hey you", "Bonsoir", "12h15", "Arrival"]
  fileprivate var currentIndex = 0

  override func viewDidLoad() {
    super.viewDidLoad()
      let splitflapView = Splitflap(frame: CGRect(x: 0, y: 0, width: 370, height: 53))
      splitflapView.datasource = self

      
    
    splitflap.datasource = self
    splitflap.delegate   = self
    splitflap.reload()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    updateSplitFlapAction(actionButton)
  }

  // MARK: - Action Methods
  @IBAction func updateSplitFlapAction(_ sender: AnyObject) {
    splitflap.setText(words[currentIndex], animated: true, completionBlock: {
      print("Display finished!")
    })

    currentIndex = (currentIndex + 1) % words.count

    updateButtonWithTitle(words[currentIndex])
  }

  fileprivate func updateButtonWithTitle(_ title: String) {
    actionButton.setTitle("Say \(words[currentIndex])!", for: UIControl.State())
  }

  // MARK: - Splitflap DataSource Methods
  func numberOfFlapsInSplitflap(_ splitflap: Splitflap) -> Int {
    return 7
  }

  func tokensInSplitflap(_ splitflap: Splitflap) -> [String] {
    return SplitflapTokens.AlphanumericAndSpace
  }

  // MARK: - Splitflap Delegate Methods
  func splitflap(_ splitflap: Splitflap, rotationDurationForFlapAtIndex index: Int) -> Double {
    return 0.2
  }

  func splitflap(_ splitflap: Splitflap, builderForFlapAtIndex index: Int) -> FlapViewBuilder {
    return FlapViewBuilder { builder in
      builder.backgroundColor = .black
      builder.cornerRadius    = 5
      builder.font            = UIFont(name: "Courier", size: 50)
      builder.textAlignment   = .center
      builder.textColor       = .white
      builder.lineColor       = .darkGray
    }
  }
}
