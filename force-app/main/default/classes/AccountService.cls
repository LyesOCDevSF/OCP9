public with sharing class AccountService {
    
   public static void  updateTotalRevenueForAccounts(Set<Id> setAccountIds) {

        List<Account> accounts = [SELECT Id, Chiffre_d_affaire__c, (SELECT TotalAmount FROM Orders WHERE Status = 'Activated') FROM Account WHERE Id IN :setAccountIds];
                
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

    
