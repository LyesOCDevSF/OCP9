@isTest
public class TestOrderCalculateAmountTrigger {
    @isTest static void testOrderCalculateAmountTrigger() {

        // Création des comptes de test 
        List<Account> testAccounts = AccountContractOrderDataFactory.createAccounts(1);
        insert testAccounts;
        Id accountId = testAccounts[0].Id;

        //Instanciation du produit de test 
        Product2 pd1 = new Product2(Name = 'Chemise Verte longue XYX', Family = 'Chemise');
        Insert pd1;


        // Création des contrats de test 
        List<Contract> testContracts = AccountContractOrderDataFactory.createContract(1, accountId); 
        insert testContracts;

        //Création des prix des produits
        PricebookEntry pbe = new PricebookEntry(
            Pricebook2Id = Test.getStandardPricebookId(),
            Product2Id = pd1.Id,
            UnitPrice = 1020,
            IsActive = true
        );
        Insert pbe;
        

        // Création  des commandes de test
        List<Order> testOrders = AccountContractOrderDataFactory.createOrders(1, accountId);
        insert testOrders;
        Id orderId = testOrders[0].Id;

        // Création des produites de tests 
        List<OrderItem> testOrderItems1 = AccountContractOrderDataFactory.createOrderItems(1, orderId, pbe.Id, 10, 150);
        insert testOrderItems1;
        List<OrderItem> testOrderItems2 = AccountContractOrderDataFactory.createOrderItems(1, orderId, pbe.Id, 20, 1000);
        insert testOrderItems2;

        // Start test
        Test.startTest();

        // Update the Order to trigger the Order_CalculateAmount_trigger
        testOrders[0].Status = 'Activated';
        update testOrders;

        Test.stopTest();

        // Test that the Account's Chiffre_d_affaire__c field was updated correctly
        Account updatedAccount = [SELECT Id, Chiffre_d_affaire__c FROM Account WHERE Id = :accountId];
        System.assertEquals(21500, updatedAccount.Chiffre_d_affaire__c, 'Chiffre_d_affaire__c was not updated correctly');
    }
}
