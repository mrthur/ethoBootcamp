public without sharing class JogadoresTriggerHandler {

    public static void afterInsert(List<Jogador__c> records) {
        List<Jogador__c> jogadores = [SELECT Id, Candidato__r.ValorDivida__c FROM Jogador__c WHERE Id IN :records];

        for (Jogador__c jogador : jogadores) {
            afterInsert(jogador);
        }      

        update jogadores;
    }
    

    public static void afterUpdate(List<Jogador__c> records, Map<Id, Jogador__c> oldMap) {

        /*

• records = registros q sofreram update (é after)
• oldMap = os mesmos registros, antes do update
• recordsRoundsMap = ids dos rounds dos jogadores em records
• roundsMap = map com um select que pega todos os jogadores não eliminados dos rounds de recordsRoundsMap
• roundsToUpdate = map em branco, será preenchido quando verificar quais os rounds que possuem vencedor.
Percorre a lista de registros que sofreram alteração
        */
        Set<String> statusList = new Set<String>{'Em Andamento'};
        //Map<Id, Round__c> roundsMap = new Map<Id, Round__c>(RoundsSelector.selectRoundsByIdStatusJogadoresVivos(Utils.getSetIds(records, Jogador__c.Round__c), statusList));
        Set<Id> recordsRoundsMap = new Set<Id>();
        for (Jogador__c i : records) {
            recordsRoundsMap.add(Id.valueOf(String.valueOf(i.get(Jogador__c.Round__c))));
        }
        Map<Id, Round__c> roundsMap = new Map<Id, Round__c>(RoundsSelector.selectRoundsByIdStatusJogadoresVivos(recordsRoundsMap, statusList));
        System.debug('roundsMap: ' + JSON.serialize(roundsMap));
        Map<Id, Round__c> roundsToUpdate = new Map<Id, Round__c>();
        for (Jogador__c record : records) {
            System.debug('record: ' + JSON.serialize(record));
            Jogador__c recordOld = oldMap.get(record.Id);
            System.debug('recordOld: ' + JSON.serialize(recordOld));
            Round__c roundRelacionadoAoRecord = roundsMap.get(record.Round__c);
            System.debug('roundRelacionadoAoRecord: ' + JSON.serialize(roundRelacionadoAoRecord));
            
            afterUpdate(record, recordOld, roundRelacionadoAoRecord, roundsToUpdate);
        }

        System.debug('VAI DAR UPDATE EM: ' + JSON.serialize(roundsToUpdate.values()));

        update roundsToUpdate.values();
    }

    static void afterUpdate(Jogador__c record, Jogador__c recordOld, Round__c roundRecord, Map<Id, Round__c> roundsToUpdate) {
        handleVencedor(record, roundRecord, roundsToUpdate);
    }
    
    static void handleVencedor(Jogador__c record, Round__c roundRecord, Map<Id, Round__c> roundsToUpdate) {
        if (roundRecord != null) {
            System.debug('handle vencedor');
            System.debug('roundsToUpdate.containsKey(roundRecord.Id): ' + (roundsToUpdate.containsKey(roundRecord.Id)));
            System.debug('roundRecord.Jogadores__r.size() == 1: ' + (roundRecord.Jogadores__r.size() == 1));
            if (!roundsToUpdate.containsKey(roundRecord.Id) && roundRecord.Jogadores__r.size() == 1) {
                System.debug('ENTROUUUU BORA SETAR O VENCEDOR FILHA DAS PUTA');
    
                List<Jogador__c> jogadoresRound = roundRecord.Jogadores__r;
                System.debug('jogadores desse round: ' + JSON.serialize(jogadoresRound));
                Jogador__c vencedor = jogadoresRound.get(0);
                System.debug('vencedor: ' + JSON.serialize(vencedor));
                Id roundRecordId = roundRecord.Id;
                System.debug('roundRecordId: ' + roundRecordId);
                Round__c roundUpdated = new Round__c();
                roundUpdated.Id = roundRecord.Id;
                roundUpdated.Vencedor__c = vencedor.Id;
                roundUpdated.Status__c = 'Finalizado';
                System.debug('roundUpdated: ' + JSON.serialize(roundUpdated));
    
                roundsToUpdate.put(roundUpdated.Id, roundUpdated);
    
                System.debug('roundsToUpdate: ' + JSON.serialize(roundsToUpdate));
            }
        }
    }

    public static void beforeUpdate(List<Jogador__c> records, Map<Id, Jogador__c> oldMap) {
        for (Jogador__c jogador : records) { 
            beforeUpdate(jogador, oldMap.get(jogador.Id));
        }
    }

    private static void afterInsert(Jogador__c record) {
        Utils.setValue(record, Jogador__c.Divida__c, record.Candidato__r.ValorDivida__c);
    }

    private static void beforeUpdate(Jogador__c record, Jogador__c recordOld) {
        handleEliminacaoMorte(record, recordOld);
    }

    private static Boolean isChanged(Jogador__c record, Jogador__c recordToCompare, Schema.SObjectField fieldToEvaluate) {
        return isChanged(record.get(fieldToEvaluate), recordToCompare.get(fieldToEvaluate));
    }

    private static Boolean isChanged(Object value, Object valueToCompare) {
        return value != valueToCompare;
    }

    private static void handleEliminacaoMorte(Jogador__c record, Jogador__c recordOld) {

        if (ehJogadorPadrao(record) && foiEliminado(record, recordOld)) {
            Utils.setValue(record, Jogador__c.Morreu__c, true);
        }

        if (morreu(record, recordOld)) {
            Utils.setValue(record, Jogador__c.DataMorte__c, System.now());
            Utils.setValue(record, Jogador__c.Eliminado__c, true);
        }
    }

    private static Boolean ehJogadorPadrao(Jogador__c record) {
        return record.RecordTypeId.equals(
            Schema.SObjectType.Jogador__c.getRecordTypeInfosByDeveloperName().get(Label.RECORD_TYPE_DEVELOPER_NAME_JOGADOR_PADRAO).getRecordTypeId()
        );
    }

    @TestVisible
    private static Boolean foiEliminado(Jogador__c record, Jogador__c recordOld){
        return isChanged(recordOld, record, Jogador__c.Eliminado__c);
    }

    private static Boolean morreu(Jogador__c record, Jogador__c recordOld){
        return isChanged(recordOld, record, Jogador__c.Morreu__c);
    }


}