public with sharing class AccountTriggerHelper {

    public static Boolean isAccountExternal(Account accountRecord) {

        return accountRecord.Type == 'External';
        // RB: use this method if extra logic is required

    }

    public static void preventDeleteOfExternalAccounts(Map<Id, Account> mapOld)
    {
        for(Account deletedAccount : mapOld.values())
        {
            if(isAccountExternal(deletedAccount))
            {
                deletedAccount.addError(System.Label.Natixis_Error_DeleteExternalAccount);
            }
        }
    }

}