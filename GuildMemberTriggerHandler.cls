public class GuildMemberTriggerHandler {
    public static void maxMinMemberLevels(List<Guild_Member__c> gm){
        for (Guild_Member__c g : gm) {           
            If(g.RecordTypeId == '0125e0000006hYm') {
                Integer minLevels = g.class__c.countMatches(';')+1;
                system.debug(minLevels);
                If(g.Levels__c < minLevels || g.Levels__c > 20){
                    g.addError('An adventurer cannot have fewer levels than classes and cannot have more than 20 levels.');
                }
            }    
        }
    }
}