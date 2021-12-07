public with sharing class SimulacaoContainerController {
    @AuraEnabled(cacheable=true)
    public static List<Round__c> getRoundsJogadores() {
        try {
            return RoundsSelector.selectAllRoundsWithJogadoresNaoEliminados();
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static AssassinatoWrapper tentativaAssassinato(List<Jogador__c> jogadores) {
        try {     
            Assassinato__c ass = AssassinatosHandler.execute(jogadores);
            if (ass != null) {
                insert ass;
            
                Jogador__c jog = new Jogador__c(Id=ass.Assassinado__c);
                jog.Morreu__c = true;
                update jog;
            }      
            
            AssassinatoWrapper aw = new AssassinatoWrapper();
            aw.Assassinato = ass;
            aw.Rounds = RoundsSelector.selectAllRoundsWithJogadoresNaoEliminados();
            
            return aw;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }   
    
    public class AssassinatoWrapper {
        @AuraEnabled
        public Assassinato__c Assassinato;
        @AuraEnabled
        public List<Round__c> Rounds;
    }
}