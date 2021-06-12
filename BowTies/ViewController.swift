/// Copyright (c) 2020 Razeware LLC
///

import UIKit
import CoreData

class ViewController: UIViewController {
  
  @IBOutlet weak var segmentedControl: UISegmentedControl!
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var ratingLabel: UILabel!
  @IBOutlet weak var timesWornLabel: UILabel!
  @IBOutlet weak var lastWornLabel: UILabel!
  @IBOutlet weak var favoriteLabel: UILabel!
  @IBOutlet weak var wearButton: UIButton!
  @IBOutlet weak var rateButton: UIButton!

  var managedContext: NSManagedObjectContext!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }


  @IBAction func segmentedControl(_ sender: UISegmentedControl) {
    // Add code here
  }

  @IBAction func wear(_ sender: UIButton) {
    // Add code here
  }

  @IBAction func rate(_ sender: UIButton) {
    // Add code here
  }
  
  func insertSampleData() {
    
    let fetch: NSFetchRequest<BowTie> = BowTie.fetchRequest()
    fetch.predicate = NSPredicate(format: "searchKey != nil")
    
    let tieCount = (try? managedContext.count (for: fetch)) ?? 0
    
    if tieCount > 0 {
      return
    }
    
    guard let path = Bundle.main.path(forResource: "SampleData", ofType: "plist") else { return }
    let dataArray = NSArray(contentsOfFile: path)!
    
    for dict in dataArray {
      let entity = NSEntityDescription.entity(forEntityName: "BowTie", in: managedContext)!
      let bowtie = BowTie(entity: entity, insertInto: managedContext)
      let btDict = dict as! [String: Any]
      bowtie.id = UUID(uuidString: btDict["id"] as! String)
      bowtie.name = btDict["name"] as? String
      bowtie.searchKey = btDict["searchKey"] as? String
      bowtie.rating = btDict["rating"] as! Double
      
      let colorDict = btDict["tintColor"] as! [String: Any]
      bowtie.tintColor = UIColor.color(dict: colorDict)
      
      let imageName = btDict["imageName"] as? String
      let image = UIImage(named: imageName!)
      bowtie.photoData = image?.pngData()
      bowtie.lastWorn = btDict["lastWorn"] as? Date
      
      let timesNumber = btDict["timesWorn"] as! NSNumber
      bowtie.timesWorn = timesNumber.int32Value
      bowtie.isFavorite = btDict["isFavorite"] as! Bool
      bowtie.url = URL(string: btDict["url"] as! String)
    }
    try? managedContext.save()
  }
  
}

extension UIColor {
  
  static func color(dict: [String: Any]) -> UIColor? {
    guard
      let red = dict["red"] as? NSNumber,
      let green = dict["green"] as? NSNumber,
      let blue = dict["blue"] as? NSNumber
    else {
      return nil
    }
    
    return UIColor(
      red: CGFloat(truncating: red) / 255.0,
      green: CGFloat(truncating: green) / 255.0,
      blue: CGFloat(truncating: blue) / 255.0,
      alpha: 1
    )
  }
  
}
