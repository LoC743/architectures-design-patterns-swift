
// MARK: Decorator

protocol Coffee: CustomStringConvertible {
    var price: Int { get }
}

extension Coffee {
    var description: String {
        "[\(type(of: self))] Price: \(price)"
    }
}

class SimpleCoffee: Coffee {
    var price: Int {
        100
    }
}

protocol CoffeeDecorator: Coffee {
    var coffee: Coffee { get }
    init(base on: Coffee)
}

class Milk: CoffeeDecorator {
    var coffee: Coffee

    var price: Int {
        coffee.price + 20
    }
    
    required init(base on: Coffee) {
        self.coffee = on
    }
}

class Whip: CoffeeDecorator {
    var coffee: Coffee

    var price: Int {
        coffee.price + 10
    }
    
    required init(base on: Coffee) {
        self.coffee = on
    }
}

class Sugar: CoffeeDecorator {
    var coffee: Coffee

    var price: Int {
        coffee.price + 5
    }
    
    required init(base on: Coffee) {
        self.coffee = on
    }
}

// MARK: - Example

let simpleCoffee = SimpleCoffee()
print(simpleCoffee)

let coffeeWithMilk = Milk(base: simpleCoffee)
print(coffeeWithMilk)

let coffeeWithWhip = Whip(base: simpleCoffee)
print(coffeeWithWhip)

let coffeeWithSugar = Sugar(base: simpleCoffee)
print(coffeeWithSugar)
 
let coffeeWithMilknSugar = Sugar(base: coffeeWithMilk)
print("[Milk] + \(coffeeWithMilknSugar)")

let coffeeWithSugarnMilk = Milk(base: coffeeWithSugar)
print("[Sugar] + \(coffeeWithSugarnMilk)")

let coffeeWithEverything = Sugar(
    base: Whip(
        base: Milk(
            base: simpleCoffee
        )
    )
)
print("[Milk] + [Whip] + \(coffeeWithEverything)")
