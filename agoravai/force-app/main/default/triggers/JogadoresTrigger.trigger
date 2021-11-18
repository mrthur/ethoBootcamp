trigger JogadoresTrigger on Jogador__c (before update) {

    //Versão 1: noob!
    if (Trigger.isBefore) {
        if (Trigger.isUpdate) {

            JogadoresTriggerHandler.beforeUpdate(Trigger.new, Trigger.oldMap); //chama o handler

        }
    }
}