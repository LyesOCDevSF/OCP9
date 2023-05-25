//global class UpdateAccounts implements Database.Batchable<sObject>{
    /*
 // ajout d'une méthode a appeler pour le batch 
    global static void updateChiffreAffaire(Set<Id> setAccountIds) {
        // Utilisez une requête SOQL pour obtenir une liste de comptes correspondant aux IDs
        List<Account> accounts = [SELECT Id, (SELECT TotalAmount FROM Orders WHERE Status = 'Activated') FROM Account WHERE Id IN :setAccountIds];
        
        // Appelez la méthode de mise à jour pour effectuer la mise à jour*/
    /*}
    global Database.QueryLocator start(Database.BatchableContext info){ 
        //Requeter seulement les comptes qui ont au moins une commande avec le Status 'Ordered'
        //list<Account> accountOrdered = [SELECT AccountId, Account.Name FROM Order WHERE Status ='Activated'];
        return Database.getQueryLocator('SELECT Id, (SELECT TotalAmount FROM Orders WHERE Status = \'Activated\') FROM Account');
       // return Database.getQueryLocator(accountOrdered);
 
    }


    // Méthode de mise à jour des comptes du chiffre d'affaire des compye avec les commandes au statut 'activated'
    global void execute(Database.BatchableContext info, List<Account> scope){      
       // list<Order> listOrders =  [SELECT Id, TotalAmount, AccountId FROM Order];

        
        /* for(integer i=0; i < scope.size(); i++){
             Account myAccount = scope[i];
             myAccount.Chiffre_d_affaire__c = 0;
            for(integer j=0; j < listOrders.size(); j++){
                if(listOrders[j].AccountId == myAccount.Id){
                    myAccount.Chiffre_d_affaire__c = myAccount.Chiffre_d_affaire__c + listOrders[j].TotalAmount;

                   Account myAccount = 0;
                   calculer une somme dans une liste
                    myAccount.Chiffre_d_affaire__c = accountOrdered * Order.TotalAmount;*

                    List<Account> accountsToUpdate = new List<Account>();
                // Iteration sur chaque compte de la liste (scope) 
                    for (Account myAccounts : scope) {
                        Account accountUpdate =  myAccounts;
                        // On s'assure que le calcul commence bien à 0
                        accountUpdate.Chiffre_d_affaire__c = 0;
                        // itération sur chaque Order associé à un compte 
                        for (Order orderCount : accountUpdate.Orders) {
                            // Calcul pour chaque commande lié au compte, le totalAmount est ajouté au champ Chiffre_d_affaire__c
                            accountUpdate.Chiffre_d_affaire__c += orderCount.TotalAmount;  
                         }
                }                   
            
        update scope;
    }    
     
    global void finish(Database.BatchableContext info){     
        
    } */

    public class UpdateAccounts {
        global static void updateChiffreAffaire(Set<Id> setAccountIds) {
            // Utilisez une requête SOQL pour obtenir une liste de comptes correspondant aux IDs
            List<Account> accounts = [SELECT Id, (SELECT TotalAmount FROM Orders WHERE Status = 'Activated') FROM Account WHERE Id IN :setAccountIds];
            
            for (Account account : accounts) {
                // On s'assure que le calcul commence bien à 0
                account.Chiffre_d_affaire__c = 0;
                // itération sur chaque Order associé à un compte 
                for (Order order : account.Orders) {
                    // Calcul pour chaque commande lié au compte, le totalAmount est ajouté au champ Chiffre_d_affaire__c
                    account.Chiffre_d_affaire__c += order.TotalAmount;
                }
            }
            
            // Mettre à jour la base de données avec les nouvelles valeurs de Chiffre_d_affaire__c pour tous les comptes
            update accounts;
        }
    }
    
 