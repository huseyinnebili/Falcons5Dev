public class Demo_Collections {
  public static list<String> displayUpperCasedCar(list<string> listOfCars) {
    List<String> listOfUpperCasedCars = new List<String>();

    for (String listOfCar : listOfCars) {
      String tempStr = listOfCar.toUpperCase();

      listOfUpperCasedCars.add(tempStr);

      System.debug('listOfUpperCasedCars = ' + listOfUpperCasedCars);
    }

    return listOfUpperCasedCars;
  }

  public static set<string> displayKeysOfMap(
    map<string, string> mapOfCountries
  ) {
    Set<String> setOfCountries = mapOfCountries.keySet();

    for (String setOfCountry : setOfCountries) {
      System.debug('setOfCountry = ' + setOfCountry);
    }

    List<String> listOfCapitals = mapOfCountries.values();

    for (String listOfCapital : listOfCapitals) {
      System.debug('listOfCapital = ' + listOfCapital);
    }

    return setOfCountries;
  }

  public static void mobileCarrierCustomer() {
    List<Mobile_Carier_Customer__c> listOfMobileCarrierCustomerRecords = [
      SELECT Customer_Name__c, Customer_Phone__c, Email__c, Name
      FROM Mobile_Carier_Customer__c
      WHERE Email__c != NULL
      ORDER BY Name
    ];

    System.debug(
      'listOfMobileCarrierCustomerRecords = ' +
      listOfMobileCarrierCustomerRecords
    );

    for (
      Mobile_Carier_Customer__c listOfMobileCarrierCustomerRecord : listOfMobileCarrierCustomerRecords
    ) {
      System.debug(
        'listOfMobileCarrierCustomerRecord = ' +
        listOfMobileCarrierCustomerRecord
      );
    }

    Mobile_Carier_Customer__c mobile = [
      SELECT Customer_Name__c, Customer_Phone__c, Email__c, Name
      FROM Mobile_Carier_Customer__c
      WHERE Email__c != NULL
      ORDER BY Name
      LIMIT 1
    ];

    String cust_name = mobile.Customer_Name__c;
    System.debug('cust_name = ' + cust_name);

    String cust_phone = mobile.Customer_Phone__c;
    System.debug('cust_phone = ' + cust_phone);
  }

  public static void fetchMobileCarrierCustomerRecords(String providerCompany) {
    List<Mobile_Carier_Customer__c> listOfMCC = [
      SELECT
        Customer_Name__c,
        Customer_Phone__c,
        Email__c,
        Provider_Companies__c
      FROM Mobile_Carier_Customer__c
      WHERE Provider_Companies__c = :providerCompany
      ORDER BY Name
    ];

    System.debug('listOfMCC = ' + listOfMCC);

    for (Mobile_Carier_Customer__c listOfMC : listOfMCC) {
      String listOfCustomerName = listOfMC.Customer_Name__c;
      System.debug('listOfCustomerName = ' + listOfCustomerName);

      String listOfProviderCompany = listOfMC.Provider_Companies__c;
      System.debug('listOfProviderCompany = ' + listOfProviderCompany);
    }
  }

  public static void displayChildToParentSOQLRelShip() {
    List<Mobile_Carier_Customer__c> listOfMCCRecords = [
      SELECT
        Customer_Name__c,
        Customer_Phone__c,
        Email__c,
        Provider_Companies__c,
        Mobile_Carrier__r.Service_Name__c,
        Mobile_Carrier__r.Country__c
      FROM Mobile_Carier_Customer__c
      WHERE Provider_Companies__c = 'Verizon'
      ORDER BY Name
    ];

    for (Mobile_Carier_Customer__c listOfMCCRecord : listOfMCCRecords) {
      System.debug('listOfMCCRecord = ' + listOfMCCRecord);

      String serviceName = listOfMCCRecord.Mobile_Carrier__r.Service_Name__c;
      System.debug('serviceName = ' + serviceName);

      String countries = listOfMCCRecord.Mobile_Carrier__r.Country__c;
      System.debug('countries = ' + countries);
    }
  }

  public static void parentToChildRelShip() {
    List<Mobile_Carrier__c> listOfMobileCarierObjRecords = [
      SELECT
        Service_Name__c,
        Country__c,
        (
          SELECT
            Customer_Name__c,
            Service_Type__c,
            Plan_Fee__c,
            Plan_Starting_Date__c,
            Plan_Finishing_Date__c,
            Provider_Companies__c
          FROM Mobile_Carrier_Customers__r
        )
      FROM Mobile_Carrier__c
    ];

    for (
      Mobile_Carrier__c listOfMobileCarierObjRecord : listOfMobileCarierObjRecords
    ) {
      System.debug(
        'listOfMobileCarierObjRecord = ' + listOfMobileCarierObjRecord
      );
      for (
        Mobile_Carier_Customer__c listOfMCCRecord : listOfMobileCarierObjRecord.Mobile_Carrier_Customers__r
      ) {
        System.debug('listOfMCCRecord = ' + listOfMCCRecord);
      }
    }
  }

  public static void childToParentStudentBranchObjects() {
    List<AggregateResult> listOfStudentObjRecords = [
      SELECT
        count(Student_Name__c),
        Student_DOB__c,
        Type_of_Lectures__c,
        Branch_ID__r.Branch_Name__c,
        Branch_ID__r.HOD_Name__c
      FROM Student__c
      WHERE Student_Name__c != NULL
      GROUP BY
        Branch_ID__r.HOD_Name__c,
        Student_DOB__c,
        Type_of_Lectures__c,
        Branch_ID__r.Branch_Name__c

    ];

    for (AggregateResult listOfStudentObjRecord : listOfStudentObjRecords) {
      System.debug('listOfStudentObjRecor = ' + listOfStudentObjRecord);

      //   String branchName = listOfStudentObjRecord.Branch_ID__r.Branch_Name__c;
      //   System.debug('branchName = ' + branchName);

      //   String hodNames = listOfStudentObjRecord.Branch_ID__r.HOD_Name__c;
      //   System.debug('hodNames =' + hodNames);
    }
  }

  public static void childToParentStudentBranchObjectsTwo() {
    List<Student__c> listOfStudentRecords = [
      SELECT
        Student_Name__c,
        Student_DOB__c,
        Type_of_Lectures__c,
        Branch_ID__r.Branch_Name__c,
        Branch_ID__r.HOD_Name__c
      FROM Student__c
      WHERE Student_Name__c != NULL
    ];

    for (Student__c listOfStudentRecord : listOfStudentRecords) {
      System.debug('listOfStudentRecord = ' + listOfStudentRecord);

      String branchNames = listOfStudentRecord.Branch_ID__r.Branch_Name__c;
      System.debug('branchNames = ' + branchNames);
    }
  }

  public static void parentToChildBranchObjectRecords() {
    List<Branch__c> listOfBranchRecords = [
      SELECT
        Name,
        Branch_Count__c,
        Branch_Name__c,
        (
          SELECT
            After_School_Program__c,
            Branch_Name__c,
            Course_Fee__c,
            Program_Name__c
          FROM Students__r
        )
      FROM Branch__c
    ];

    for (Branch__c listOfBranchRecord : listOfBranchRecords) {
      System.debug('listOfBranchRecord = ' + listOfBranchRecord);

      for (
        Student__c listOfStudentsObjectRecord : listOfBranchRecord.Students__r
      ) {
        System.debug(
          'listOfStudentsObjectRecord = ' + listOfStudentsObjectRecord
        );
      }
    }
  }

  public static void parentToChildBranchObjectRecordsTwo() {
    List<Branch__c> listOfBranchRecords = [
      SELECT
        Branch_Name__c,
        Branch_Registration_Due_Date__c,
        HOD_Name__c,
        (
          SELECT Boot_Camps__c, Referral_Name__c, Student_Class_ID__c
          FROM Students__r
        )
      FROM Branch__c
      WHERE Branch_Registration_Due_Date__c != NULL
    ];

    for (Branch__c listOfBranchRecord : listOfBranchRecords) {
      System.debug('listOfBranchRecord = ' + listOfBranchRecord);

      for (
        Student__c listOfStudentObjectRecord : listOfBranchRecord.Students__r
      ) {
        System.debug(
          'listOfStudentObjectRecord = ' + listOfStudentObjectRecord
        );
      }
    }
  }
}