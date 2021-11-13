public class PartidaHandler extends TriggerHandler {
    public override void beforeInsert() {
        new PartidaHelper().validarAlgoritmo((List<Partida__c>) Trigger.new);
    }
    
    public override void beforeUpdate() {
        new PartidaHelper().validarAlgoritmo((List<Partida__c>) Trigger.new, (Map<Id, Partida__c>) Trigger.oldMap);
    }
    
}