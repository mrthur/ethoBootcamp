trigger PartidaTrigger on Partida__c (before insert, before update) {
    new PartidaHandler().run();
}