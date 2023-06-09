global class AccountRevenueBatchUpdater implements Database.Batchable<sObject>{

    private Set<Id> setAccountIds = new Set<Id>();
    
    global Database.QueryLocator start(Database.BatchableContext info){ 
        //Requeter seulement les comptes qui ont au moins une commande avec le Status 'Ordered'
        // requete : select AccountId, Account.Name from Order where Status ='Activated' 
        
        return Database.getQueryLocator('SELECT Id, (SELECT Id, TotalAmount FROM Orders WHERE Status = \'Activated\') FROM Account');
    }
     
   global void execute(Database.BatchableContext info, List<Account> scope){
        
        // ne pas appeler les comptes 1 par un 
        for (Account account : scope) {
            setAccountIds.add(account.Id);
            //appeler AccountService ici 
          /*  AccountService updateCaNew = new AccountService();   
             // updateCaNew.updateTotalRevenueForAccounts(setAccountIds);*/
             
    }  
             AccountService updateCaNew = new AccountService(); 
             updateCaNew.updateTotalRevenueForAccounts(setAccountIds);
      
}
     
    global void finish(Database.BatchableContext info){  
          
       
    } 

}
 