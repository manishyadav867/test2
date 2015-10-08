//*************************************************************************************
// Name             : CaseProcessingTest
// Description      : Class to increase test coverage of "CaseProcessing"
// Created By       : Nilanjana Mukherjee
// Created Date     : 06/22/2015
//TestCoverage      : 81%
//TestCoverage      : 81 %
// ************************************************************************************
@isTest(seealldata=true)
private class CaseProcessingTest
{ 

        public static Case testCase1,testCase2,testCase3,testCase4,testCase5;
        public static  user u,u1,u2;
        public static List<AccountTeamMember> accTeamMembers;
        public static List<Account> listAccounts;
        public static Account testAccount0,testAccount;
        public static Task Task2; 
        public static List<Contact> listContacts;
        public static Contact testContact,testContact0;  
        public static Record_Type_Settings__c oRTSACC = Record_Type_Settings__c.getInstance('GSS_ACC_EC');
        public static Record_Type_Settings__c oRTSCON = Record_Type_Settings__c.getInstance('GSS_CON_CC');
        public static Id Case_PN_RecordType=Id.valueOf(Record_Type_Settings__c.getInstance('SFA_Case_PN').Record_Type_ID__c);
        public static string Task_sendAlert_RecordType=Id.valueOf(Record_Type_Settings__c.getInstance('SFA_Task_SendAlert').Record_Type_ID__c);
        public static String Ivradmin =GSS_Configuration_Properties_list__c.getInstance('IVR_ADMIN').setting_value__c ;
        public Static Id caseAdminId = Id.ValueOf(GSS_Configuration_Properties_list__c.getInstance('CaseAdmin').setting_value__c); 
        public Static Id SiteUser = Id.ValueOf(GSS_Configuration_Properties_list__c.getInstance('SiteUser').setting_value__c);
        public static datetime dt = datetime.now();
        public static datetime newdate =dt.addSeconds(+5);
        public static String rct =Record_Type_Settings__c.getValues('RCM_Case_Renewal_Operations').Record_Type_ID__c;
        public static Id carpathiaRecType = Id.valueof(Record_Type_Settings__c.getInstance('GSS_CASE_SDP_FED').Record_Type_ID__c); 
        public static Id myVmwareRTITSup = Id.valueOf(Record_Type_Settings__c.getInstance('ITAppsSupport').Record_Type_ID__c);
        public static Id myVmwareRTCommon=Id.valueOf(Record_Type_Settings__c.getInstance('GSS_MyVmwareCommonCase').Record_Type_ID__c);
        public static Id techSupport = Id.valueOf(Record_Type_Settings__c.getValues('GSS_CASE_TS').Record_Type_ID__c);
        public static Id recTypeIdCase=Id.valueOf(Record_Type_Settings__c.getInstance('GSS_CASE_LIC').Record_Type_ID__c);
        public static Id recTypeIdCase2=Id.valueOf(Record_Type_Settings__c.getInstance('SubscriptionServices').Record_Type_ID__c);
        public static Profile_Name_Mapping__c prf = CustomSettingUtility.getProfileNameMapping('GSS System Administrator');
        public static Profile_Name_Mapping__c prf1 = CustomSettingUtility.getProfileNameMapping('Carpathia');
        public static Id prf2= Profile_Name_Mapping__c.getInstance('Profile - 150').Profile_Id__c;
        public static GSSSupportLevel__c support=GSSSupportLevel__c.getInstance('Brazil');
        public static GSS_ServiceNow_Parameters__c  gssSNParameter = GSS_ServiceNow_Parameters__c.getOrgDefaults();
         public static Carpathia_Variables__c  carpathiaAccRec = Carpathia_Variables__c.getInstance('Carpathia Account');      
          public static    Carpathia_Variables__c  carpathiaConRec = Carpathia_Variables__c.getInstance('Carpathia Contact');          
        public static Id pro;
        public static Id pro1;
        public static Id pro2;
        public static string sup;
        public static string sup1;
       
