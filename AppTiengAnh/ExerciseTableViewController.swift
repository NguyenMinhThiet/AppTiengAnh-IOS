//
//  ExerciseTableViewController.swift
//  AppTiengAnh
//
//  Created by Nguyen Thi Tham on 16/5/24.
//

import UIKit

class ExerciseTableViewController: UITableViewController {

    @IBOutlet var exercise_TB: UITableView!
    var list:[String] = ["Unit1","Unit2","Unit3"]
    override func viewDidLoad() {
        super.viewDidLoad()
        exercise_TB.dataSource = self
        exercise_TB.delegate = self
        // Set the background image
        let backgroundImage = UIImage(named: "bg")
        let imageView = UIImageView(image: backgroundImage)
        self.tableView.backgroundView = imageView

        // Set the way it resizes the image
        imageView.contentMode = .scaleAspectFill

        // Make image view match the table view's size
        imageView.frame = self.tableView.bounds

        // Set the color of the tableView to be clear so we can see the image
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
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseCell", for: indexPath) as? ExerciseTableViewCell{
            let arr = list[indexPath.row]
            cell.img_BT.image = UIImage(named: arr)
            cell.lbl_BT.text = arr
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

    //MARK: - Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let tabBarController = self.tabBarController else {
            return
        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "ExerciseController") as? ExerciseDetailController
        else{
            return
        }
        viewController.exerciseUnit = list[indexPath.row]
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
