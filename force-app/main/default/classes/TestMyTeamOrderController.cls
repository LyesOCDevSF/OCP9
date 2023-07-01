
@isTest
public with sharing class TestMyTeamOrderController {

    @isTest
    public static void TestMyTeamOrderController() {

         //Création des comptes de tests
         List<Account> testAccounts = AccountContractOrderDataFactory.createAccounts(2);
         AccountContractOrderDataFactory.insertAccounts(testAccounts);
 
        //création des contrats de tests 
        List<Contract> testContracts = new List<Contract>();
        for(Account acc: testAccounts){
            List<Contract> contractForTestAccounts = AccountContractOrderDataFactory.createContract(2, acc.Id);
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

         //Création des commandes de test 
         List<Order> testOrders = new List<Order>();
         for(Account acc: testAccounts){
             List<Order> orderForTestAccounts = AccountContractOrderDataFactory.createOrders(1, acc.Id);
             orderForTestAccounts[0].Status = 'Draft'; // Changement du statut en 'Activated'


             // montant différent pour chaque commande pour vérifier correctement le calcul de la somme
             orderForTestAccounts[0].NetAmount__c = (acc.Id == testAccounts[0].Id) ? 2000.0 : 3000.0;
             testOrders.addAll(orderForTestAccounts);
         }
         AccountContractOrderDataFactory.insertOrders(testOrders);


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
 
         Test.startTest();
         MyTeamOrderController controller = new MyTeamOrderController();
         Test.stopTest();
 
         Decimal expectedResult = 5000.0; // Somme des montants totaux que nous avons définis pour les commandes de test
         System.assertEquals(expectedResult, controller.sumOrders, 'The sum of total amounts should be correct.');

    }
}