     public static void setupdata()
    {   
        pro=Id.ValueOf(prf.Profile_Id__c);
        pro1= Id.ValueOf(prf1.Profile_Id__c);         
        sup=String.valueOf(support.Country__c);
        sup1=String.valueOf(support.Support_Level__c);
        Id roleId = [select Id from UserRole where PortalType = 'Partner' LIMIT 1].Id;
        
         u = new User(Alias = 'alias',email='standarduser@testorg.com',emailencodingkey='UTF-8',Username = 'someuser@somedomain.com',
                Lastname = 'somelastname',languagelocalekey='en_US',localesidkey='en_US',timezonesidkey='America/Los_Angeles',CommunityNickname = 'somecommunitynickname',
                profileid =pro, country='United States');
         insert(u);

        listAccounts = new List<Account>();
        testAccount = new Account();
        testAccount.Name = 'Test Account1';        
        testAccount.Country__c = 'INDIA';
        testAccount.Type='Public Sector';
        testAccount.RecordTypeId=oRTSACC.record_type_id__c;
        testAccount.GSS_S1_Red_Alert_Notifications__c = true;
        testAccount.OwnerId = u.Id;
        listAccounts.add(testAccount);
        
        testAccount0 = new Account();
        testAccount0.Name = 'Test Account';        
        testAccount0.Country__c = 'INDIA';
        testAccount0.Type='Public Sector';
        testAccount.RecordTypeId=oRTSACC.record_type_id__c;
        testAccount0.GSS_S1_Red_Alert_Notifications__c = true;
        testAccount0.OwnerId = u.Id;
        listAccounts.add(testAccount0);       
        
        insert listAccounts;
        
        listContacts = new List<Contact>();
        testContact = new Contact();
        testContact.LastName= 'Test Contact1';        
        testContact.Email= 'Test@gmail.com';
        testContact.Phone='0000000';
        testContact.AccountId=listAccounts[0].Id;
        testContact.RecordTypeId=oRTSCON.record_type_id__c;
        listContacts.add(testContact);
        
        testContact0 = new Contact();
        testContact0.LastName= 'Test Contact1';        
        testContact0.Email= 'Test@gmail.com';
        testContact0.Phone='0000000';
        testContact0.AccountId=listAccounts[0].Id;
        testContact0.RecordTypeId=oRTSCON.record_type_id__c;
        listContacts.add(testContact0);
        
        insert listContacts;
   
          System.runAs(u)
         {
         
                u1 = new User(Alias = 'alias',email='standarduser@testorg.com',emailencodingkey='UTF-8',Username = 'someuser@somedomain.com',
                Lastname = 'somelastname',languagelocalekey='en_US',localesidkey='en_US',timezonesidkey='America/Los_Angeles',CommunityNickname = 'somecommunitynickname',
                profileid=pro1 , country='United States',ContactId=listContacts[0].Id);
                u1.userRoleId = roleId;
             
         } 
          
          u.GSS_Manager__c = u1.Id;         
          update u;
 
    }
    static testMethod void  updateCaseAdditionalEmailstest ()
    {
        setUpData();
   
        Test.startTest();  
       
        List<Case> listCase = new List<Case>();
        testCase1 = new Case(Origin='Email',GSS_Preferred_Method_of_Contact__c='Email',Priority='1 - Critical',GSS_ScreenPopTime__c=newdate ,
                             GSS_Problem_Category__c='OS',GSS_Support_Level__c='2',Status='Escalated',Subject ='Testing1', GSS_Support_Customer_Region__c ='APJ',GSS_Additional_Emails__c='test@gmail.com',Region_First_Response__c='NASA',RNV_Status__c='Escalated',GSS_Preferred_Phone_Number__c='00000',GSS_Country__c='Brazil',Count_Comments__c=3,
                             Description='Testing-PP-17997-1',AccountId= listAccounts[1].Id,RecordTypeId = recTypeIdCase2);
        listCase.add(testCase1);
     
        insert listCase;
         
        
        
        Test.stopTest();
        
    }
    public static testMethod void  BI_ClassifyCasesByRecordTypetest()
    {
        setUpData();
        
        Test.startTest();  
       
      
        List<Case> listCase = new List<Case>();
  
         testCase2 = new Case(Origin='Email',GSS_Preferred_Method_of_Contact__c='Email',Priority='1 - Critical',
                             GSS_Problem_Category__c='OS',GSS_Support_Level__c='2',Status='New',Subject ='Testing2', GSS_Support_Customer_Region__c ='APJ',GSS_Additional_Emails__c='test@gmail.com',Region_First_Response__c='NASA',RNV_Status__c='Active',GSS_Preferred_Phone_Number__c='00000',GSS_Country__c='Brazil',Description='Testing-PP-17997-1',AccountId= listAccounts[0].Id,RecordTypeId=Schema.SObjectType.Case.getRecordTypeInfosByName().get('PSO').getRecordTypeId());
        listCase.add(testCase2); 
                       
        
      
        
        testCase5 = new Case(Origin='Email',GSS_Preferred_Method_of_Contact__c='Email',Priority='1 - Critical',
                             GSS_Problem_Category__c='OS',GSS_Support_Level__c='2',Status='New',Subject ='Testing5', GSS_Support_Customer_Region__c ='APJ',GSS_Additional_Emails__c='test@gmail.com',Region_First_Response__c='NASA',RNV_Status__c='Active',GSS_Preferred_Phone_Number__c='00000',GSS_Country__c='Brazil',
                             Description='Testing-PP-17997-1',AccountId= listAccounts[0].Id,RecordTypeId = myVmwareRTITSup);
        listCase.add(testCase5);
        
        insert listCase;
        testCase5.status='New';
        
        update listCase;
            
        Test.stopTest();
    }
   
