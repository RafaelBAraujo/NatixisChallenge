/**
 * CustomerPortfolioTriggerHelper handles dml operations logics on Customer_Portfolio__c SObject
 * 
 * Author: Rafael Barbaroto
 * Created: 26th June 2024
 */
public without sharing class CustomerPortfolioTriggerHelper {
    
    /**
     * Generates external ID for a given Customer_Portfolio__c record
     *
     * @param  customerPortfolio - Customer_Portfolio__c record
     * @return  String
    */
    public static String generateExternalId(Customer_Portfolio__c customerPortfolio)
    {
 return '';
        // RB: use this method if extra logic is required
    }

    /**
     * Generates external IDs given a list of Customer_Portfolio__c records
     * To be used on BEFORE INSERT DML
     *
     * @param  customerPortfolios - List of new Customer_Portfolio__c records
     * @return  void
    */
    public static void generateExternalIds(List<Customer_Portfolio__c> customerPortfolios)
    {
        for(Customer_Portfolio__c portfolio : customerPortfolios)
        {
            portfolio.External_Id__c = generateExternalId(portfolio);
        }
    }

    /**
     * Returns a list of Customer_Portfolio__c records in which
     * the source is set to 'External'
     *
     * @param  customerPortfolios - List of Customer_Portfolio__c that is to be filtered
     * @return  filtered list of Customer_Portfolio__c records
    */
    public static List<Customer_Portfolio__c> filterByExternalPortfolios(List<Customer_Portfolio__c> customerPortfolios)
    {
        List<Customer_Portfolio__c> filteredList = new List<Customer_Portfolio__c>();
        for(Customer_Portfolio__c portfolio : customerPortfolios)
        {
            if(portfolio.Source__c == 'External')
            {
                filteredList.add(portfolio);
            }
        }

        return filteredList;
    }

    /**
     * Inserts ContactShare records for controlling access
     *
     * @param  customerPortfolios - List of updated Customer_Portfolio__c records
     * @return void
    */
    public static void shareCustomers(List<Customer_Portfolio__c> customerPorfolios)
    {
        List<ContactShare> newContactShares = new List<ContactShare>();

        for(Customer_Portfolio__c customerPorfolio : customerPorfolios)
        {
            newContactShares.add(createContactShareFromCustomerPorfolio(customerPorfolio));
        }

        Database.insert(newContactShares, false);
    }

    /**
     * Creates ContactShare records for controlling access
     *
     * @param  customerPortfolios - List of updated Customer_Portfolio__c records
     * @return void
    */
    public static ContactShare createContactShareFromCustomerPorfolio(Customer_Portfolio__c customerPortfolio)
    {
        ContactShare newContactShare = new ContactShare();
        newContactShare.UserOrGroupId = customerPortfolio.User__c;
        newContactShare.ContactId = customerPortfolio.Contact__c;
        newContactShare.ContactAccessLevel = 'Read';
        newContactShare.RowCause = 'Manual';

        return newContactShare;
    }

    /**
     * Recalculates 
     *
     * @param  customerPortfolios - List of deleted Customer_Portfolio__c records
     * @return void
    */
    public static void recalculateContactSharing(List<Customer_Portfolio__c> customerPorfolios)
    {
        UserRole currentUserRole = [SELECT Id FROM UserRole WHERE Id =: System.userInfo.getUserRoleId()];
        Set<Id> contactIds = new Set<Id>();
        Set<Id> userIds = new Set<Id>();
        for(Customer_Portfolio__c customerPorfolio : customerPorfolios)
        {
            contactIds.add(customerPorfolio.Contact__c);
            userIds.add(customerPorfolio.User__c);
        }

        Database.delete([SELECT Id FROM ContactShare WHERE UserOrGroupId IN :userIDs AND ContactId IN :contactIds]);
    }
}