public with sharing class AccountContractOrderDataFactory {
    public static list<Account> createAccounts(Integer numAccounts) {
        
        List<Account> accounts = New List<Account>();

        for(integer i; i<numAccounts; i++){
            Account account = new Account();
            accounts.add(account);
        }
        return accounts;

    }

    public void insertAccounts( List<Account> accounts){
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
    
        public void insertContracts(List<Contract> contracts){
    
            insert contracts;
        }
    

    

        // méthode de création de commandes de tests 
        public static list<Order> createOrders(Integer numOrders, Id accountId) {
    
            List<Order> orders = New List<Order>();
    
            //Création des nouvelles commandes avec les champs requis 
            for (integer i = 0; i< numOrders; i++){
                Order order = new Order(
                    AccountId = accountId,
                    Status = 'draft',
                    EffectiveDate = System.today(),
                    //TotalAmount = 1000.00,
                    Pricebook2Id = Test.getStandardPricebookId()
                );
                //Ajout des nouvelles commandes à la liste
                orders.add(order);
            }
            return orders;
        }
    
        // insertion des commandes nouvellement créées
        public void insertOrders(List<Order> orders) {
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
