
@isTest
public class Test2MyTeamOrderController {

    @isTest
    public static void setupTestData() {

        // Création des comptes de tests
        List<Account> testAccounts = new List<Account>();
        for(Integer i = 0; i < 2; i++){
            Account acc = new Account(Name='Test Account'+i);
            testAccounts.add(acc);
        }
        insert testAccounts;
        
        // Création des produits de test
        List<Product2> testProducts = new List<Product2>();
        for(Integer i = 0; i < 2; i++){
            Product2 prod = new Product2(Name='Test Product'+i, isActive=true);
            testProducts.add(prod);
        }
        insert testProducts;
        
        // Création des PricebookEntries
        Id pricebookId = Test.getStandardPricebookId();
        List<PricebookEntry> testPricebookEntries = new List<PricebookEntry>();
        for(Product2 prod: testProducts){
            PricebookEntry pbEntry = new PricebookEntry(Pricebook2Id=pricebookId, Product2Id=prod.Id, UnitPrice=100.0, IsActive=true);
            testPricebookEntries.add(pbEntry);
        }
        insert testPricebookEntries;

        // Création des commandes de test
        List<Order> testOrders = new List<Order>();
        for(Account acc: testAccounts){
            Order ord = new Order(AccountId=acc.Id, Status='Draft', EffectiveDate=Date.today(), Pricebook2Id=pricebookId);
            testOrders.add(ord);
        }
        insert testOrders;
        
        // Création des OrderItems

        List<OrderItem> orderItemsList = new List<OrderItem>();
        for(Integer i = 0; i < 2; i++){
            OrderItem ordItem = new OrderItem(OrderId=testOrders[i].Id, PricebookEntryId=testPricebookEntries[i].Id, Quantity=20, UnitPrice=100.0);
            
            testOrders[i].NetAmount__c = ordItem.Quantity * ordItem.UnitPrice;
            orderItemsList.add(ordItem);
        }
        insert orderItemsList;
        update testOrders;
        
        // Passage des commandes au statut 'Activated'
        for(Order ord: testOrders){
            ord.Status = 'Activated';
        }
        update testOrders;

    }

    @isTest
    static void testSumOrdersResult(){
        setupTestData();

        Test.startTest();
        MyTeamOrderController controller = new MyTeamOrderController();
        Decimal actualResult = controller.sumOrders;
        Test.stopTest();
        
        Decimal expectedResult = 3600.0; // Somme des montants totaux que nous avons définis pour les commandes de test
        System.assertEquals(expectedResult, actualResult, 'The sum of total amounts should be correct.');
    }
}


