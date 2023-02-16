@isTest
public with sharing class ChildToParentAndParentToChildTest {
  @isTest
  public static void childToParentSOQLTest() {
    List<Device__c> deviceList = new List<Device__c>();

    Device__c obj1 = new Device__c();
    obj1.Product_Name__c = 'Dell Desktop';
    obj1.Product_Code__c = 'SA21324243';

    Device__c obj2 = new Device__c();
    obj2.Product_Name__c = 'Dell Desktop';
    obj2.Product_Code__c = 'ZT21324243';

    Device__c obj3 = new Device__c();
    obj3.Product_Name__c = 'Dell Desktop';
    obj3.Product_Code__c = 'MG2134523';

    deviceList.add(obj1);
    deviceList.add(obj2);
    deviceList.add(obj3);

    insert deviceList;

    list<Support_Ticket__c> supportList = new List<Support_Ticket__c>();

    for (Integer i = 0; i < 10000; i++) {
      Support_Ticket__c ticket = new Support_Ticket__c();

      ticket.Ticket_Product_Code__c = 'AX121w323';
      ticket.Phone__c = '2123212312';

      if (i < 3000) {
        ticket.Device_ID__c = obj1.id;
      } else if (i < 6000) {
        ticket.Device_ID__c = obj2.id;
      } else if (i < 10000) {
        ticket.Device_ID__c = obj3.id;
      }

      supportList.add(ticket);
    }

    insert supportList;

    Test.startTest();

    ChildToParentAndParentToChild.childToParentSOQL();

    Test.stopTest();

    system.assert(supportList.size() > 0);
  }
}