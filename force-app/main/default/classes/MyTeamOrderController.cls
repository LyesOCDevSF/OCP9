public without sharing class MyTeamOrderController {
    public decimal sumOrders{
        get{
			AggregateResult groupedResults = [SELECT SUM(TotalAmount) total FROM Order WHERE Status = 'Activated'];
			return (decimal)groupedResults.get('total');

        }
        set;
    }
}