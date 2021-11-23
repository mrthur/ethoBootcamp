public without sharing class JogadoresTriggerHandler {

    public static void afterInsert(List<Jogador__c> records) {
        List<Jogador__c> jogadores = [SELECT Id, Candidato__r.ValorDivida__c FROM Jogador__c WHERE Id IN :records];

        for (Jogador__c jogador : jogadores) {
            afterInsert(jogador);
        }      

        update jogadores;
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