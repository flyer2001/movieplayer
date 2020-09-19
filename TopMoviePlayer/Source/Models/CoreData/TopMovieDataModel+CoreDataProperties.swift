//
//  TopMovieDataModel+CoreDataProperties.swift
//  TopMoviePlayer
//
//  Created by Sergei Popyvanov on 19.09.2020.
//  Copyright © 2020 Sergey Popyvanov. All rights reserved.
//
//

import Foundation
import CoreData


extension TopMovieDataModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TopMovieDataModel> {
        return NSFetchRequest<TopMovieDataModel>(entityName: "TopMovieDataModel")
    }

    @NSManaged public var id: Int32
    @NSManaged public var title: String
    @NSManaged public var description_: String
    @NSManaged public var posterURL: URL?

}
