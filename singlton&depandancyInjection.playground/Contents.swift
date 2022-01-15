import UIKit

var greeting = "Hello, playground"
/*I have recently heard that using dependency injection is "the only socially acceptable way to use a singleton in today's software development world". I don't necessarily want to debate the accuracy of this statement right now, as it is mostly opinion-based. My goal right now is to understand how exactly I can use dependency injection with the singleton pattern.
 
 For example, in my latest iOS app, I have a Service layer where I keep my URLSession code. I created this layer as a singleton:*/

struct ServiceSingleton {

    private init(){}

    static let shared = ServiceSingleton()

    func fetchJSON() {
     // URLSession code
    }

}

//  then use shared in my ViewController, as below:
 
 class ViewController: UIViewController {

     override func viewDidLoad() {
         super.viewDidLoad()

         fetchData()

     }

     func fetchData() {

         ServiceSingleton.shared.fetchJSON()
     }

 }

/* Rather than accessing ServiceSingleton.shared directly, you access an instance variable that is injected into your object, usually in the initializer if possible, otherwise as a settable property, post-initialization:*/
 
 protocol FooService {
     func doFooStuff()
 }

 class ProductionFooService: FooService {

     private init() {}

     static let shared = ProductionFooService()

     func doFooStuff() {
         print("real URLSession code goes here")
     }

 }

 struct MockFooService: FooService {
     func doFooStuff() {
         print("Doing fake foo stuff!")
     }
 }

 class FooUser {
     let fooService: FooService

     init(fooService: FooService) { // "initializer based" injection
         self.fooService = fooService
     }

     func useFoo() {
         fooService.doFooStuff() // Doesn't directly call ProductionFooService.shared.doFooStuff
     }
 }

 let isRunningInAUnitTest = false

 let fooUser: FooUser
 if !isRunningInAUnitTest {
     fooUser = FooUser(fooService: ProductionFooService.shared) // In a release build, this is used.
 }
 else {
     fooUser = FooUser(fooService: MockFooService()) // In a unit test, this is used.
 }

 fooUser.useFoo()

/* Typically initialization of ViewControllers is done by your storyboards, so you can't ingect your dependancies via initializer parameters, and will have to instead use stored properties that are set after object initialization.
 Could you explain to me what this achieves?
 Your code is no longer coupled to ProductionFooService.shared. As a result of this, you can introduce different implementations of FooService, such as one for a beta environment, a mock one for unit testing, etc.

 If all your code pervasively directly uses your prod dependancies, you'll...

 find that it's impossible to instantiate your objects in a test environment. You don't want your unit tests, CI test environments, beta environments, etc. connecting to prod databases, services and APIs.
 Have no true "unit" tests. Every test will be testing a unit of code, plus all of the common dependancies that it transitively depends on. If you were to ever make a code change to one of these dependancies, it would break most of the unit tests in your system, which makes it harder to pin down exactly what failed. By decoupling your dependancies, you can use mock objects that do the bare minimum necessary to support a unit test, and ensure that each test is only testing a particular unit of code, and not the transitive dependancies it relies on.
 Should I always use DI when I use the singleton pattern in my iOS projects from now on?
 It's a good habit to pick up. Of course, there are qucik-and-dirty-projects for which you just want to move fast and won't really care, but it'll surprise you how many of these supposed qucik-and-dirty-projects actually take off, and pay the cost down the road. You just need to be cognizant of when you're hindering yourself by not taking some extra time to decouple your decencies.*/
