//
//  Student.swift
//  StudentApp
//
//  Created by Cntt06 on 5/10/17.
//  Copyright © 2017 Cntt06. All rights reserved.
//

import Foundation
import UIKit

class Student: NSObject {
    var name: String
    var id: String
    var university: String
    var descript: String
    var age: String
    var image: UIImage
    
    init(named: String, identify: String, school: String, description: String, aged: String, imaged: UIImage) {
        self.name = named
        self.id = identify
        self.university = school
        self.descript = description
        self.age = aged
        self.image = imaged
    }
    
    class func createStudent() -> [Student]{
        var students = [Student]()
        
        students.append(Student(named: "Tran Trung Thanh", identify: "01", school: "UTE", description: "Nam nhat", aged: "18", imaged: #imageLiteral(resourceName: "thanh")))
        students.append(Student(named: "Tran Thanh Phat", identify: "02", school: "UTE", description: "Nam hai", aged: "19", imaged: #imageLiteral(resourceName: "phat")))
        students.append(Student(named: "Tran Van Tuan", identify: "03", school: "UTE", description: "Nam ba", aged: "20", imaged: #imageLiteral(resourceName: "tuan")))
        
        return students
    }
}
