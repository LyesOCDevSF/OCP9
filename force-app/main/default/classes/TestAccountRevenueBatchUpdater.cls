@isTest

public with sharing class TestAccountRevenueBatchUpdater {

    @isTest
    static void testAccountRevenueBatchUpdater() {


        //Création des comptes de tests
        List<Account> testAccounts = AccountContractOrderDataFactory.createAccounts(100);
        AccountContractOrderDataFactory.insertAccounts( testAccounts);

        //Création des contrats de test 
        List<Contract> testContracts = new List<Contract>();
        for(Account acc: testAccounts){
            List<Contract> contractForTestAccounts = AccountContractOrderDataFactory.createContract(1, acc.Id);
            //passage des contrats au statut activated
            contractForTestAccounts[0].Status = 'Draft';
            testContracts.addAll(contractForTestAccounts);
        }
        AccountContractOrderDataFactory.insertContracts (testContracts);

        //passage des contrats en 'Activated'
        for(Contract contr: testContracts){
            contr.Status = 'Activated';
        }
        update testContracts;
        

        //Création des commandes de test 
        List<Order> testOrders = new List<Order>();
        for(Account acc: testAccounts){
            List<Order> orderForTestTestAccounts = AccountContractOrderDataFactory.createOrders(1, acc.Id);
            orderForTestTestAccounts[0].Status = 'Draft';
            testOrders.addAll(orderForTestTestAccounts);
        }
        AccountContractOrderDataFactory.insertOrders (testOrders);

        
        // Création des produits
        List<Product2> testProducts = AccountContractOrderDataFactory.createProducts(1);
        AccountContractOrderDataFactory.insertProducts(testProducts);
        Id productId = testProducts[0].Id;

        // Création des PricebookEntries
        List<PricebookEntry> testPricebookEntries = AccountContractOrderDataFactory.createPricebookEntries(1, productId, 1000);
        AccountContractOrderDataFactory.insertPricebookEntries(testPricebookEntries);


        List<OrderItem> testOrderItems = new List<OrderItem>();
        for(Order order : testOrders){
            for(PricebookEntry pbe : testPricebookEntries){
                List<OrderItem> orderItemForTestOrderItem = AccountContractOrderDataFactory.createOrderItems(10, order.Id, pbe.Id, 10, 150);
                testOrderItems.addAll(orderItemForTestOrderItem);
            }
        }
        AccountContractOrderDataFactory.insertOrderItems (testOrderItems);

        // passage des commande au statut 'Activated'
        for(Order ord: testOrders){
            ord.Status = 'Activated';
        }
        update testOrders;

        
        Test.startTest();
        
        //initialisation du batch
        AccountRevenueBatchUpdater batch = new AccountRevenueBatchUpdater();

        //Execution du test 
        
        Database.executeBatch(batch);
        Test.stopTest();

        //Vérification de la mise à jour des comptes

        List<Id> ids = new List<Id>();


        for (Account acc : testAccounts) {
            ids.add(acc.Id);
            }
        


        List<Account> updatedAccounts = [SELECT Id, Chiffre_d_affaire__c FROM Account WHERE Id IN :ids];

        for (Account updateAccount: updatedAccounts) {
            System.assertEquals(15000, updateAccount.Chiffre_d_affaire__c, 'Chiffre affaire updated');
            }
         }
    }
