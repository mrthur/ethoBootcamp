public class AssassinatoSchedulable implements Schedulable {

    Integer addMinutes;

    public AssassinatoSchedulable(Integer addMinutes) {
        this.addMinutes = addMinutes;        
    }

    public void execute(SchedulableContext sc) {
        reschedule(sc);
        AssassinatosHandler.execute();
    }

    private void reschedule(SchedulableContext sc)
    {
        // Re-schedule ourself to run again in "intervalMinutes" time
        Datetime now  = Datetime.now();
        Datetime nextRunTime = now.addMinutes(addMinutes);
        //todo: levar cronString para Utils
        String cronString = '' + nextRunTime.second() + ' ' + nextRunTime.minute() + ' ' + 
                            nextRunTime.hour() + ' ' + nextRunTime.day() + ' ' + 
                            nextRunTime.month() + ' ? ' + nextRunTime.year(); 
        System.schedule(
            AssassinatoSchedulable.class.getName() + '-' + now.format(),
            cronString,
            new AssassinatoSchedulable(Utils.generateRandomIntegerBetween((12*60), (36*60)))
        );

        // Abort the current job
        Id jobId = sc.getTriggerId();
        System.abortJob(jobId);
    }
}