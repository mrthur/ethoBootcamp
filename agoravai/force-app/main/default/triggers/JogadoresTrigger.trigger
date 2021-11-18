trigger JogadoresTrigger on Jogador__c (before update) {

    //Versão 1: noob!
    if (Trigger.isBefore) {
        if (Trigger.isUpdate) {

            JogadoresTriggerHandler.beforeUpdate(Trigger.new, Trigger.oldMap); //chama o handler
            
            /*
            for (Jogador__c jogador : Trigger.new) {
                Jogador__c jogadorOld = Trigger.oldMap.get(jogador.id);

                if (!jogadorOld.Eliminado__c && jogador.Eliminado__c) {
                    jogador.DataMorte__c = System.now();
                }
            }
            */
        }
    }
}