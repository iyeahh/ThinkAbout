//
//  NewMemoViewController.swift
//  ThinkingAbout
//
//  Created by Bora Yang on 2023/10/04.
//

import UIKit

class NewMemoViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var memoTextView: UITextView!
    @IBOutlet weak var dateImageView: UIImageView!
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var finishButton: UIButton!

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var categoryPicker: UIPickerView!

    let memoDataManager = MemoDataManager.shared

    var memoData: MemoData?

    var indexOfMemo: Int = 0

    var currentCategory: Category = Category(type: "업무", color: #colorLiteral(red: 0.9921761155, green: 0.7328807712, blue: 0.4789910913, alpha: 1), image: UIImage(systemName: "text.book.closed"))

    var categoryPickerValue: String = "업무"

    let category = ["업무", "음악", "여행", "공부", "일상", "취미", "쇼핑"]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupImage()
        setupNaviBar()
        setupCategoryPicker()
        setupDatePicker()
        configureUI()
        memoTextView.delegate = self
        checkingButtonValid()
    }

    func checkingButtonValid() {
        if memoTextView.text.isEmpty || memoTextView.text == "텍스트를 여기에 입력하세요." {
            finishButton.isEnabled = false
            finishButton.backgroundColor = UIColor.lightGray
        } else {
            finishButton.isEnabled = true
            finishButton.backgroundColor = #colorLiteral(red: 0.2988972366, green: 0.4551405311, blue: 0.8419892788, alpha: 1)
        }
    }

    func configureUI() {
        if let memoData = self.memoData {
            print(memoData)
            self.title = "메모 수정"

            guard let text = memoData.memoText, let date = memoData.date else { return }
            memoTextView.text = text
            datePicker.date = date

            finishButton.setTitle("수정 완료", for: .normal)
        } else {
            self.title = "새로운 메모 작성"
            memoTextView.text = "텍스트를 여기에 입력하세요."
            memoTextView.textColor = .lightGray
        }
    }

    func setupDatePicker() {
        datePicker.datePickerMode = .date
        datePicker.backgroundColor = #colorLiteral(red: 0.97647053, green: 0.97647053, blue: 0.97647053, alpha: 1)
        datePicker.clipsToBounds = true
        datePicker.layer.cornerRadius = 10

        guard let value = category.firstIndex(of: categoryPickerValue) else { return }
        categoryPicker.selectRow(value, inComponent: 0, animated: false)
    }

    func setupCategoryPicker() {
        categoryPicker.dataSource = self
        categoryPicker.delegate = self
        categoryPicker.backgroundColor = #colorLiteral(red: 0.97647053, green: 0.97647053, blue: 0.97647053, alpha: 1)
        categoryPicker.clipsToBounds = true
        categoryPicker.layer.cornerRadius = 10
    }	

    func setupNaviBar() {
        navigationItem.hidesBackButton = true
    }

    func setupImage() {
        dateImageView.image = UIImage(systemName: "calendar")
        categoryImageView.image = UIImage(systemName: "tray.full")
        dateImageView.tintColor = #colorLiteral(red: 0.2988972366, green: 0.4551405311, blue: 0.8419892788, alpha: 1)
        categoryImageView.tintColor = #colorLiteral(red: 0.2988972366, green: 0.4551405311, blue: 0.8419892788, alpha: 1)
    }

    @IBAction func exitButtonTapped(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func finishButtonTapped(_ sender: UIButton) {

//        guard memoTextView.text != "텍스트를 입력하세요." || !memoTextView.text.isEmpty else {
//
//        }
        if let memoData = self.memoData {

            memoData.memoText = memoTextView.text
            memoData.date = datePicker.date
            memoData.category = currentCategory

            memoDataManager.updateMemo(updatingMemoData: memoData, at: indexOfMemo)
            self.navigationController?.popViewController(animated: true)

        } else {
            let memoText = memoTextView.text
            let date = datePicker.date

            memoDataManager.createMemoData(memoText: memoText, date: date, category: currentCategory)
            self.navigationController?.popViewController(animated: true)

        }
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return category.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return category[row]
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch row {
        case 0:
            currentCategory = Category(type: "업무", color: #colorLiteral(red: 0.9921761155, green: 0.7328807712, blue: 0.4789910913, alpha: 1), image: UIImage(systemName: "text.book.closed"))
        case 1:
            currentCategory = Category(type: "음악", color: #colorLiteral(red: 0.9771121144, green: 0.6577736735, blue: 0.6004146934, alpha: 1), image: UIImage(systemName: "beats.headphones"))
        case 2:
            currentCategory = Category(type: "여행", color: #colorLiteral(red: 0.440038383, green: 0.8220494986, blue: 0.5577589869, alpha: 1), image: UIImage(systemName: "airplane"))
        case 3:
            currentCategory = Category(type: "공부", color: #colorLiteral(red: 0.5635170937, green: 0.5420733094, blue: 0.8248844147, alpha: 1), image: UIImage(systemName: "pencil"))
        case 4:
            currentCategory = Category(type: "일상", color: #colorLiteral(red: 0.8769599795, green: 0.5063646436, blue: 0.4531673789, alpha: 1), image: UIImage(systemName: "house"))
        case 5:
            currentCategory = Category(type: "취미", color: #colorLiteral(red: 0.7281604409, green: 0.5113939643, blue: 0.8102740645, alpha: 1), image: UIImage(systemName: "paintpalette"))
        case 6:
            currentCategory = Category(type: "쇼핑", color: #colorLiteral(red: 0.2690466344, green: 0.7030950189, blue: 0.7497351766, alpha: 1), image: UIImage(systemName: "cart"))
        default:
            currentCategory = Category(type: "업무", color: #colorLiteral(red: 0.9921761155, green: 0.7328807712, blue: 0.4789910913, alpha: 1), image: UIImage(systemName: "text.book.closed"))
        }
    }
}

extension NewMemoViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        checkingButtonValid()
        if textView.text == "텍스트를 여기에 입력하세요." {
            textView.text = nil
            textView.textColor = .black
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        checkingButtonValid()
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = "텍스트를 여기에 입력하세요."
            textView.textColor = .lightGray
        }
    }

    func textViewDidChange(_ textView: UITextView) {
        checkingButtonValid()
    }
}
