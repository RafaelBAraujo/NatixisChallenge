public with sharing class ContactTriggerHelper {
    
    /**
     * Filters Trigger.newMap to records that have its owner updated
     *
     * @param  mapNew - Trigger.newMap
     * @param  mapOld - Trigger.oldMap
     * @return returns Map<Id, Contact> of filtered records
    */
    public static Map<Id, Contact> filterByUpdatedOwner(Map<Id, Contact> mapNew, Map<Id, Contact> mapOld)
    {
        Map<Id, Contact> filteredMap = new Map<Id, Contact>();

        for(Id contactId : mapNew.keySet())
        {
            if(mapOld.get(contactId).OwnerId != mapNew.get(contactId).OwnerId)
            {
                filteredMap.put(contactId, mapNew.get(contactId));
            }
        }

        return filteredMap;
    }
    
    /**
     * Triggers Batch Job to re-create ContactShare records for Contacts that had the OwnerId updated
     *
     * @param  contactsWithUpdatedOwners - Map<Id, Contact> of records with OwnerId updated
     * @return void
    */
    public static void updateCustomerPortfolioSharing(Map<Id, Contact> contactsWithUpdatedOwners)
    {
        Database.executeBatch(new CustomerPortfolioSharingJob(contactsWithUpdatedOwners.keySet()), 50);
    }
}