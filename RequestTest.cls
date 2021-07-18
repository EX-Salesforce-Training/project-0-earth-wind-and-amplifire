/* Name: P0 Request Object Trigger Helper Tests
 * Author: Blake Prescott(blake.prescott@revature.net)
 * Created Date: 7/16/21 
 * Last Modified Date: 7/17/21
 * Description: This is the test class for the request trigger.
 */
@isTest
public class RequestTriggerTest {
	
    @isTest
    public static void singleLocationTest(){
        Account acc = new Account(Name = 'Bob', billingStreet = 'test street', billingCity = 'test city', billingState = 'test state', billingCountry = 'test country', billingPostalCode = '20740');
    	insert acc;
        
        Request__c req = new Request__c(client_account__c = acc.Id, reward__c = 1);
        insert req;
        Request__c r = [SELECT Location__c FROM Request__c WHERE ID =: req.Id limit 1];
        
        System.assertEquals('test street, test city, test state 20740, test country', r.Location__c);
        
        r.Location__c = 'Test Custom Location';
        update r;
        Request__c r2 = [SELECT Location__c FROM Request__c WHERE ID =: req.Id limit 1];
        
        System.assertEquals('Test Custom Location', r2.Location__c);
    }
    
    public static void multiLocationTest(){
        Account acc = new Account(Name = 'Bob', billingStreet = 'test street', billingCity = 'test city', billingState = 'test state', billingCountry = 'test country', billingPostalCode = '20740');
        List<Request__c> reqList = new List<Request__c>();
        For(integer i = 0; i<100; i++){
            Request__c req = new Request__c(name = 'testRequest' + i, client_account__c = acc.Id, reward__c = 5);
            reqList.add(req);
        }
        insert reqList;
        
        List<Request__c> reqsWithLocations = [SELECT Location__c 
                                              FROM Request__c 
                                              WHERE Location__c LIKE 'test street, test city, test state 20740, test country'];
    	System.assertEquals(100, reqsWithLocations.size());
    }
    
    
}