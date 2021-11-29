public without sharing class AssassinatosTriggerHandler {

    public static void afterInsert(List<Assassinato__c> records) {
        List<Jogador__c> jogadoresMortos = new List<Jogador__c>();
        for (Assassinato__c record : records) {
            mataJogadorAssassinado(record, jogadoresMortos);
        }
        update jogadoresMortos;
    }

    static void mataJogadorAssassinado(Assassinato__c record, List<Jogador__c> jogadoresMortos) {
        jogadoresMortos.add(
            new Jogador__c(
                Id = record.Assassinado__c,
                Eliminado__c = true,
                Morreu__c = true,
                DataMorte__c = record.DataHora__c
            )
        );
    }
}