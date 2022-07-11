// запуск terraform команд в cloud
/*
-Хорошо для большой команды Cloud Engineers
-Удаленный запуск terraform plan,apply,destroy
-Интеграция с VCS типа GitHub,BitBucket
-Хранение remote state
-Registry для ваших Terraform Modules
-Оповещения в Slack,Email,Webhook
-Различные уровни доступа для ваших пользователей
-Sentinel Policies - полисы и правила поднятия инфраструктуры 
-Cost Estimation -  определение стоимости инфраструктуры, которую вы собираетесь поднять,
можно использовать вместе с Sentinel Policy чтобы запретить или предупредить елси стоимость превысит указанную вами.
*/

// account in terraform.io --> app.terraform.io  --> create organization --> create workspace(connect to github) workspace - то с каким
// репозиторием будем работать
/*
Configure variables ( terraform variables...envioronment variables--> AWS_ACCESS_KEY_ID...AWS_SECRET_ACCESS_KEY...AWS_DEFAULT_REGION)

Queue plan --> terraform plan

triggered GitHub
triggered from Terraform Cloud UI

can be change --> terraform variables

Destruction and Deletion -> for destroy or delete workspace

*/

