public with sharing class AccountContractOrderDataFactory {
    public static list<Account> createAccounts(Integer numAccounts) {
        
        List<Account> accounts = New List<Account>();

        for(integer i=0; i<numAccounts; i++){
            Account account = new Account();
            account.Name = 'Test Account ' + i;
            accounts.add(account);
        }
        return accounts;

    }

    public static void insertAccounts( List<Account> accounts){
        insert accounts;
    }

    

        // méthode de création des contrats de test 
    public static List<Contract> createContract(integer numContract, Id accountId){
    
            //Ajout des contrats de test 
        List<Contract> contracts = New List<Contract>();
    
        for(integer i= 0; i< numContract; i++){
    
            Contract contract = new Contract(
                AccountId = accountId,
                StartDate = System.today(),
                ContractTerm = 12,
                Status = 'Draft'
                );
    
            contracts.add(contract);
    
            }
            return contracts;
        }
    
        public static void insertContracts(List<Contract> contracts){
    
            insert contracts;
        }
    
        // Création des produits avant de creer les entrées Prix 
        public static List<Product2> createProducts(Integer numProducts) {
            List<Product2> products = new List<Product2>();
        
            for(Integer i = 0; i < numProducts; i++) {
                Product2 product = new Product2(Name = 'Test Product ' + i, IsActive = true);
                products.add(product);
            }
        
            return products;
            
        }
        
       public static void insertProducts(List<Product2> products) {
            insert products;
        }


        // Création des entrées de prix "Standard SF"
        public static List<PricebookEntry> createPricebookEntries(Integer numEntries, Id productId, Decimal price) {
            // Récupération du pricebook standard
            Id standardPricebookId = Test.getStandardPricebookId();
            
            List<PricebookEntry> pbeList = new List<PricebookEntry>();
            
            for(Integer i = 0; i < numEntries; i++) {
                PricebookEntry pbe = new PricebookEntry(
                    Pricebook2Id = standardPricebookId,
                    Product2Id = productId,
                    UnitPrice = price,
                    IsActive = true
                );
                pbeList.add(pbe);
            }
            
            return pbeList;
        }
        
        public static void insertPricebookEntries(List<PricebookEntry> pricebookEntries) {
            insert pricebookEntries;
        }
        
        

        // méthode de création de commandes de tests 
        public static list<Order> createOrders(Integer numOrders, Id accountId) {

            List<Order> orders = New List<Order>();
        
            // Récupération du pricebook standard
            Id standardPricebookId = Test.getStandardPricebookId();
        
            // Création des nouvelles commandes avec les champs requis 
            for (integer i = 0; i< numOrders; i++){
                Order order = new Order(
                    AccountId = accountId,
                    Status = 'draft',
                    EffectiveDate = System.today(),
                    Pricebook2Id = standardPricebookId
                );
                // Ajout des nouvelles commandes à la liste
                orders.add(order);
            }
            return orders;
        }
        public static void insertOrders(List<Order> orders){
    
            insert orders;
        }


       
        

        
        public static List<OrderItem> createOrderItems(Integer numOrderItems, Id orderId, Id pricebookEntryId, Integer quantity, Decimal unitPrice) {
            List<OrderItem> orderItems = new List<OrderItem>();

            for(Integer i = 0; i < numOrderItems; i++) {
                OrderItem orderItem = new OrderItem(
                    OrderId = orderId,
                    PricebookEntryId = pricebookEntryId,
                    Quantity = quantity,
                    UnitPrice = unitPrice
                );
                orderItems.add(orderItem);
            }

            return orderItems;
    }

         public static void insertOrderItems(List<OrderItem> orderItems) {
                 insert orderItems;
    }

}
