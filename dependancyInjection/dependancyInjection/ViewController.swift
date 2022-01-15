//
//  ViewController.swift
//  dependancyInjection
//
//  Created by Ebrahim  Mo Gedamy on 4/1/20.
//  Copyright © 2020 Ebrahim  Mo Gedamy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    ///dependancy injection :-  this something will be done if data passed from view to another
    var someServices : Services
    
    init(services : Services) {
        self.someServices = services
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        
    }
    
    required init(coder : NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        ///->usage of  Singlton👇
        //Services.shared.doStuff()
        
        ///->usage of  Dependancy Injection👇
        someServices.doStuff()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        let secondVC = SecondVC(service: someServices)
        self.present(secondVC, animated: true) {
            print("success")
        }
    }

}

class SecondVC: UIViewController {
    
    let secondServices : Services
    
    init(service : Services) {
        self.secondServices = service
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = #colorLiteral(red: 0, green: 0.8025462031, blue: 0.7598685622, alpha: 0.8)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func doSecondStuff() {
        print("Did stuff from SecondVC ")
        secondServices.doStuff()
    }
}
