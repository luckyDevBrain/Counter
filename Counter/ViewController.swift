//
//  ViewController.swift
//  Counter
//
//  Created by Kirill on 05.05.2024.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var counterLabel: UILabel!
  @IBOutlet weak var plusButton: UIButton!
  @IBOutlet weak var minusButton: UIButton!
  @IBOutlet weak var resetButton: UIButton!
  @IBOutlet weak var historyTextView: UITextView!
   
  private var count = 0
  private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd.MM.yyyy HH:mm:ss"
    return formatter
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    setupButtons()
    setupTextView()
    updateDisplay()
  }

  private func setupButtons() {
    plusButton.setTitle("", for: .normal)
    plusButton.tintColor = .red
    plusButton.setImage(UIImage(systemName: "plus"), for: .normal)

    minusButton.setTitle("", for: .normal)
    minusButton.tintColor = .blue
    minusButton.setImage(UIImage(systemName: "minus"), for: .normal)

    resetButton.setTitle("", for: .normal)
    resetButton.tintColor = .systemGray
    resetButton.setImage(UIImage(systemName: "arrow.counterclockwise"), for: .normal)
  }

  private func setupTextView() {
    historyTextView.text = "История изменений:\n"
    historyTextView.isEditable = false
    historyTextView.isScrollEnabled = true
  }

  private func updateDisplay() {
    counterLabel.text = "Значение счётчика: \(count)"
  }

  private func addToHistory(_ message: String) {
    let timestamp = dateFormatter.string(from: Date())
    let historyLine = "\(timestamp): \(message)\n"
    historyTextView.text.append(historyLine)
    historyTextView.scrollRangeToVisible(NSRange(location: historyTextView.text.count - 1, length: 1))
  }

  @IBAction func plusButtonTapped(_ sender: Any) {
    count += 1
    updateDisplay()
    addToHistory("\n значение изменено на +1")
  }

  @IBAction func minusButtonTapped(_ sender: Any) {
    if count > 0 {
      count -= 1
      updateDisplay()
      addToHistory("\n значение изменено на -1")
    } else {
      addToHistory("\n попытка уменьшить значение счётчика ниже 0")
    }
  }

  @IBAction func resetButtonTapped(_ sender: Any) {
    count = 0
    updateDisplay()
    addToHistory("\n значение сброшено")
  }
}
