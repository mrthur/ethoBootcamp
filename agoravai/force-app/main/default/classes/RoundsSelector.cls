public without sharing class RoundsSelector {

    public static List<Round__c> selectByRoundsIdsWithJogadores(Set<Id> ids) {
        return [
            SELECT  Id, Premio__c, TotalJogadoresEliminados__c,
                    (SELECT Id, ValorPagar__c FROM Jogadores__r WHERE Eliminado__c = true)
            FROM Round__c 
            WHERE Id IN :ids
        ];
    }

}