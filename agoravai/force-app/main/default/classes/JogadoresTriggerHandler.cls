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

            } else { //se ñ é jogador comum ou não morreu, ou seja é jogador staff OU foi eliminado
                System.debug('NÃO É jogador comum OU NÃO morreu');
                setEliminado(record);
            }
        }
    }

    private static Boolean ehJogadorComum(Jogador__c record) {
        if (record.MembroStaff__c == null) { //é jogador comum
            return true;

        } else { //é membro da staff
            return false;
        }
        
    }

    private static Boolean foiEliminado(Jogador__c record,Jogador__c recordOld) {
        return isChanged(record, recordOld, Jogador__c.Eliminado__c);
    }

    private static Boolean morreu(Jogador__c record, Jogador__c recordOld) {
        return isChanged(record, recordOld, Jogador__c.Morreu__c);
    }

    private static void setMorte(Jogador__c record) {
        setValue(record, Jogador__c.Morreu__c, true);
        setValue(record, Jogador__c.Eliminado__c, true);
        setValue(record, Jogador__c.DataMorte__c, System.now());
    }

    private static void setEliminado(Jogador__c record) {
        setValue(record, Jogador__c.Eliminado__c, true);
    }
}