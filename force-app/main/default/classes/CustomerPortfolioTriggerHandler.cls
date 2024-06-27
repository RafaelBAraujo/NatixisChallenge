public with sharing class CustomerPortfolioTriggerHandler {
    
    public static void beforeInsert(Map<Id, Customer_Portfolio__c> mapNew)
    {
        CustomerPortfolioTriggerHelper.generateExternalIds(CustomerPortfolioTriggerHelper.filterByExternalPortfolios(mapNew.values()));
    }
}