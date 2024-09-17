public with sharing class AccountTriggerHandler {
    
    public static void beforeDelete(Map<Id, Account> mapOld) 
    {
        AccountTriggerHelper.preventDeleteOfExternalAccounts(mapOld);
    }

}