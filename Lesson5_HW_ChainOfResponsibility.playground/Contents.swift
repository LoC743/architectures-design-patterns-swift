import UIKit
import Foundation

func data(from file: String) -> Data {
    let path1 = Bundle.main.path(forResource: file, ofType: "json")!
    let url = URL(fileURLWithPath: path1)
    let data = try! Data(contentsOf: url)
    return data
}

let data1 = data(from: "1")
let data2 = data(from: "2")
let data3 = data(from: "3")


// MARK: Soulution

struct Person: CustomStringConvertible {
    var name: String
    var age: Int
    var isDeveloper: Bool
    
    var description: String {
        return "\nstruct Person:\nname: \(name)\nage: \(age)\nisDeveloper: \(isDeveloper)\n"
    }
}

class FirstJSONPaser: Decodable {
    var persons: [Person] = []
    
    enum ResponseCodingKeys: String, CodingKey {
        case data
    }
    
    enum PersonCodingKeys: String, CodingKey {
        case name
        case age
        case isDeveloper
    }
    
    required init(from decoder: Decoder) throws {
        let response = try decoder.container(keyedBy: ResponseCodingKeys.self)
        
        var data = try response.nestedUnkeyedContainer(forKey: .data)
        let dataCount: Int = data.count ?? 0
        
        for _ in 0..<dataCount {
            let personContainer = try data.nestedContainer(keyedBy: PersonCodingKeys.self)
            
            let personName: String = try personContainer.decode(String.self, forKey: .name)
            let personAge: Int = try personContainer.decode(Int.self, forKey: .age)
            let isPersonDeveloper: Bool = try personContainer.decode(Bool.self, forKey: .isDeveloper)
            
            let person = Person(name: personName, age: personAge, isDeveloper: isPersonDeveloper)
            
            persons.append(person)
        }
    }
}

//
//if let requestData = try? JSONDecoder().decode(FirstJSONPaser.self, from: data1) {
//    print(requestData.persons)
//}

class SecondJSONPaser: Decodable {
    var persons: [Person] = []
    
    enum ResponseCodingKeys: String, CodingKey {
        case result
    }
    
    enum PersonCodingKeys: String, CodingKey {
        case name
        case age
        case isDeveloper
    }
    
    required init(from decoder: Decoder) throws {
        let response = try decoder.container(keyedBy: ResponseCodingKeys.self)
        
        var data = try response.nestedUnkeyedContainer(forKey: .result)
        let dataCount: Int = data.count ?? 0
        
        for _ in 0..<dataCount {
            let personContainer = try data.nestedContainer(keyedBy: PersonCodingKeys.self)
            
            let personName: String = try personContainer.decode(String.self, forKey: .name)
            let personAge: Int = try personContainer.decode(Int.self, forKey: .age)
            let isPersonDeveloper: Bool = try personContainer.decode(Bool.self, forKey: .isDeveloper)
            
            let person = Person(name: personName, age: personAge, isDeveloper: isPersonDeveloper)
            
            persons.append(person)
        }
    }
}

//
//if let requestData = try? JSONDecoder().decode(SecondJSONPaser.self, from: data2) {
//    print(requestData.persons)
//}

class ThirdJSONPaser: Decodable {
    var persons: [Person] = []
    
    enum PersonCodingKeys: String, CodingKey {
        case name
        case age
        case isDeveloper
    }
    
    required init(from decoder: Decoder) throws {
        var response = try decoder.unkeyedContainer()
        
        let dataCount: Int = response.count ?? 0
        for _ in 0..<dataCount {
            let personContainer = try response.nestedContainer(keyedBy: PersonCodingKeys.self)
            
            let personName: String = try personContainer.decode(String.self, forKey: .name)
            let personAge: Int = try personContainer.decode(Int.self, forKey: .age)
            let isPersonDeveloper: Bool = try personContainer.decode(Bool.self, forKey: .isDeveloper)
            
            let person = Person(name: personName, age: personAge, isDeveloper: isPersonDeveloper)
            
            persons.append(person)
        }
    }
}

//if let requestData = try? JSONDecoder().decode(ThirdJSONPaser.self, from: data3) {
//    print(requestData.persons)
//}
