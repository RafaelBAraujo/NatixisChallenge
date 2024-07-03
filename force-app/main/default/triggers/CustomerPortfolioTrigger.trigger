trigger CustomerPortfolioTrigger on Customer_Portfolio__c (before insert, after insert, before update, after update, before delete, after delete, after undelete) {

    switch on Trigger.operationType {
        when BEFORE_INSERT {
            CustomerPortfolioTriggerHandler.beforeInsert(Trigger.newMap);
        }
        when AFTER_INSERT {
            CustomerPortfolioTriggerHandler.afterInsert(Trigger.newMap);
        }
        when BEFORE_UPDATE {
        }
        when AFTER_UPDATE {
        }
        when BEFORE_DELETE {
        }
        when AFTER_DELETE {
            CustomerPortfolioTriggerHandler.afterDelete(Trigger.oldMap);
        }
    }

}