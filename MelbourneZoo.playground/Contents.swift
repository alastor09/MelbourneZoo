//: Playground - noun: a place where people can play

import UIKit

enum Sex{
    case female
    case male
    case other
}

enum Size: Int{
    case extraSmall = 0
    case small
    case medium
    case large
    case extraLarge
}

enum Diet: Int{
    case carnivore = 0
    case herbivore
}

protocol Animal{
    var name: String { get }
    var sex: Sex { get }
    var size: Size { get }
    var age: Int { get }
    var weight: Double { get }
    var diet: Diet { get }
}

protocol Travel{
    func canTravel(with animal: Animal) -> Bool
}

extension Travel where Self: Animal{
    func canTravel(with animal: Animal) -> Bool{
        return diet == .carnivore ? false :  diet == animal.diet
    }
}

protocol MeatPortion{
    func meatPortion(completion: (Portion<Double>) -> Void)
}

enum Portion<T>{
    case portion(T)
    case error(string: String)
}

extension MeatPortion where Self: Animal{
    func meatPortion(completion: (Portion<Double>) -> Void){
        diet == .carnivore ? completion(Portion.portion(Double(size.rawValue) * weight)) : completion(Portion.error(string: "Wrong Question, Can't Eat Meat"))
    }
}

protocol Swimable{
    var swimSpeed: Double { get }
}

extension Swimable{
    var swimSpeed: Double { return 40.0 }
}

protocol AdjustedSpeed{
    func adjustedSpeed() -> Double
}

protocol EnclosureSize{
    func enclosureSize() -> Double
}

typealias EatingTravelAnimals =  Animal & MeatPortion & Travel & CustomStringConvertible

extension CustomStringConvertible where Self: Animal{
    var description: String {
        return "Animal: \(name)\n"
    }
}

struct Mammal: EatingTravelAnimals, Swimable, EnclosureSize{
    let name: String
    let sex: Sex
    let size: Size
    let age: Int
    let weight: Double
    let diet: Diet
    
    func enclosureSize() -> Double {
        return Double(size.rawValue) * weight
    }
}

struct Fish: EatingTravelAnimals, Swimable, AdjustedSpeed{
    let name: String
    let sex: Sex
    let size: Size
    let age: Int
    let weight: Double
    let diet: Diet
    
    func adjustedSpeed() -> Double {
        return (swimSpeed/weight) / Double(age)
    }
}

struct Bird: EatingTravelAnimals, Swimable{
    let name: String
    let sex: Sex
    let size: Size
    let age: Int
    let weight: Double
    let diet: Diet
}

struct Reptile: EatingTravelAnimals, Swimable{
    let name: String
    let sex: Sex
    let size: Size
    let age: Int
    let weight: Double
    let diet: Diet
    
}

struct Invertebrate: EatingTravelAnimals{
    let name: String
    let sex: Sex
    let size: Size
    let age: Int
    let weight: Double
    let diet: Diet
}

struct MelbourneZoo<T> {
    private var animals = [T]()
    
    subscript(index: Int) -> T{
        set{
            animals += [newValue]
        }
        
        get {
            return animals[index]
        }
    }
    
    mutating func append(animal: T){
        animals += [animal]
    }
    
    var numberOfAnimals: Int{
        return animals.count
    }
    
    func allAnimals() -> [T] {
        return animals
    }
    
    func allTypes<U>() -> [U] {
        return animals.filter { $0 is U }.map { $0 as! U }
    }
}

func animalsTravelTogether(animals: [Animal]) -> [Diet: [Animal]]{
    var animalsWithDiet: [Diet: [Animal]] = [:]
    for diet in iterateEnum(Diet.self){
        let dietAnimal = animals.filter({ return $0.diet == diet})
        animalsWithDiet[diet] = dietAnimal
    }
    return animalsWithDiet
}

func +=<T> (lhs: inout MelbourneZoo<T>, rhs: T) -> MelbourneZoo<T>{
    lhs[lhs.numberOfAnimals + 1] = rhs
    return lhs
}

func iterateEnum<T: Hashable>(_: T.Type) -> AnyIterator<T> {
    var i = 0
    return AnyIterator {
        let next = withUnsafeBytes(of: &i) { $0.load(as: T.self) }
        if next.hashValue != i { return nil }
        i += 1
        return next
    }
}

func animalsWithBiggerEnclosureSize(size: Size, animals: [Animal]) -> [Animal]{
    let biggerAnimals = animals.filter( {$0.size.rawValue >= size.rawValue} )
    return biggerAnimals
}

let polarBear = Mammal(name: "Polar Bear", sex: .male, size: .large, age: 20, weight: 450, diet: .carnivore)
let lion = Mammal(name: "Lion", sex: .female, size: .large, age: 10, weight: 250, diet: .carnivore)
let shark = Fish(name: "Shark", sex: .female, size: .large, age: 5, weight: 1000, diet: .carnivore)
let eagle = Bird(name: "Eagle", sex: .male, size: .medium, age: 2, weight: 5, diet: .carnivore)
let tarantula = Invertebrate(name: "Tarantula", sex: .female, size: .extraSmall, age: 1, weight: 0.5, diet: .carnivore)
let snake = Reptile(name: "Snake", sex: .female, size: .small, age: 1, weight: 0.5, diet: .carnivore)
let elephant = Mammal(name: "Elephant", sex: .male, size: .extraLarge, age: 15, weight: 5400, diet: .herbivore)
let seal = Mammal(name: "Seal", sex: .male, size: .medium, age: 3, weight: 75, diet: .carnivore)
let koala = Mammal(name: "Koala", sex: .female, size: .medium, age: 2, weight: 15, diet: .herbivore)


polarBear.swimSpeed
shark.adjustedSpeed()
snake.swimSpeed
lion.swimSpeed
polarBear.enclosureSize()
koala.swimSpeed
koala.sex

polarBear.meatPortion { (portion) in
    switch portion{
    case .portion(let meatValue):
        print(meatValue)
    case .error(let errorString):
        print(errorString)
    }
}

elephant.meatPortion { (portion) in
    switch portion{
    case .portion(let meatValue):
        print(meatValue)
    case .error(let errorString):
        print(errorString)
    }
}

koala.meatPortion { (portion) in
    switch portion{
    case .portion(let meatValue):
        print(meatValue)
    case .error(let errorString):
        print(errorString)
    }
}

var zoo = MelbourneZoo<Animal>()

zoo += lion
zoo += polarBear
zoo += shark
zoo += snake
zoo += eagle
zoo += tarantula
zoo += elephant
zoo += seal
zoo += koala

zoo.allAnimals()
zoo.numberOfAnimals

print(koala.canTravel(with: lion))
print(polarBear.canTravel(with: lion))
print(elephant.canTravel(with: koala))

let animalsTravelling = animalsTravelTogether(animals: zoo.allAnimals())
print("Animals Traveling Together:\n \(animalsTravelling)")

let truckAnimals = animalsWithBiggerEnclosureSize(size: .large, animals: zoo.allAnimals())
print("Needs truck to transport:\n \(truckAnimals)")


let animalsEnclosed = (zoo.allTypes() as [Mammal]).sorted(by: { return $0.enclosureSize() < $1.enclosureSize() })
print("Animals with enclosure Size in increasing order:\n \(animalsEnclosed)")