   public static testMethod void  BI_PopulateTechnicalContacttest()
    {
        setUpData();
        Test.startTest();  
        List<Case> listCase = new List<Case>();
        testCase1 = new Case(Origin='Email',GSS_Preferred_Method_of_Contact__c='Email',Priority='1 - Critical',
                             GSS_Problem_Category__c='OS',GSS_Support_Level__c='2',Status='New',Subject ='Testing1', GSS_Support_Customer_Region__c ='APJ',GSS_Additional_Emails__c='test@gmail.com',Region_First_Response__c='NASA',RNV_Status__c='Active',GSS_Preferred_Phone_Number__c='00000',GSS_Country__c='Brazil',Count_Comments__c=3,
                             Description='Testing-PP-17997-1',AccountId= listAccounts[1].Id,RecordTypeId = recTypeIdCase2);
        listCase.add(testCase1);
     
        
        testCase2 = new Case(Origin='Phone',GSS_Preferred_Method_of_Contact__c='Phone',Priority='1 - Critical', 
                            GSS_Problem_Category__c='OS',GSS_Support_Level__c='2',Status='New',Subject ='Testing2', GSS_Support_Customer_Region__c ='APJ',GSS_Additional_Emails__c='test@gmail.com',Region_First_Response__c='NASA',RNV_Status__c='Complete',
                           GSS_Country__c='Brazil', Description='Testing-PP-17997-2',ContactId = listContacts[0].Id, RecordTypeId = techSupport ,IT_Track__c='MDM',Technical_Contact_Name__c=null,Technical_Contact_Phone__c=null,Technical_Contact_Email__c=null,GSS_Preferred_Phone_Number__c='0000000' );
        listCase.add(testCase2);
        

        insert listCase;
        testCase1.Count_Comments__c=6;
      
        testCase1.OwnerId = u.Id;
        update  listCase;

        Test.stopTest();
    }
    public static testMethod void AI_ClassifyCasesByRecordTypetest()
    {
        setUpData();
    
        Test.startTest(); 
          List<Case> listCase = new List<Case>();
     
          testCase2 = new Case(Origin='Phone',GSS_Preferred_Method_of_Contact__c='Phone',Priority='1 - Critical', 
                            GSS_Problem_Category__c='OS',GSS_Support_Level__c='2',Status='New',Subject ='Testing2', GSS_Support_Customer_Region__c ='APJ',GSS_Additional_Emails__c='test@gmail.com',Region_First_Response__c='NASA',RNV_Status__c='Complete',
                           GSS_Country__c='India', Description='Testing-PP-17997-2',ContactId = listContacts[0].Id, RecordTypeId = techSupport ,IT_Track__c='MDM',Technical_Contact_Name__c=null,Technical_Contact_Phone__c=null,Technical_Contact_Email__c=null,GSS_Preferred_Phone_Number__c='0000000' );
        listCase.add(testCase2);
        
        insert listCase;

        Test.stopTest();
    }
   public static testMethod void  AI_AcctConSyncAndAvayaFuturetest()
    {
      string flag='false';
        setUpData();
          Test.startTest(); 
          List<Case> listCase = new List<Case>();
        testCase1 = new Case(Origin='Email',GSS_Preferred_Method_of_Contact__c='Email',Priority='1 - Critical',
                             GSS_Problem_Category__c='OS',GSS_Support_Level__c='2',Status='Escalated',Subject ='Testing1', GSS_Support_Customer_Region__c ='APJ',IT_Track__c='MDM',GSS_Additional_Emails__c='test@gmail.com',Region_First_Response__c='NASA',RNV_Status__c='Escalated',GSS_Preferred_Phone_Number__c='00000',GSS_Country__c='Brazil',Count_Comments__c=3,
                             Description='Testing-PP-17997-1',AccountId= listAccounts[1].Id,RecordTypeId = recTypeIdCase);
        listCase.add(testCase1);
        
          testCase4 = new Case(Origin='Email',GSS_Preferred_Method_of_Contact__c='Email',Priority='1 - Critical',               
                             GSS_Problem_Category__c='OS',GSS_Support_Level__c='2',Status='Escalated',Subject ='Testing4', GSS_Support_Customer_Region__c ='APJ',IT_Track__c='MDM',GSS_Additional_Emails__c='test@gmail.com',Region_First_Response__c='NASA',RNV_Status__c='Escalated',GSS_Preferred_Phone_Number__c='00000',GSS_Country__c='Brazil',
                             Description='Testing-PP-17997-1',AccountId= listAccounts[0].Id,RecordTypeId = myVmwareRTCommon);
        listCase.add(testCase4);
        
        testCase5 = new Case(Origin='Email',GSS_Preferred_Method_of_Contact__c='Email',Priority='1 - Critical',
                             GSS_Problem_Category__c='OS',GSS_Support_Level__c='2',Status='New',Subject ='Testing5', GSS_Support_Customer_Region__c ='APJ',IT_Track__c='MDM',GSS_Additional_Emails__c='test@gmail.com',Region_First_Response__c='NASA',RNV_Status__c='Escalated',GSS_Preferred_Phone_Number__c='00000',GSS_Country__c='Brazil',
                             Description='Testing-PP-17997-1',AccountId= listAccounts[0].Id,RecordTypeId = myVmwareRTITSup);
        listCase.add(testCase5);
        
        insert listCase;       
        testCase4.Status='New';           
        update listCase;
       
        
        Test.stopTest();
    }
     public void calculateCasePhoneQtest()
     {
       setUpData();
        
        Test.startTest();  
         Id CSR = (Id)(Profile_Name_Mapping__c.getInstance('Profile - 150').Profile_Id__c);
         
         u2 = new User(Alias = 'alias',email='standarduser2@testorg.com',emailencodingkey='UTF-8',Username = 'someuser2somedomain.com',
                Lastname = 'somelastname2',languagelocalekey='en_US',localesidkey='en_US',timezonesidkey='America/Los_Angeles',CommunityNickname = 'somecommunitynickname2',
                profileid =CSR , country='United States',ContactId = listContacts[0].Id);
         insert(u2);
         
        List<Case> listCase = new List<Case>();
        
   
         testCase2 = new Case(Origin='Phone',GSS_Preferred_Method_of_Contact__c='Phone',Priority='1 - Critical',GSS_Center__c='Bangalore',
                            GSS_Problem_Category__c='OS',GSS_Support_Level__c='2',Status='New',Subject ='Testing2', GSS_Support_Customer_Region__c ='APJ',GSS_Additional_Emails__c='test@gmail.com',Region_First_Response__c='NASA',RNV_Status__c='Complete',
                           GSS_Country__c='Brazil', Description='Testing-PP-17997-2',ContactId = listContacts[0].Id, RecordTypeId = techSupport ,IT_Track__c='MDM',Technical_Contact_Name__c=null,Technical_Contact_Phone__c=null,Technical_Contact_Email__c=null,GSS_Preferred_Phone_Number__c='0000000' );
        listCase.add(testCase2);
        
        testCase5 = new Case(Origin='Email',GSS_Preferred_Method_of_Contact__c='Email',Priority='1 - Critical',Actual_Response_Time__c=null,
                             GSS_Problem_Category__c='OS',GSS_Support_Level__c='2',Status='New',Subject ='Testing5', GSS_Support_Customer_Region__c ='APJ',IT_Track__c='MDM',GSS_Additional_Emails__c='test@gmail.com',Region_First_Response__c='NASA',RNV_Status__c='Escalated',GSS_Preferred_Phone_Number__c='00000',GSS_Country__c='Brazil',
                             Description='Testing-PP-17997-1',AccountId= listAccounts[0].Id,RecordTypeId = myVmwareRTITSup);
        listCase.add(testCase5);
        
        insert listCase;

         Test.stopTest();
     }
     public static testmethod void TA_CreateEmailTasktest()
     {
         setUpData();
        Test.startTest();  
         
        
        List<Case> listCase = new List<Case>();
        testCase1 = new Case(Origin='Email',GSS_Preferred_Method_of_Contact__c='Email',Priority='1 - Critical',
                             GSS_Problem_Category__c='OS',GSS_Support_Level__c='2',Status='New',Subject ='Testing1', GSS_Support_Customer_Region__c ='APJ',GSS_Additional_Emails__c='test@gmail.com',Region_First_Response__c='NASA',RNV_Status__c='New',GSS_Preferred_Phone_Number__c='00000',GSS_Country__c='India',Count_Comments__c=3,
                             Description='Testing-PP-17997-1',AccountId= listAccounts[1].Id,RecordTypeId =Case_PN_RecordType);
        listCase.add(testCase1);
        
        testCase2 = new Case(Origin='Email',GSS_Preferred_Method_of_Contact__c='Email',Priority='1 - Critical',
                             GSS_Problem_Category__c='OS',GSS_Support_Level__c='2',Status='Escalated',Subject ='Testing2', GSS_Support_Customer_Region__c ='APJ',GSS_Additional_Emails__c='test@gmail.com',Region_First_Response__c='NASA',RNV_Status__c='New',GSS_Preferred_Phone_Number__c='00000',GSS_Country__c='India',Count_Comments__c=3,
                             Description='Testing-PP-17997-1',AccountId= listAccounts[1].Id,RecordTypeId =Case_PN_RecordType);
        listCase.add(testCase2);
        
         testCase3 = new Case(Origin='Email',GSS_Preferred_Method_of_Contact__c='Email',Priority='1 - Critical',
                             GSS_Problem_Category__c='OS',GSS_Support_Level__c='2',Status='New',Subject ='Testing3', GSS_Support_Customer_Region__c ='APJ',GSS_Additional_Emails__c='test@gmail.com',Region_First_Response__c='NASA',RNV_Status__c='New',GSS_Preferred_Phone_Number__c='00000',GSS_Country__c='India',Count_Comments__c=3,
                             Description='Testing-PP-17997-1',AccountId= listAccounts[1].Id,RecordTypeId =Case_PN_RecordType);
        listCase.add(testCase3);
        
       
        
        
     
        insert listCase;
       
        testCase1.Status='In Progress';
        testCase2.Status='New';
        testCase3.Status='Escalated';
      
        update listCase;
                 
        
        Test.stopTest();  
     
     }
     public static testmethod void beforeUpdateCaseInitializationtest()
     {
         setUpdata();
         test.starttest();
                 List<Case> listCase = new List<Case>();
          
       
          
         testCase4 = new Case(Origin='Email',GSS_Preferred_Method_of_Contact__c='Email',Priority='1 - Critical',
                             GSS_Problem_Category__c='OS',GSS_Support_Level__c='2',Status='New',Subject ='Testing4', GSS_Support_Customer_Region__c ='APJ',IT_Track__c='MDM',GSS_Additional_Emails__c='test@gmail.com',Region_First_Response__c='NASA',RNV_Status__c='Escalated',GSS_Preferred_Phone_Number__c='00000',GSS_Country__c='India',
                             Description='Testing-PP-17997-1',AccountId= listAccounts[0].Id,RecordTypeId = myVmwareRTCommon);
        listCase.add(testCase4);
        
        testCase5 = new Case(Origin='Email',GSS_Preferred_Method_of_Contact__c='Email',Priority='1 - Critical',Defect__c='###',Severity__c='S4',Count_Comments__c=1,
                             GSS_Problem_Category__c='OS',GSS_Support_Level__c='2',Status='New',Subject ='Testing5', GSS_Support_Customer_Region__c ='APJ',IT_Track__c='MDM',GSS_Additional_Emails__c='test@gmail.com',Region_First_Response__c='NASA',RNV_Status__c='Escalated',GSS_Preferred_Phone_Number__c='00000',GSS_Country__c='India',
                             Description='Testing-PP-17997-1',AccountId= listAccounts[0].Id,RecordTypeId = myVmwareRTITSup);
        listCase.add(testCase5);
        
        insert listCase; 
       
        testCase5.Count_Comments__c=2;
        testCase5.status='In Progress';
        testCase5.Defect__c='@@@';       
        testCase4.RecordTypeId =myVmwareRTITSup;
       
        //update listCase;
           
         test.stoptest();
     }
     
