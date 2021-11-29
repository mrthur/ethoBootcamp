public without sharing class RoundsSelector {

    public static List<Round__c> selectByRoundsIdsWithJogadores(Set<Id> ids) {
        return [
            SELECT  Id, TotalJogadoresEliminados__c, PremioTotal__c,
                    (
                        SELECT Id, ValorPagar__c, RecordTypeId, RecordType.DeveloperName, Candidato__r.Email__c
                        FROM Jogadores__r 
                        WHERE Eliminado__c = true
                    )
            FROM Round__c 
            WHERE Id IN :ids
        ];
    }

    public static List<Round__c> selectRoundsByIdStatusJogadoresVivos(Set<Id> roundsIds, Set<String> statusList) {
        return [
            SELECT 
                Id,
                Vencedor__c,
                (SELECT Id FROM Jogadores__r WHERE Eliminado__c = false)
            FROM Round__c
            WHERE 
                    Id = :roundsIds          
                AND Status__c IN :statusList
        ];
    }

}