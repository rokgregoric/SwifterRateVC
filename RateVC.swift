//
//  RateVC.swift
//  Workouts
//
//  Created by Rok Gregoric on 12/02/2019.
//  Copyright © 2019 Akro-in. All rights reserved.
//

import UIKit
import StoreKit

class RateVC: UIViewController {
  @IBOutlet weak var fadeView: UIView!
  @IBOutlet weak var submitButton: UIButton!
  @IBOutlet var buttons: [UIButton]!

  var rateScore = 0
  static var showCounter = 5

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    fade(dark: false)
  }

  func set(dark: Bool) {
    fadeView.backgroundColor = UIColor.black.withAlphaComponent(dark ? 0 : 0.4)
  }

  func fade(dark: Bool) {
    set(dark: !dark)
    UIView.animate(withDuration: 0.3) {
      self.set(dark: dark)
    }
  }

  @IBAction func tapped(button: UIButton) {
    submitButton.isEnabled = true
    rateScore = button.tag
    buttons.forEach {
      $0.layer.borderWidth = $0 == button ? 2 : 0
      $0.fade()
    }
  }

  func close(completion: @escaping () -> Void) {
    fade(dark: true)
    dismiss(animated: true, completion: completion)
  }

  @IBAction func closeTapped() {
    Defaults.removeObject(for: .rateCounter)
    close {}
  }

  @IBAction func submitTapped() {
    Defaults.set(object: rateScore, for: .rateScore)
    close { if self.rateScore == 5 { SKStoreReviewController.requestReview() } }
  }
}

// MARK: - public methods

extension RateVC {
  static var counter: Int {
    return Defaults.object(for: .rateCounter) ?? showCounter
  }

  static func decrementCounter() {
    return Defaults.set(object: counter-1, for: .rateCounter)
  }

  static var hasBeenRated: Bool {
    return Defaults.hasObject(for: .rateScore)
  }

  static var shouldShow: Bool {
    if hasBeenRated {
      print("rated")
      return false
    }
    print("counter", counter)
    return counter <= 0
  }
}

extension Defaults.Key {
  static let rateCounter = Defaults.Key("rateCounter")
  static let rateScore = Defaults.Key("rateScore")
}

