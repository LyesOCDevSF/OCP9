public with sharing class OrderDataFactory {

    // méthode de création de commandes de tests 
    public static list<Order> createOrders(Integer numOrders, Id accountId) {

        List<Order> orders = New List<Order>();

        //Création des nouvelles commandes avec les champs requis 
        for (integer i = 0; i< numOrders; i++){
            Order order = new Order(
                AccountId = accountId,
                Status = 'draft',
                EffectiveDate = System.today(),
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
}