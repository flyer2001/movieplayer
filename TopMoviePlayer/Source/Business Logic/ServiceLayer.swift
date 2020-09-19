//
//  ServiceLayer.swift
//  TopMoviePlayer
//
//  Created by Sergei Popyvanov on 16.09.2020.
//  Copyright © 2020 Sergey Popyvanov. All rights reserved.
//

import Apexy
import CoreData

final class ServiceLayer {

    // MARK: - Public properties

    static let shared = ServiceLayer()

    private(set) lazy var apiClient: Client = {
        return Apexy.Client(
            baseURL: URL(string: "https://api.themoviedb.org/3/")!,
            configuration: .ephemeral)
    }()

    private(set) lazy var popularFilmService: PopularFilmService = PopularFilmServiceImpl(apiClient: apiClient)

    private(set) lazy var videoService: VideoService = VideoServiceImpl(apiClient: apiClient)

    private(set) lazy var storageService: StorageService = StorageServiceImpl(persistentContainer: persistentContainer)

    //private(set) lazy var storage

    // MARK: - Private Properties

    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TopMoviePlayer")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
        container.viewContext.shouldDeleteInaccessibleFaults = true
        container.viewContext.automaticallyMergesChangesFromParent = true
        return container
    }()


}
