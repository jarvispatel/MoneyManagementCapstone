//
//  TransactionModel.swift
//  MoneyManagementCapstone
//
//  Created by Satyam on 2022-04-09.
//

//import Foundation

class TransactionModel{
    var Number: String?
    var Typee: String?
   var Date: String?
   var Category: String?
    var Amount: String?
    var Note: String?
    
    init(
        Number:String?,
         Typee: String?,
         Date: String?,
         Category: String?,
         Amount: String?,
         Note: String?)
    {
        self.Number = Number;
        self.Typee = Typee;
        self.Date = Date;
        self.Category = Category;
        self.Amount = Amount;
        self.Note = Note
    }
}
