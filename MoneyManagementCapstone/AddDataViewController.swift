//
//  AddDataViewController.swift
//  MoneyManagementCapstone
//
//  Created by Satyam on 2022-04-08.
//
import Firebase
import UIKit

class AddDataViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var refData: DatabaseReference!
    
    
    @IBOutlet weak var tblTransactions: UITableView!
    
    //array list to store
    var TransactionList = [TransactionModel]()
    
    //for rows
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TransactionList.count
    }
    
    //extra code
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    
    
    
    //for column
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PulledDataTableViewCell
        
        let Transaction: TransactionModel
        
        Transaction = TransactionList[indexPath.row]
        
       cell.lblCategory.text = Transaction.Category
      cell.lblDate.text = Transaction.Date
        cell.lblNote.text = Transaction.Note
       cell.lblTypee.text = Transaction.Typee
        cell.lblAmount.text = Transaction.Amount
       cell.lblNumber.text = Transaction.Number
        
        return cell
    }
    
    
    @IBOutlet weak var textFieldDate: UITextField!
    
    
    @IBOutlet weak var textFieldNumber: UITextField!
    
    
    @IBOutlet weak var textFieldCategory: UITextField!
    
    
    @IBOutlet weak var textFieldTypee: UITextField!
    
    
    @IBOutlet weak var textFieldAmount: UITextField!
    
    @IBOutlet weak var textFieldNote: UITextField!
    
    @IBAction func buttonActionAdd(_ sender: Any) {
        addData()
    }
    
    @IBOutlet weak var labelOutputMessage: UILabel!
    
    @IBAction func closeButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if FirebaseApp.app() == nil{
            FirebaseApp.configure()
        }
       
        //firebase data send
        refData = Database.database().reference().child("Transactions");
        
        refData.observe(DataEventType.value, with: {(snapshot) in
            if snapshot.childrenCount>0
            {
                self.TransactionList.removeAll()
                
                for Transactions in snapshot.children.allObjects as![DataSnapshot]{
                    let transactionObject = Transactions.value as? [String: AnyObject]
                    
                    let dataNumber = transactionObject?["dataNumber"]
                    let dataTypee = transactionObject?["dataTypee"]
                    let dataDate = transactionObject?["dataDate"]
                    let dataCategory = transactionObject?["dataCategory"]
                    let dataAmount = transactionObject?["dataAmount"]
                    let dataNote = transactionObject?["dataNote"]
                    
                    let Transaction = TransactionModel(
                        Number: dataNumber as! String?,
                                                       Typee: dataTypee as! String?,
                                                       Date: dataDate as! String?,
                                                       Category: dataCategory as! String?,
                                                       Amount: dataAmount as! String?,
                                                       Note: dataNote as! String?)
                    self.TransactionList.append(Transaction)
                }
                
            self.tblTransactions.reloadData()
            }
        })
    }
    
    func addData(){
        let key = refData.childByAutoId().key
        let Transaction = [ "dataNumber": key,
                           "dataTypee": textFieldTypee.text! as String,
                            "dataDate": textFieldDate.text! as String,
                            "dataCategory" : textFieldCategory.text! as String,
                            "dataAmount" : textFieldAmount.text! as String,
                            "dataNote" : textFieldNote.text! as String]
        
        
        refData.child(key!).setValue(Transaction)
        labelOutputMessage.text = "Data Added!"
    }
    
    
}
