trigger CalculMontant on Order (before update) {
    OrderService.calculateNetAmount(Trigger.new);
}




    //Order newOrder= trigger.new[0];
	//newOrder.NetAmount__c = newOrder.TotalAmount - newOrder.ShipmentCost__c;  trigger CalculMontant on Order (before update) {