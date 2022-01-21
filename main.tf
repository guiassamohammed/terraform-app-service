resource "azurerm_resource_group" "rg" {
  name =  "Mohammed"
  location =  var.location 
 
}

resource "azurerm_app_service_plan" "service" {
   name = "appserviceplan"
   resource_group_name = azurerm_resource_group.rg.name
   location = azurerm_resource_group.rg.location
  
   sku {

     tier = "Standard"
     size = "S1"
   }
   
}

resource "azurerm_app_service" "appservice" {
  name= "appservicemo15"
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  app_service_plan_id = azurerm_app_service_plan.service.id
   
   
   site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
  }

  app_settings = {
    "SOME_KEY" = "some-value"
  }  



 connection_string {
    name  = "Database"
    type  = "SQLAzure"
    value = "Server=tcp:azurerm_sql_server.sqlserver.fully_qualified_domain_name Database=azurerm_sql_database.db.name;User ID=azurerm_sql_server.sqlserver.administrator_login;Password=azurerm_sql_server.sqlserver.administrator_login_password;Trusted_Connection=False;Encrypt=True;"
  }

}


resource "azurerm_sql_server" "sqlserver" {
  name = "sqlsemohammed124"
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  version = "12.0"
  administrator_login =  "Mohammed"
  administrator_login_password =  "Bucharest2018*"  
}

resource "azurerm_sql_database" "db" {
  name = "data baseterra"
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  server_name = azurerm_sql_server.sqlserver.name
  
    
}
