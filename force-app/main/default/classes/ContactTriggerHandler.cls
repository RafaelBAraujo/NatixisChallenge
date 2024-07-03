public without sharing class ContactTriggerHandler {
    
    public static void afterUpdate(Map<Id, Contact> mapNew, Map<Id, Contact> mapOld)
    {
        ContactTriggerHelper.updateCustomerPortfolioSharing(ContactTriggerHelper.filterByUpdatedOwner(mapOld, mapNew));
    }

}