public class BatatinhaFrita implements IPartida {
    public void execute(Id idPartida) {
        List<ParticipantePartida__c> participantes = [SELECT Jogador__c FROM ParticipantePartida__c WHERE Partida__c = :idPartida];
        
        List<Jogador__c> jogadores = new List<Jogador__c>();
        //mesma coisa que:
        //Jogador__c[] jogadores = new List<Jogador__c>();
        
        Integer mortes = (Integer) participantes.size() / 2;
        
        for(Integer i = 0; i < mortes; i++) {
            jogadores.add(new Jogador__c(Id = participantes[i].Jogador__c, Eliminado__c = true));
        }
        
        //System.debug(jogadores);
        update jogadores;
        
        update new Partida__c(Id = idPartida, TerminoPartida__c = System.now());
    }
}