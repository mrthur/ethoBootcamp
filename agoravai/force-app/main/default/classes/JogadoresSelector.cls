public without sharing class JogadoresSelector {

    public static List<Jogador__c> selectJogadoresNaoEliminadosByRoundsInSituation(Set<Id> ids, Set<String> situacao) {
        return [
            SELECT Id, Name, Nick__c, Eliminado__c, Morreu__c, Round__c, Round__r.Id, Round__r.Status__c
            FROM Jogador__c
            WHERE Round__r.Status__c IN :situacao
            AND Eliminado__c = false
            AND Id IN :ids
            ORDER BY Round__c
        ];
    }

    //TODO: mudar o nome e passar o false do eliminado também
    public static List<Jogador__c> selectJogadoresNaoEliminados(Set<String> statusList) {
        return [
            SELECT Id, Name, Nick__c, Forca__c, Round__r.Status__c, Inteligencia__c, Velocidade__c
            , Eliminado__c 
            FROM Jogador__c
            WHERE Round__r.Status__c IN :statusList AND Eliminado__c = false
        ];
    }
}

/*
trigger em jogador
	verifica se sobrou somente 1 vivo
		caso positivo
			atualiza o campo vencedor__c no round
		caso negativo
			não faz nada
            */