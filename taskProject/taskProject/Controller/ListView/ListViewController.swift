//
//  ListViewController.swift
//  taskProject
//
//  Created by Anjali bhatt on 27/04/24.
//

import UIKit

class ListViewController: UIViewController{
    
    @IBOutlet weak var listTableView: UITableView!
    var cellIdentifier = "ListTableViewCell"
    var appArr = [RootClass]()
    var displayedData: [RootClass] = []
    let chunkSize = 20
    var isLoading = false
    override func viewDidLoad() {
        super.viewDidLoad()
        //use custom cell for tableview
        listTableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        // Do any additional setup after loading the view.
        
        loadMoreData()
     
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //set title of navigationbar
        self.navigationItem.title = "List"
    }
    // MARK: - API calling
    
  func loadMoreData() {
        isLoading = true
        //call api with error and exception handlling
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            print("Invalid URL")
            isLoading = false
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: urlRequest) { [weak self] data, response, error in
            guard let self = self else { return }
            
            if let error = error {
                print("Error fetching data: \(error)")
                self.isLoading = false
                return
            }
            
            guard let data = data else {
                print("No data received")
                self.isLoading = false
                return
            }
            
            do {
                if let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                    // Assuming jsonArray is an array of dictionaries
                    for entryDict in jsonArray {
                        let objectEntry = RootClass(fromDictionary: entryDict)
                        self.appArr.append(objectEntry)
                    }
                    
                    DispatchQueue.main.async {
                        //store chunk of 20 items when scroll tableview in displayedData array
                        let currentCount = self.displayedData.count
                        let endIndex = min(currentCount + self.chunkSize, self.appArr.count)
                        if currentCount < self.appArr.count {
                            let newData = Array(self.appArr[currentCount..<endIndex])
                            self.displayedData.append(contentsOf: newData)
                            self.listTableView.reloadData()
                        }
                        self.isLoading = false
                    }
                } else {
                    print("Failed to parse JSON as array of dictionaries")
                    self.isLoading = false
                }
            } catch {
                print("Error decoding JSON: \(error)")
                self.isLoading = false
            }
        }.resume()
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //handle pagination while scroll only 20 items at a time load in screen
            let offsetY = scrollView.contentOffset.y
            let contentHeight = scrollView.contentSize.height
            if offsetY > contentHeight - scrollView.frame.size.height {
                if !isLoading {
                    loadMoreData()
                }
            }
        }
   
}
//Use extension for tableview load cell with reusableidentifier

extension ListViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
      
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ListTableViewCell
        let latestData = displayedData[indexPath.row]
        let strID = String(latestData.it)
        //use string extension to display id in bold font
        let attributedString = strID.attributedStringWithBoldText()
        cell.labelID.attributedText = attributedString
        cell.labelTitle.numberOfLines = 0
        cell.labelTitle.sizeToFit()
        cell.labelTitle.text = latestData.title;
        return cell
    }
    //navigate to detailview while click on particulr index of tableview
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = DetailViewController.init(nibName: "DetailViewController", bundle: nil)
        detailViewController.detailData = displayedData[indexPath.row]
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}

extension String {
    func attributedStringWithBoldText() -> NSAttributedString {
        // Define attributes for bold font
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 16) 
        ]
       
        return NSAttributedString(string: self, attributes: attributes)
    }
}
