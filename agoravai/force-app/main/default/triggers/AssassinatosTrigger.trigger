trigger AssassinatosTrigger on Assassinato__c (after insert) {

    if (Trigger.isAfter && Trigger.isInsert) {
        //AssassinatosTriggerHandler.afterInsert(Trigger.new);
    }

}