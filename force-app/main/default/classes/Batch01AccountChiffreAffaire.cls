public class Batch01AccountChiffreAffaire implements Database.Batchable<sObject>{

    private Set<Id> setAccountIds = new Set<Id>();
    
    global Database.QueryLocator start(Database.BatchableContext info){ 
        //Requeter seulement les comptes qui ont au moins une commande avec le Status 'Ordered'
        // requete : select AccountId, Account.Name from Order where Status ='Activated' 
        

        return Database.getQueryLocator('SELECT Id, (SELECT TotalAmount FROM Orders WHERE Status = \'Activated\') FROM Account');
 
    }
     
   global void execute(Database.BatchableContext info, List<Account> scope){
        //Set<Id> setAccountIds = (new Map<Id,SObject>(scope)).keySet();
        for (Account account : scope) {
            setAccountIds.add(account.Id);
       
    }    
}
     
    global void finish(Database.BatchableContext info){  
        UpdateCA updater = new UpdateCA();   
        UpdateCA.updateChiffreAffaire(setAccountIds);
    } 

}
 