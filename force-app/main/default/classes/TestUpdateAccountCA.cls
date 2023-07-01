/*@isTest

// changemennt de la méthode de test de private à public.
public class TestUpdateAccountCA {
    @isTest static void test() {

        // Création du jeu de données de test 
        Account acc1 = new Account(Name = 'Test Account 1');
        insert acc1;

        Product2 pd1 = new Product2(Name = 'Chemise Verte longue XYX', Family = 'Chemise');
        Insert pd1;
 
        List<Contract> contracts = ContractDataFactory.createContract(1, acc1.Id); 
        insert contracts;

        //Create the PricebookEntry
        // ici on créer les prix produit pour la commande avec sa quantité 
        PricebookEntry pbe = new PricebookEntry(
            Pricebook2Id = Test.getStandardPricebookId(),
            Product2Id = pd1.Id,
            UnitPrice = 1020,
            IsActive = true
        );
       // System.debug();
        Insert pbe;
        
        // creation de la commande et création des produits à ajouter 

        Order o1 = new Order(AccountId = acc1.Id,
        Status = 'draft',
        EffectiveDate = System.today());
       
        
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
}*/

@isTest
public class TestUpdateAccountCA {
    @isTest static void test() {

        // Création des comptes de test
        List<Account> testAccounts = AccountContractOrderDataFactory.createAccounts(1);
        insert testAccounts;

        // Création des contrats de test

        List<Contract> testContracts = new List<Contract>();
        for(Account acc: testAccounts){
            List<Contract> contractForTestAccounts = AccountContractOrderDataFactory.createContract(1, acc.Id);
            //passage des contrats au statut activated
            contractForTestAccounts[0].Status = 'Draft';
            testContracts.addAll(contractForTestAccounts);
        }
        AccountContractOrderDataFactory.insertContracts (testContracts);

        // Création des produits de test
        List<Product2> testProducts = AccountContractOrderDataFactory.createProducts(1);
        insert testProducts;

        // Création des PricebookEntries
        List<PricebookEntry> testPricebookEntries = AccountContractOrderDataFactory.createPricebookEntries(1, testProducts[0].Id, 1020);
        insert testPricebookEntries;

        // Création des commandes de test 
        List<Order> testOrders = AccountContractOrderDataFactory.createOrders(1, testAccounts[0].Id);
        testOrders[0].Status = 'Draft';
        insert testOrders;
        

        // Création des OrderItems
        List<OrderItem> testOrderItems1 = AccountContractOrderDataFactory.createOrderItems(1, testOrders[0].Id, testPricebookEntries[0].Id, 10, 150);
        List<OrderItem> testOrderItems2 = AccountContractOrderDataFactory.createOrderItems(1, testOrders[0].Id, testPricebookEntries[0].Id, 20, 1000);
        insert testOrderItems1;
        insert testOrderItems2;



         //passage des contrats en 'Activated'
         for(Contract contr: testContracts){
            contr.Status = 'Activated';
        }
        update testContracts;

         // passage des commande au statut 'Activated'
         for(Order ord: testOrders){
            ord.Status = 'Activated';
        }
        update testOrders;

        // test start
        Test.startTest();

        // Appel de la classe de service pour mettre à jour les comptes 
        Set<Id> accountIds = new Set<Id>{testAccounts[0].Id};

        AccountService.updateTotalRevenueForAccounts(accountIds);

        Test.stopTest();

        Account updatedAccount = [SELECT Id, Chiffre_d_affaire__c FROM Account WHERE Id = :testAccounts[0].Id];

        // Vérifier si le Chiffre_d_affaire__c est correctement mis à jour
        System.assertEquals(21500, updatedAccount.Chiffre_d_affaire__c, 'Chiffre_d_affaire__c');
    }
}

  