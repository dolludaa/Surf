//
//  DataService.swift
//  SurfInternship
//
//  Created by Людмила Долонтаева on 2/8/23.
//

import Foundation

final class DataService {
    
    
    func fetchNewsArticles(completion: @escaping (Result<DataModel, Error>) -> Void ) {
        
        let dataModel = DataModel(title: "Стажировка в Surf",
                                  description: "Работай над реальными задачами под руководством опытного наставника и получи возможность стать частью команды мечты.",
                                  conditions: "Получай стипендию, выстраивай удобный график, работай на современном железе.",
                                  directions: ["iOS", "Android", "Design", "QA", "Flutter","PM","Backend", "Frontend", "DevOps", "Testing"])
        completion(.success(dataModel))
    }
}
