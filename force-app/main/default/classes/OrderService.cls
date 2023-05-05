public class OrderService {
    public static void calculateNetAmount(List<Order> orders) {
        for (Order order : orders) {
            order.NetAmount__c = order.TotalAmount - order.ShipmentCost__c;
        }
    }
}
