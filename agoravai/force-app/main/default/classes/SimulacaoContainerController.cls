public with sharing class SimulacaoContainerController {
    @AuraEnabled(cacheable=true)
    public static List<Round__c> getRoundsJogadores() {
        try {
            return RoundsSelector.selectAllRoundsWithJogadoresNaoEliminados();
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled(cacheable=true)
    public static string getAssassinatosByRound() {
        try {
            return AssassinatosSelector.selectAssassinatosByRound();
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}