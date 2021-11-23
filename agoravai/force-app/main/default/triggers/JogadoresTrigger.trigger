trigger JogadoresTrigger on Jogador__c  (after insert, before update) {

    if (Trigger.isBefore) {
        if (Trigger.isUpdate) {
            JogadoresTriggerHandler.beforeUpdate(Trigger.new, Trigger.oldMap);
        }
    } else if (Trigger.isAfter) {
        if (Trigger.isInsert) {
            JogadoresTriggerHandler.afterInsert(Trigger.new);
        }
    }

}