@RestResource(urlMapping='/fetchallaccount')


global class AccountController{

@HttpGet
global static List<Account>queryAllAcciunts(){

return [select id,name,phone,type from account limit 10];

}

}