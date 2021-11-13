public virtual class TriggerHandler {
    public void run() {
        if(Trigger.isBefore) {
            if(Trigger.isInsert) {
                this.beforeInsert();
            }
            if(Trigger.isUpdate) {
                this.beforeUpdate();
            }
            if(Trigger.isDelete) {
                this.beforeDelete();
            }
            if(Trigger.isUndelete) {
                this.beforeUndelete();
            }
        }
        if(Trigger.isAfter) {
            if(Trigger.isInsert) {
                this.afterInsert();
            }
            if(Trigger.isUpdate) {
                this.afterUpdate();
            }
            if(Trigger.isDelete) {
                this.afterDelete();
            }
            if(Trigger.isUndelete) {
                this.afterUndelete();
            }
        }
    }
        
    protected virtual void beforeInsert(){}
    protected virtual void beforeUpdate(){}
    protected virtual void beforeDelete(){}
    protected virtual void beforeUndelete(){}
    protected virtual void afterInsert(){}
    protected virtual void afterUpdate(){}
    protected virtual void afterDelete(){}
    protected virtual void afterUndelete(){}
}