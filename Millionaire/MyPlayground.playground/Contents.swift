import UIKit


 enum Action {
     enum Engine{
         case run
         case thicken
     }

     enum Windows{
         case open
         case close
     }

     enum Baggage{
         case load(count: Int)
         case unload(count: Int)
     }
 }

 let baggage = Action.Baggage.self

struct SportCar: CustomStringConvertible {
    
    var description: String {
        """
        Общие сведения:\nМашина: \(brand)
        Год выпуска: \(yearOfIssue)
        Обьем багажа: \(volumeTrunk)
        Двигатель: \(engine == .run ? "запущен" : "заглушен...")
        """
    }
    
    let brand: String
    let yearOfIssue: Int
     var volumeTrunk: Int
     var engine: Action.Engine {
         willSet {
             if newValue == .run {
                 if newValue == .run {
                     engine == .run ? print("Двигатель автомобиля \(brand) - уже запущен") : print("Двигатель автомобиля \(brand) - запущен")
                 } else if newValue == .thicken {
                     engine == .thicken ? print("Двигатель автомобиля \(brand) - уже заглушен") : print("Двигатель автомобиля \(brand) - заглушен")
                 }
         }
     }
     }
     var windows: Action.Windows {
         willSet {
             if newValue == .close {
                 windows == .open ? print("Окна автомобиля \(brand) - уже открыты") : print("Окна автомобиля \(brand) - открыты")
             } else if newValue == .close {
                 windows == .close ? print("Окна автомобиля \(brand) - уже закрыты") : print("Окна автомобиля \(brand) - закрыты")
             }
         }
     }
     var filledTrunkVolume: Int
     mutating func action(_ action: Action.Baggage){
         switch action {
         case .load(_) where filledTrunkVolume == volumeTrunk:
             print("Багажник заполнен")
         case .load(count: let count) where count + filledTrunkVolume > volumeTrunk:
             print("Слишком объемный груз")
         case .load(count: let count):
             filledTrunkVolume += count
             print("В багажник загружен груз объемом \(count) литров")
         case .unload(_) where filledTrunkVolume == 0:
             print("Багажник пустой")
         case .unload(count: let count) where count > filledTrunkVolume:
             print("В багажнике нет такого объема груза")
         case .unload(count: let count):
             filledTrunkVolume -= count
             print("Из багажника выгружен груз объемом \(count)")
         }
         print("Багажник заполнен \(filledTrunkVolume)/\(volumeTrunk)")
     }

    
 }

struct TrunkCar {
    let brand: String
    let yearOfIssue: Int
    var volumeBody: Int
    var engine: Action.Engine {
        willSet {
            if newValue == .run {
                engine == .run ? print("Двигатель автомобиля \(brand) - уже запущен") : print("Двигатель автомобиля \(brand) - запущен")
            } else if newValue == .thicken {
                engine == .thicken ? print("Двигатель автомобиля \(brand) - уже заглушен") : print("Двигатель автомобиля \(brand) - заглушен")
            }
        }
    }
    var windows: Action.Windows {
        willSet {
            if newValue == .open {
                windows == .open ? print("Окна автомобиля \(brand) - уже открыты") : print("Окна автомобиля \(brand) - открыты")
            } else if newValue == .close {
                windows == .close ? print("Окна автомобиля \(brand) - уже закрыты") : print("Окна автомобиля \(brand) - закрыты")
            }
        }
    }
    var filledBodyVolume: Int
    mutating func action(_ action: Action.Baggage){
        switch action {
        case .load(_) where filledBodyVolume == volumeBody:
            print("Кузов заполнен")
        case .load(count: let count) where count + filledBodyVolume > volumeBody:
            print("Слишком объемный груз")
        case .load(count: let count):
            filledBodyVolume += count
            print("В кузов загружен груз объемом \(count) литров")
        case .unload(_) where filledBodyVolume == 0:
            print("Кузов пустой")
        case .unload(count: let count) where count > filledBodyVolume:
            print("В кузове нет такого объема груза")
        case .unload(count: let count):
            filledBodyVolume -= count
            print("Из кузова выгружен груз объемом \(count)")
        }
        print("Кузов заполнен \(filledBodyVolume)/\(volumeBody)")
    }
    
}



var sportCar = SportCar(brand: "Mazda CX-9", yearOfIssue: 2020, volumeTrunk: 230, engine: .thicken, windows: .open, filledTrunkVolume: 0)
sportCar.windows = .open
sportCar.windows = .close
sportCar.engine = .run
sportCar.action(baggage.load(count: 231))
sportCar.action(baggage.load(count: 52))
sportCar.action(baggage.unload(count: 13))
print("\n")

var trunkCar = TrunkCar(brand: "MAN TGS", yearOfIssue: 2018, volumeBody: 18000, engine:.run , windows: .close, filledBodyVolume: 12000)
trunkCar.windows = .close
trunkCar.engine = .run
trunkCar.action(baggage.load(count: 10000))
trunkCar.action(baggage.load(count: 2000))
trunkCar.action(baggage.unload(count: 22524))
trunkCar.action(baggage.unload(count: 5220))

print("")
print(sportCar)
