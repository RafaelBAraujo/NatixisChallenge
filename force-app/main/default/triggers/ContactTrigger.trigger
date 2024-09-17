trigger ContactTrigger on Contact (before insert, after insert, before update, after update, before delete, after delete, after undelete) {

    switch on Trigger.operationType {
        when BEFORE_INSERT {
        }
        when AFTER_INSERT {
        }
        when BEFORE_UPDATE {
        }
        when AFTER_UPDATE {
            ContactTriggerHandler.afterUpdate(Trigger.newMap, Trigger.oldMap);
        }
        when BEFORE_DELETE {
        }
        when AFTER_DELETE {
        }
    }

}