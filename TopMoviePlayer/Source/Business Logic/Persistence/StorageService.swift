//
//  StorageService.swift
//  TopMoviePlayer
//
//  Created by Sergei Popyvanov on 19.09.2020.
//  Copyright © 2020 Sergey Popyvanov. All rights reserved.
//

import Foundation

import CoreData

protocol StorageService {
    func addToFavorite(_ film: TopMovieData)
    func deleteFromFavorite(_ film: TopMovieData)
    func isFavorite(id: Int) -> Bool
    func fetchAllFavoriteFilms() -> [TopMovieData]
}

final class StorageServiceImpl: StorageService  {

    // MARK: - Private Properties

    private let persistentContainer: NSPersistentContainer
    private var backgroundContext: NSManagedObjectContext {
        persistentContainer.newBackgroundContext()
    }

    // MARK: - Initializers

    init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
    }

    // MARK: - Public Methods

    func addToFavorite(_ film: TopMovieData) {
        let context = backgroundContext
        let topMovieDataModel = TopMovieDataModel(context: context)
        topMovieDataModel.id = Int32(film.id)
        topMovieDataModel.title = film.title
        topMovieDataModel.description_ = film.description
        topMovieDataModel.posterURL = film.posterURL
        saveContext(context)
    }

    func deleteFromFavorite(_ film: TopMovieData) {
        let context = backgroundContext
        let request: NSFetchRequest<TopMovieDataModel> = TopMovieDataModel.fetchRequest()
        request.predicate = NSPredicate(format: "id = %@", film.id)
        let fetchResults = (try? context.fetch(request)) ?? []
        guard let deleteObject = fetchResults.first else { return }
        context.delete(deleteObject)
        saveContext(context)
    }

    func isFavorite(id: Int) -> Bool {
        let context = backgroundContext
        let request: NSFetchRequest<TopMovieDataModel> = TopMovieDataModel.fetchRequest()
        let fetchResults = (try? context.fetch(request)) ?? []
        return fetchResults.contains(where: { Int($0.id) == id })
    }

    func fetchAllFavoriteFilms() -> [TopMovieData] {
        let context = backgroundContext
        let request: NSFetchRequest<TopMovieDataModel> = TopMovieDataModel.fetchRequest()
        let fetchResults = (try? context.fetch(request)) ?? []
        return fetchResults.map { TopMovieData(topMovieDataModel: $0) }
    }

    // MARK: - Private Methods

    private func saveContext(_ context: NSManagedObjectContext) {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}
