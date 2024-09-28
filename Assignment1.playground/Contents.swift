import UIKit

class Person{
    var name: String
    weak var car: Car?

    init(name: String, car: Car? = nil) {
        self.name = name
        self.car = car
    }
    
    deinit {
        print("deinit person")
    }
}

class Car{
    var model: String
    var driver: Person?
    
    init(model: String, driver: Person? = nil) {
        self.model = model
        self.driver = driver
    }
    
    lazy var printCarsModelAction: () -> Void = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                print("Car model: \(self.model)" )
            }
        }
    
    deinit {
        print("deinit car")
    }
}

do{
    var person = Person(name: "Sona")
    var car = Car(model: "BMW")
    
    person.car = car
    car.driver = person
    
    car.printCarsModelAction()
}

