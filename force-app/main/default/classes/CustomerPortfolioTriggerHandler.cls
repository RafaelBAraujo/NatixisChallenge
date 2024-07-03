public with sharing class CustomerPortfolioTriggerHandler {
    
    public static void beforeInsert(Map<Id, Customer_Portfolio__c> mapNew)
    {
        CustomerPortfolioTriggerHelper.generateExternalIds(CustomerPortfolioTriggerHelper.filterByExternalPortfolios(mapNew.values()));
    }

    public static void afterInsert(Map<Id, Customer_Portfolio__c> mapNew)
    {
        CustomerPortfolioTriggerHelper.shareCustomers(mapNew.values());
    }

    public static void afterDelete(Map<Id, Customer_Portfolio__c> mapOld)
    {
        CustomerPortfolioTriggerHelper.recalculateContactSharing(mapOld.values());
    }
}