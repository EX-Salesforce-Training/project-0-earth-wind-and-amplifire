/* Name: P0 Request Object Trigger Helper
 * Author: Blake Prescott(blake.prescott@revature.net)
 * Created Date: 7/12/21 
 * Last Modified Date: 7/13/21
 * Description: This is the trigger helper for the Request object for my P0, the Fantasy Guild Org.
 */
public class RequestTriggerHandler {
    //If the location text area is empty and all of the address fields are empty, set the address fields to match the account's address. 
    //The actual Location field doesn't have to be an address, since quests often involve going into caves and stuff, so if there is a location the address fields aren't required
    public static void LinkEmptyLocationsToAccountAddress(List<Request__c> reqs){
        for(Request__c r : reqs){
            if(r.Location__c == '' && r.Request_Street__c == '' && r.Request_City__c == '' && r.Request_State__c == '' && r.Request_Country__c == '' && r.Request_Postal_Code__c == ''){
                r.Request_Street__c = r.Client_Account__r.billingStreet;
                r.Request_City__c = r.Client_Account__r.billingCity;
                r.Request_State__c = r.Client_Account__r.billingState;
                r.Request_Country__c = r.Client_Account__r.billingCountry;
                r.Request_Postal_Code__c = r.Client_Account__r.billingPostalCode;
                r.Location__c = r.Request_Street__c + ', ' + r.Request_City__c + ', ' + r.Request_State__c + ' ' + r.Request_Postal_Code__c + ', ' + r.Request_Country__c + '.';
            }
        }
    }
    
    public static void SetDefaultDescription(List<Request__c> reqs){
        for(Request__c r : reqs){
            if(r.Request_Details__c == '' && r.Client_Account__r.phone != null){
                r.Request_Details__c = 'Call ' + r.Client_Account__r.phone + ' to speak with the client for further details.';
            }else if(r.Request_Details__c == '' && r.Client_Account__r.phone != null && r.Location__c != null){
                r.Request_Details__c = 'Speak with the client at' + r.Location__c + ' for more details.';
            }else if(r.Request_Details__c == '' && r.Client_Account__r.phone == null && r.Location__c == null && r.Request_Street__c != null && r.Request_City__c != null && r.Request_State__c != null && r.Request_Country__c != '' && r.Request_Postal_Code__c != null){
                r.Request_Details__c = 'Speak with the client at' + r.Request_Street__c + ', ' + r.Request_City__c + ', ' + r.Request_State__c + ' ' + r.Request_Postal_Code__c + ', ' + r.Request_Country__c + '.';
            }else{
                r.addError('Insuffecient contact information for this request\'s details to be left blank! Provide details for this request or update the client account\'s contact information!');
            }
        }
    }
}