trigger AccountTrigger on Account (before insert, after insert, before update, after update, before delete, after delete, after undelete) {

    switch on Trigger.operationType {
        when BEFORE_INSERT {
        }
        when AFTER_INSERT {
        }
        when BEFORE_UPDATE {
        }
        when AFTER_UPDATE {
        }
        when BEFORE_DELETE {
            AccountTriggerHandler.beforeDelete(Trigger.oldMap);
        }
        when AFTER_DELETE {
        }
    }

}