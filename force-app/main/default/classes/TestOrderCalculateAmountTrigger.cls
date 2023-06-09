
@isTest
public with sharing class TestOrderCalculateAmountTrigger {
    @isTest

    public static void testOrderCalculateAmountTrigger(){

        // TODO: creation des comptes de test @AccountDataFactory

        List<Account> testAccounts = AccountDataFactory.createAccounts(1, accountId);
        insert testAccounts;

        Id accountId = testAccounts[0].Id;

        //TODO: creation des contrats de test @ContractDataFactory

        List<Contract> testContracts = ContractDataFactory.createContract(1, accountId);
        insert testContracts;

        // TODO: creation des commandes de test @OrderDataFactory

        List<Order> testOrders = OrderDataFactory.createOrders(1, accountId);
        insert testOrders;

        // test du champ NetAmount

        Order firstTestOrder = [SELECT Id, NetAmount__c, TotalAmount FROM Order WHERE Id = :testOrders[0].Id];
        System.assertEquals(900.0, firstTestOrder.NetAmount__c, 'Test Fail');

        Test.startTest();
        // ToTalAmount non modifiable TODO: correction du test  
        testOrders.NetAmount__c = 1200.0;
        update testOrders;

        Test.stopTest();

    }

    
}