//
//  shoppingTableViewController.swift
//  shoppingList
//
//  Created by 陳秉軒 on 2021/6/20.
//

import UIKit

class shoppingTableViewController: UITableViewController {
    var shoppingItems = [String]()
    
    @IBAction func additem(_ sender: UIBarButtonItem) {
        popupalert(nil, with: {
            (success:Bool,result:String?) in
            if success == true{
                if let okresult = result{
                    self.shoppingItems.append(okresult)
                    let insertnew = IndexPath(row: self.shoppingItems.count - 1, section: 0)
                    self.tableView.insertRows(at: [insertnew], with: .left)
                    self.saveList()
                }
            }
        })
        
        
        
        
    }
    
    func saveList(){
        UserDefaults.standard.set(shoppingItems, forKey: "list")
        UserDefaults.standard.synchronize()
    }
    func loadList(){
        if let oklist = UserDefaults.standard.stringArray(forKey: "list"){
            shoppingItems = oklist
        }
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        
        popupalert(shoppingItems[indexPath.row], with: {
            (success:Bool,result:String?) in
            if success == true{
                if let okresult = result{
                    self.shoppingItems[indexPath.row] = okresult
                    self.tableView.reloadData()
                    self.saveList()
                }
            }
        })
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            shoppingItems.remove(at: indexPath.row)
            saveList()
            tableView.reloadData()
        }
    }
    
    let handler:(Bool,String?)->() = {
        (success:Bool,result:String?) in
        if success == true{
            if let okresult = result{
                //shoppingItems.append(okresult)
                //tableView.reloadData()
            }
        }
    }
    
    func popupalert(_ defaultValue:String?,with handler: @escaping (Bool,String?)->()){
         let Alert = UIAlertController(title: "Add new item", message: nil, preferredStyle: .alert)
        Alert.addTextField { (textfield:UITextField) in
            textfield.placeholder = "Add new item here"
            textfield.text = defaultValue
        }
        let okAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
            if let inputtext = Alert.textFields?[0].text{
                if inputtext != ""{
                    handler(true,inputtext)
                }else{
                    handler(false,nil)
                }
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (action:UIAlertAction) in
            handler(false,nil)
        }
        Alert.addAction(okAction)
        Alert.addAction(cancelAction)
        present(Alert, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadList()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return shoppingItems.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = shoppingItems[indexPath.row]
        

        return cell
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
