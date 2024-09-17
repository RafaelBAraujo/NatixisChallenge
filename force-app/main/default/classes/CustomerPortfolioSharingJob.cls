public without sharing class CustomerPortfolioSharingJob implements Database.Batchable<SObject> {
    
    private Set<Id> contactIds;

    public CustomerPortfolioSharingJob(Set<Id> contactIds) {
        this.contactIds = contactIds;
    }
    
    public Database.Querylocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator([
            SELECT Id, User__c, Contact__c
            FROM Customer_Portfolio__c
            WHERE Contact__c IN :contactIds
        ]);
    }

    public void execute(Database.BatchableContext BC, List<Customer_Portfolio__c> scope) {

        List<ContactShare> newContactShares = new List<ContactShare>();

        for(Customer_Portfolio__c customerPortfolio : scope)
        {
            newContactShares.add(CustomerPortfolioTriggerHelper.createContactShareFromCustomerPorfolio(customerPortfolio));
        }
        
        Database.SaveResult[] results = Database.insert(newContactShares, false);

        for (Database.SaveResult sr : results) {
            if (!sr.isSuccess()) {
                for(Database.Error err : sr.getErrors()) {
                    System.debug('The following error has occurred.');          
                    System.debug(err.getStatusCode() + ': ' + err.getMessage());

                    // talk to business if necessary to notify someone in case of an error
                }
            }
        }
        
    }

    public void finish(Database.BatchableContext bc) {}

}