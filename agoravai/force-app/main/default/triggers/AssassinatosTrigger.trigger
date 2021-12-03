trigger AssassinatosTrigger on Assassinato__c (after insert) {

    if(Trigger.isAfter && Trigger.isInsert) {
        //desabilitei a trigger para os testes com o jogo via lwc
        //AssassinatosTriggerHandler.afterInsert(Trigger.new);
    }

}