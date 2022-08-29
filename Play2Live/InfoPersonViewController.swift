//
//  InfoPersonViewController.swift
//  Play2Live
//
//  Created by Алексей on 18.08.2022.


import UIKit

class InfoPersonViewController: UIViewController {
    
    let storage: Storage
    var gender: Gender?
    var date: Date?
    var continent: Continent?
    var restTime: Int?
    var goneTime: Int?
    
    let genderButton = UIButton(configuration: .gray())
    let continentButton = UIButton(configuration: .gray())
    
    let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.date = Date()//текущая дата
        picker.locale = .current//часовой пояс ну типа
        picker.preferredDatePickerStyle = .compact
        picker.datePickerMode = .date
        
        return picker
    }()
    
    let sexLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title2)
        label.numberOfLines = 0
        label.text = "Your sex"
        return label
    }()
    
    let dateOfBurthLabel: UILabel = {
        let burthLabel = UILabel()
        burthLabel.font = .preferredFont(forTextStyle: .title2)
        burthLabel.numberOfLines = 0
        burthLabel.text = "Date of burthday"
        return burthLabel
    }()
    
    let continentAreaLabel: UILabel = {
        let areaLabel = UILabel()
        areaLabel.font = .preferredFont(forTextStyle: .title2)
        areaLabel.numberOfLines = 0
        areaLabel.text = "Your area"
        return areaLabel
    }()
    
    let nextButton : UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.setTitle("Next", for: .normal)
        button.backgroundColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init(storage: Storage) {
        self.storage = storage
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
       
        addSexLabel()
        addSexButton()
        addContinentLabel()
        addContinentButton()
        addDatePicker()
        addDateOfBurthLabel()
        addNextButton()
        title = "Personal info"
        view.backgroundColor = .white
        nextButton.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
    }
    
    @objc func nextButtonPressed(){
        guard let goneTime = goneTime,
              let restTime = restTime,
              let gender = gender,
              let continent = continent
        else { return }

        let personalInfo = UserData(restTime: restTime, goneTime: goneTime, gender: gender, continent: continent)
        let rootVC = CountdownViewController()
        storage.delete()
        storage.save(data: personalInfo)
        navigationController?.pushViewController(rootVC, animated: true)
        
    }
    
    func addSexLabel() {
        view.addSubview(sexLabel)
        sexLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sexLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            sexLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            sexLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    func addDateOfBurthLabel() {
        view.addSubview(dateOfBurthLabel)
        dateOfBurthLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateOfBurthLabel.topAnchor.constraint(equalTo: continentButton.bottomAnchor, constant: 20),
            dateOfBurthLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            dateOfBurthLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            dateOfBurthLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func addContinentLabel() {
        view.addSubview(continentAreaLabel)
        continentAreaLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            continentAreaLabel.topAnchor.constraint(equalTo: genderButton.bottomAnchor, constant: 20),
            continentAreaLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            continentAreaLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            continentAreaLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func addSexButton() {
        genderButton.configuration?.cornerStyle = .medium
        genderButton.configuration?.title = "Select SEX"
        genderButton.menu = sexButtonMenu()
        genderButton.showsMenuAsPrimaryAction = true // вылетает меню, без нее холдить надо
        view.addSubview(genderButton)
        genderButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            genderButton.topAnchor.constraint(equalTo: sexLabel.bottomAnchor, constant: 20),
            genderButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            genderButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            genderButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func sexButtonMenu() -> UIMenu  {
        let items = Gender.allCases.map { gender in
            UIAction(title: gender.rawValue) { [unowned self] _ in // от утечки памяти weak self - помечено @escaping
                sexLabel.text = "Your sex: \(gender.rawValue)"
                self.gender = gender
            }
        }
        return UIMenu(title: "", children: items)
    }
    
    func addContinentButton() {
        continentButton.configuration?.cornerStyle = .medium
        continentButton.configuration?.title = "Select area"
        continentButton.menu = continentButtonMenu()
        continentButton.showsMenuAsPrimaryAction = true // вылетает меню, без нее холдить надо
        view.addSubview(continentButton)
        continentButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            continentButton.topAnchor.constraint(equalTo: continentAreaLabel.bottomAnchor, constant: 20),
            continentButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            continentButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            continentButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func continentButtonMenu() -> UIMenu {
        let items = Continent.allCases.map { continent in
            UIAction(title: continent.rawValue) { [unowned self] _ in
                continentAreaLabel.text = "Your area: \(continent.rawValue)"
                self.continent = continent
            }
        }
        return UIMenu(title: "", children: items)
    }
    
    func addDatePicker() {
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        view.addSubview(datePicker)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            datePicker.topAnchor.constraint(equalTo: continentButton.bottomAnchor, constant: 20),
            datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            datePicker.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func addNextButton() {
        view.addSubview(nextButton)
        NSLayoutConstraint.activate([
            nextButton.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 30),
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nextButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc
    func dateChanged(_ picker: UIDatePicker) {
        date = picker.date
        let age = userAge(picker.date)
        leftTime(age)
    }
    
    func userAge(_ date:Date) -> Int? {
        Calendar.current.dateComponents([.year], from: date, to: Date()).year
    }
    
    func leftTime(_ age: Int?) {
        guard let age = age,
              let gender = gender,
              let continent = continent
        else { return }
        
        restTime = gender.avarageAge + (continent.avarageContinentAge/3) - age
        goneTime = age
        
        print(gender.avarageAge + (continent.avarageContinentAge/3))
        print(restTime)
        print(goneTime)
        
    }
    
}

//struct PersonInfo {
//    let restTime: Int // осталось прожить
//    let goneTime: Int // прошло = age
//    let allTime: Int // все время
//
//    init(restTime: Int, goneTime: Int, gender: Gender, continent: Continent ){
//        self.restTime = restTime
//        self.goneTime = goneTime
//        allTime = gender.avarageAge + continent.avarageContinentAge/3
//    }
//}

