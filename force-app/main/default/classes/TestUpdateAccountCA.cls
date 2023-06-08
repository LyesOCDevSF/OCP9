@isTest

// changemennt de la méthode de test de private à public.
public class TestUpdateAccountCA {
    @isTest static void test() {

        // Création du jeu de données de test 
        Account acc1 = new Account(Name = 'Test Account 1');
        insert acc1;

        Product2 pd1 = new Product2(Name = 'Chemise Verte longue XYX', Family = 'Chemise');
        Insert pd1;
 
        //Create the PricebookEntry
        // ici on créer les prix produit pour la commande avec sa quantité 
        PricebookEntry pbe = new PricebookEntry(
            Pricebook2Id = Test.getStandardPricebookId(),
            Product2Id = pd1.Id,
            UnitPrice = 1020,
            IsActive = true
        );
        Insert pbe;
        
        // creation de la commande et création des produits à ajouter 

        Order o1 = new Order(AccountId = acc1.Id);
        insert o1;

        OrderItem oi1 = new OrderItem (OrderId = o1.Id, PricebookEntryId = pbe.Id, Quantity=10, UnitPrice = 150);
        insert oi1;
        OrderItem oi2 = new OrderItem (OrderId = o1.Id, PricebookEntryId = pbe.Id, Quantity=20, UnitPrice = 1000);
        insert oi2; 
        
        // test commence 
        Test.startTest();

        // appel de la classe de service pour mettre à jour les comptes 

        Set<Id> accountIds = new Set<Id>{acc1.Id};

        AccountService.updateTotalRevenueForAccounts(accountIds);

        Test.stopTest();

        
        
         acc1 = [SELECT Id, Chiffre_d_affaire__c FROM Account WHERE Id = :acc1.Id];

        
        System.assertEquals(1150, acc1.Chiffre_d_affaire__c, 'Test fail');
    }
}
