//
//  QuestionsStorage.swift
//  WhoWantsToBeAmillionaire
//
//  Created by Alexey on 22.02.2021.
//

import Foundation

class QuestionsStorage {
    static var shared = QuestionsStorage()
        
    private let questionsCaretaker = QuestionCaretaker()
    private(set) lazy var questions: [Question] = {
        let loadedQuestions = questionsCaretaker.loadQuestions()
        if loadedQuestions.isEmpty {
            questionsCaretaker.saveQuestions(questions: defaultQuestions)
            return defaultQuestions
        }
        
        return loadedQuestions
    }() {
        didSet {
            questionsCaretaker.saveQuestions(questions: questions)
        }
    }
    private let defaultQuestions = {
        return [
            Question(id: 1, text: "Как характеризуют человека, одетого во всё новое?", correctAnswer: "одет с иголочки",
                     answers: ["одет с иголочки", "одет с напёрсточка", "одет с булавочки", "одет с ниточки"]),
            Question(id: 2, text: "Из чего сделаны ядра орехов, которые грызёт белка в \"Сказке о царе Салтане\"?", correctAnswer: "изумруд",
                     answers: ["янтарь", "изумруд", "рубин", "гранит"]),
            Question(id: 3, text: "Кто занимался подготовкой волокна к прядению?", correctAnswer: "трепач",
                     answers: ["болтун", "фразёр", "балабол", "трепач"]),
            Question(id: 4, text: "Как жители Лондона прозвали свой метрополитен?", correctAnswer: "труба",
                     answers: ["труба", "червяк", "горло", "вена"]),
            Question(id: 5, text: "Где изображён герб на 10-рублёвой монете?", correctAnswer: "на аверсе",
                     answers: ["на гурте", "на канте", "на реверсе", "на аверсе"]),
            Question(id: 6, text: "Кто играл в кино сотрудника МУРа Владимира Шарапова?", correctAnswer: "Владимир Конкин",
                     answers: ["Владимир Конкин", "Алексей Баталов", "Георгий Жжёнов", "Сергей Шакуров"]),
            Question(id: 7, text: "Какой самолёт можно увидеть в Музее авиации и космонавтики в Ле-Бурже?", correctAnswer: "ЯК-3",
                     answers: ["АН-12", "ТУ-104", "ЯК-3", "ПО-2"]),
            Question(id: 8, text: "В каком городе находился цирк, где выступал мистер Икс, герой оперетты Имре Кальмана \"Принцесса цирка\"?", correctAnswer: "в Санкт-Петербурге",
                     answers: ["в Вене", "в Будапеште", "в Санкт-Петербурге", "в Париже"]),
            Question(id: 9, text: "В честь какого географического объекта супруги Киплинг назвали сына Редьярдом?", correctAnswer: "озеро",
                     answers: ["озеро", "гора", "река", "город"]),
            Question(id: 10, text: "Что с 1714 года Пётр I запретил делать во всех российских городах, кроме Санкт-Петербурга?", correctAnswer: "строить каменные дома",
                     answers: ["устраивать баллы и ассамблеи", "ездить на каретах", "строить каменные дома", "казнить купцов"])
        ]
    }()
    
    private init() {}
    
    func add(question: Question) {
        questions.append(question)
    }
}
