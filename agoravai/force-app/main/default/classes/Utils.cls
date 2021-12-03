public without sharing class Utils {
    public static void setValue(SObject record, Schema.SObjectField field, Object value) {
        record.put(field, value);
    }

    public static Set<Id> getSetIds(List<SObject> sObjs, Schema.SObjectField field) {
        Set<Id> ids = new Set<Id>();

        for (SObject sObj : sObjs) {
            ids.add(Id.valueOf(String.valueOf(sObj.get(field))));
        }

        return ids;
    }

    //todo: arrumar nomes 
    public static Integer geraNumero(Integer valorInicial, Integer valorFinal, Integer valorParaSeEvitar) {
        if (valorFinal > valorInicial) {
            Integer valor;
            while (valor == null || valor == valorParaSeEvitar) {
                //TODO: garantir que não vai ficar com o valorParaSeEvitar repetindo
                valor = valorInicial + Integer.valueof(Math.random() * ((valorFinal - valorInicial) + 1));
            }
            return valor;
        } 
        return -1;
    }
}