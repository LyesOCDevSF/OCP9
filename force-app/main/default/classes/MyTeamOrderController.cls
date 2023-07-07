/*public without sharing class MyTeamOrderController {
    public decimal sumOrders{
        get{
			AggregateResult groupedResults = [SELECT SUM(NetAmount__c) total FROM Order WHERE Status = 'Activated'];
			return (decimal)groupedResults.get('total');

        }
        set;
    }
}*/

public without sharing class MyTeamOrderController {
    public decimal sumOrders{
        get{
            if(sumOrders == null){
                sumOrders = 0;
                AggregateResult groupedResults = [SELECT SUM(NetAmount__c) total FROM Order WHERE Status = 'Activated'];
                sumOrders = (groupedResults.get('total') != null) ? (decimal)groupedResults.get('total') : 0;
            }
            return sumOrders;
        }
        set;
    }
}


