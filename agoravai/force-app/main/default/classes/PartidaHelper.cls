public class PartidaHelper {
    public void validarAlgoritmo(List<Partida__c> partidas) {
        for(Partida__c partida : partidas) {
            Type tipoClasse = Type.forName(partida.Algoritmo__c);
            if(tipoClasse == null) {
                partida.addError('Algoritmo__c', 'Informe um algoritmo existente.');
            } else if(!IPartida.class.isAssignableFrom(tipoClasse)) {
                partida.addError('Algoritmo__c', 'A classe precisa implementar a interface "IPartida".');
            }
        }
    }
    
    public void validarAlgoritmo(List<Partida__c> partidas, Map<Id, Partida__c> oldMap) {
        List<Partida__c> validar = new List<Partida__c>();
        
        for(Partida__c partida : partidas) {
            if(partida.Algoritmo__c != oldMap.get(partida.Id).Algoritmo__c) {
                validar.add(partida);
            }
        }
        if(!validar.isEmpty()) this.validarAlgoritmo(validar);
    }
    
}