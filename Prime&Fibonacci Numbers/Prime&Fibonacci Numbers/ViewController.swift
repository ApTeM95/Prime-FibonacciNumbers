//
//  ViewController.swift
//  Prime&Fibonacci Numbers
//
//  Created by Артем on 11.07.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var quantityTextField: UITextField!
    @IBOutlet weak var stepper: UIStepper!
    
    private var generator = NumberGenerator(.prime, 10)
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "numberCell")
        tableView.register(UINib(nibName: "NumbersTableViewCell", bundle: nil), forCellReuseIdentifier: "numberCell")
        
        quantityTextField.delegate = self
        quantityTextField.addDoneButtonOnKeyboard()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        generator.generateFirstNumbers { (success) in
            guard success else {
                return
            }
            self.tableView.reloadData()
        }
    }
}

extension ViewController {
    //MARK: - Actions
    
    @IBAction func stepperValueDidChange(_ sender: UIStepper) {
        let value = Int(sender.value)
        quantityTextField.text = "\(value)"
        generator.changeQuatity(value)
    }
    
    @IBAction func segmentControlDidChangeValue(_ sender: UISegmentedControl) {
        guard let type = NumberType(rawValue: sender.selectedSegmentIndex) else {
            return
        }
        generator.changeType(type)
        generator.generateFirstNumbers { (success) in
            guard success else {
                return
            }
            self.tableView.reloadData()
        }
        self.tableView.reloadData()
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text, let quantity = Int(text) {
            stepper.value = Double(quantity)
            generator.changeQuatity(quantity)
        }
        return true
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? generator.numberDataSource.count : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.section == 0 else {
            return tableView.dequeueReusableCell(withIdentifier: "progressCell") ?? UITableViewCell()
        }
        if let cell = tableView.dequeueReusableCell(withIdentifier: "numberCell") as? NumbersTableViewCell {
            cell.tag = indexPath.row
            guard indexPath.row < generator.numberDataSource.count else {
                return UITableViewCell()
            }
            let pair = generator.numberDataSource[indexPath.row]
            cell.fillCellWith(leftNumber: pair.leftNumber, rightNumber: pair.rightNumber)
            if indexPath.row + 2 >= generator.numberDataSource.count {
                generator.generateNextNumbers { (success) in
                    guard success else {
                        return
                    }
                    self.tableView.reloadData()
                }
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
