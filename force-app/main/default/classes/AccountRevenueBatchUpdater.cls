global class AccountRevenueBatchUpdater implements Database.Batchable<sObject>{

    private Set<Id> setAccountIds = new Set<Id>();
    
    global Database.QueryLocator start(Database.BatchableContext info){ 
       
        
        return Database.getQueryLocator('SELECT Id, (SELECT Id, TotalAmount FROM Orders WHERE Status = \'Activated\') FROM Account');
    }
     
   global void execute(Database.BatchableContext info, List<Account> scope){
        
            for (Account account : scope) {
                setAccountIds.add(account.Id);
            }
            
            AccountService.updateTotalRevenueForAccounts(setAccountIds);
        }
      

     
    global void finish(Database.BatchableContext info){  
          
       
    } 

}
 