      public static testmethod void updateRelatedListCounttest(){
          test.starttest();
         setUpdata();
        
          List<Case> listCase = new List<Case>();
          
         testCase1 = new Case(Origin='Email',GSS_Preferred_Method_of_Contact__c='Email',Priority='1 - Critical',
                             GSS_Problem_Category__c='OS',GSS_Support_Level__c='2',Status='New',Subject ='Testing1', GSS_Support_Customer_Region__c ='APJ',GSS_Additional_Emails__c='test@gmail.com',Region_First_Response__c='NASA',RNV_Status__c='Active',GSS_Preferred_Phone_Number__c='00000',GSS_Country__c='Brazil',Description='Testing-PP-17997-1',AccountId= listAccounts[0].Id,RecordTypeId=carpathiaRecType,ContactId=listContacts[0].Id);
            listCase.add(testCase1); 
         testCase4 = new Case(Origin='Email',GSS_Preferred_Method_of_Contact__c='Email',Priority='1 - Critical',
                             GSS_Problem_Category__c='OS',GSS_Support_Level__c='2',Status='New',Subject ='Testing4', GSS_Support_Customer_Region__c ='APJ',IT_Track__c='MDM',GSS_Additional_Emails__c='test@gmail.com',Region_First_Response__c='NASA',RNV_Status__c='Escalated',GSS_Preferred_Phone_Number__c='00000',GSS_Country__c='India',
                             Description='Testing-PP-17997-1',AccountId= listAccounts[0].Id,RecordTypeId = myVmwareRTCommon);
        listCase.add(testCase4);
        
      
        insert listCase;
        testCase1.AccountId=listAccounts[1].Id;         
        update testCase1;
        
        
        test.stoptest();
        
        List<Case> oldlistCase=new List<Case>([select id,ParentId from case where ParentId!=null limit 1]);
        CaseProcessing Cp=new CaseProcessing();
        Cp.updateRelatedListCount(listCase,oldlistCase);
       
         
    
}
}