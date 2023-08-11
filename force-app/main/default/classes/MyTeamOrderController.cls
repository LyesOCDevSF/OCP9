/*public without sharing class MyTeamOrderController {
    public decimal sumOrders{
        get{
			AggregateResult groupedResults = [SELECT SUM(NetAmount__c) total FROM Order WHERE Status = 'Activated'];
			return (decimal)groupedResults.get('total');

        }
        set;
    }
}*/

public with sharing class MyTeamOrderController {
    public decimal sumOrders{
        
           get {
                AggregateResult groupedResults = [SELECT SUM(NetAmount__c) total FROM Order WHERE Status = 'Activated'];
                return (decimal)groupedResults.get('total');
                //sumOrders = (groupedResults.get('total') != null) ? (decimal)groupedResults.get('total') : 0;
            }
            set;
        }
           
        
    
    }



