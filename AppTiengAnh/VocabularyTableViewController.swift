//
//  VocabularyTableViewController.swift
//  AppTiengAnh
//
//  Created by Nguyen Thi Tham on 16/5/24.
//

import UIKit

class VocabularyTableViewController: UITableViewController {
    
    
    @IBOutlet var VocabularyTB: UITableView!
    var list:[String] = ["Unit1", "Unit2", "Unit3"]

        override func viewDidLoad() {
            super.viewDidLoad()
            VocabularyTB.dataSource = self
            VocabularyTB.delegate = self

            // Set the background image
            let backgroundImage = UIImage(named: "bg")
            let imageView = UIImageView(image: backgroundImage)
            self.tableView.backgroundView = imageView
            imageView.contentMode = .scaleAspectFill
            imageView.frame = self.tableView.bounds
            self.tableView.backgroundColor = UIColor.clear
        }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return list.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "VocabularyCell", for: indexPath) as? VocabularyTableViewCell {
            let arr = list[indexPath.row]
            cell.img_TV.image = UIImage(named: arr)
            cell.lbl_TV.text = arr
            return cell
        }
        return UITableViewCell()
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Get the tab bar controller
        guard let tabBarController = self.tabBarController else {
            return
        }
        // Get the ViewController from storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "viewController") as? VocabularyDetailController else {
            return
        }
        // Pass data if needed
        viewController.selectedUnit = list[indexPath.row]
    }



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
