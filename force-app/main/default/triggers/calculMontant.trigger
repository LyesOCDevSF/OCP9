trigger CalculMontant on Order (before update, after insert, after update) {
    if (Trigger.isBefore) {
        OrderService.calculateNetAmount(Trigger.new);
    }

    if (Trigger.isAfter) {
        Set<Id> accountIds = new Set<Id>();

        for(Order ord : Trigger.new) {
            accountIds.add(ord.AccountId);
        }

        if (!accountIds.isEmpty()) {
            UpdateCA updateTotalCA = new UpdateCA();
            updateTotalCA.updateChiffreAffaire(accountIds);
        }
    }
}



    //Order newOrder= trigger.new[0];
	//newOrder.NetAmount__c = newOrder.TotalAmount - newOrder.ShipmentCost__c;  trigger CalculMontant on Order (before update) {