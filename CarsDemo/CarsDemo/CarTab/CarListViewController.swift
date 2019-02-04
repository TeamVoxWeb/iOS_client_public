//
//  ViewController.swift
//  CarsDemo
//
//  Created by Abhishek Chaudhari on 07/08/18.
//  Copyright © 2018 Abhishek Chaudhari. All rights reserved.
//

import UIKit
import CoreData

class CarListViewController: UIViewController,UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {

    @IBOutlet weak var carTableView: UITableView!
//    var carsArray: [Car] = []
    
    fileprivate lazy var fetchedResultsController: NSFetchedResultsController<Car> = {
        // Initialize Fetch Request
        let fetchRequest: NSFetchRequest<Car> = Car.fetchRequest()
        
        // Add Sort Descriptors
        let sortDescriptor = NSSortDescriptor(key: "created", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        // Initialize Fetched Results Controller
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreData_Helper.getContext(), sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate=self
        return fetchedResultsController
    }()

    //MARK: - View life

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        self.addMenuButtom(withSelector: #selector(menuButtonClicked))
        
        carTableView.register(UINib(nibName: "CarTableCell", bundle: nil), forCellReuseIdentifier: "CarTableCellIdentifier")

        self.title = "Cars"
        
        CoreData_Helper.sharedInstance.getAllCarData()
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            let fetchError = error as NSError
            print("Unable to fetch")
            print("\(fetchError), \(fetchError.localizedDescription)")
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: - Menu actions

    @objc func menuButtonClicked() {
        MenuManager.sharedInstance.showMenu()
    }

    //MARK: - TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (fetchedResultsController.fetchedObjects?.count)!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 347.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CarTableCellIdentifier", for: indexPath) as! CarTableCell
        
        let car = fetchedResultsController.object(at: indexPath)
        
        // Configure Cell
        cell.updateCellWith(carObj: car)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let car = fetchedResultsController.object(at: indexPath)
        let carDetailsVC = CarDetailsViewController(nibName: "CarDetailsViewController", bundle: nil)
        carDetailsVC.carDetails = car
        self.navigationController?.pushViewController(carDetailsVC, animated: true)
    }

    // MARK: - FetchedResultsController Delegate

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            carTableView.insertRows(at: [newIndexPath! as IndexPath], with: .automatic)
        case .delete:
            carTableView.deleteRows(at: [indexPath! as IndexPath], with: .automatic)
        case .update:
            carTableView.reloadRows(at: [indexPath! as IndexPath], with: .automatic)
            
        default: break
        }
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        carTableView.beginUpdates()
    }
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        carTableView.endUpdates()
    }

}

