public without sharing class JogadoresTriggerHandler {
    public static void beforeUpdate(List<Jogador__c> records, Map<Id, Jogador__c> oldMap) {
        for (Jogador__c jogador : records) { //realiza uma iteração
            beforeUpdate(jogador, oldMap.get(jogador.Id));
        }
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

    private static void setValue(Jogador__c record, Schema.SObjectField field, Object value) {
        record.put(field, value);
    }

    private static void handleEliminacaoMorte(Jogador__c record, Jogador__c recordOld) {

        if (foiEliminado(record, recordOld) || morreu(record, recordOld)) {

            //se é jogador comum OU se morreu
            if (ehJogadorComum(record) || morreu(record, recordOld)) { 
                System.debug('é jogador comum OU morreu');
                setMorte(record);

            } else if (!ehJogadorComum(record)) { //É jogador staff (e foi somente eliminado)
                System.debug('é jogador staff e foi somente eliminado');
                setEliminado(record);

            } else { //não deve entrar em nenhum momento aqui
                System.debug('você não deveria estar lendo isso');
            }
        }
    }

    private static Boolean foiEliminado(Jogador__c record,Jogador__c recordOld) {
        return isChanged(record, recordOld, Jogador__c.Eliminado__c);
    }

    private static Boolean morreu(Jogador__c record, Jogador__c recordOld) {
        return isChanged(record, recordOld, Jogador__c.Morreu__c);
    }

    private static Boolean ehJogadorComum(Jogador__c record) {
        /*
        if (String.isBlank(record.MembroStaff__c)) { //é jogador comum
            return true;

        } else { //é membro da staff
            return false;
        }
        */
        return record.RecordTypeId.equals(
            Schema.SObjectType.Jogador__c.getRecordTypeInfosByDeveloperName().get(Label.RECORD_TYPE_DEVELOPER_NAME_JOGADOR_PADRAO).getRecordTypeId()
        );
    }

    private static void setMorte(Jogador__c record) {
        setEliminado(record);
        setValue(record, Jogador__c.Morreu__c, true);
        setValue(record, Jogador__c.DataMorte__c, System.now());
    }

    private static void setEliminado(Jogador__c record) {
        setValue(record, Jogador__c.Eliminado__c, true);
    }
}