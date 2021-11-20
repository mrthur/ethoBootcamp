trigger RoundsTrigger on Round__c (after update) {

    if(Trigger.isAfter && Trigger.isUpdate) {
        RoundsTriggerHandler.afterUpdate(Trigger.new, Trigger.oldMap);
    }

}