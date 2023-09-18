
# RDS Mysql 

Configurations:
1. Provisioned via terraform
2. MySQL version 5.7.41
3. The database is created in EKS VPC in a private subnet
4. The database has its own security group
5. Modules were used to create the database.
6. Database is customizable via variables in dev.tfvars/prod.tfvars files.
7. Automation creation of random passwords for the database.
8. Implemented best practices. 
---
### DB Structure
|CONFIGURATION| DEV ACCOUNT                      | PROD ACCOUNT |
| ------ | ------ |------ |
|Backup config section, enable backups  | OFF   |     ON
|Performance Insights enabled            | OFF   |     OFF
|Multi-AZ                            	 | OFF   |     ON
|Deletion protection                  	 | OFF   |     ON
|Final_snapshot                   		 | OFF   |     ON
|Copy tags to snapshot                   | OFF   |     ON
|Storage. Encryption                    | OFF   |     ON
|IAM DB authentication                   | OFF   |     ON
|CloudWatch Logs                         | OFF   |     ON
|Storage autoscaling                     | ON    |     ON
|Create random password for db             | ON    |     ON
___

###  Installation
- Run `terraform apply --auto-approve`
- Make sure that everything is set up correctly:

- Install mysql on EC2 in same VPC and run:  `mysql -h <AWS DNS endpoint> -u<name> -p<password> -P <port number>`
- In the DB run: SHOW DATABASES;

You should see the following output:

>mysql SHOW DATABASES;    <br />
\+--------------------+   <br />
\| Database           \|<br />
\+--------------------+<br />
\| information_schema \|<br />
\| innodb             \|<br />
\| mysql              \|<br />
\| performance_schema \|<br />
\| sampledb           \|<br />
\| sys                \|<br />
\+--------------------+<br />
6 rows in set (0.00 sec)<br />

Also you can check it through K8s:

- Log in your cluster
- Create Service:
 
<pre>
apiVersion: v1                          <br />
kind: Service                          <br />
metadata:                            <br />
  name: psql-rds                    <br />
spec:                                <br />
  externalName: <\AWS DNS endpoint>   <br />
  ports:                              <br />
    - port:  <\port number>   <br />
    protocol: TCP                          <br />
    targetPort: <\port number>                <br />
  sessionAffinity: None                      <br />
  type: ExternalName                              <br />
    </pre>
    
- Run `kubectl apply -f  <filename>.yml`
- Insert, customize and run the following command: 
`kubectl run -it --rm --image=mysql:5.7.41 --restart=Never mysql-client -- mysql -h <AWS DNS endpoint> -u<name> -p<password> -P <port number>`
 
It will create a test pod that lives while connected to DB and will be terminated automatically when logged out. 

- In the DB run: SHOW DATABASES;
You should see:

>mysql SHOW DATABASES;    <br />
\+--------------------+   <br />
\| Database           \|<br />
\+--------------------+<br />
\| information_schema \|<br />
\| innodb             \|<br />
\| mysql              \|<br />
\| performance_schema \|<br />
\| sampledb           \|<br />
\| sys                \|<br />
\+--------------------+<br />
6 rows in set (0.00 sec)<br />
___

### Addition information section.
[Terraform — Best Practices](https://developer.hashicorp.com/terraform)

[Terraform: A Comprehensive Guide](https://saturncloud.io/blog/terraform-a-comprehensive-guide-to-using-tfvars-with-modules/#:~:text=In%20your%20tfvars%20file,%20define,defined%20in%20your%20module%20configuration.&text=Now,%20you%20can%20use%20the,variables%20using%20the%20var%20keyword.&text=Finally,%20apply%20the%20configuration%20using%20the%20terraform%20apply%20command.)

[AWS RDS MYSQL - Best Practices](https://www.trendmicro.com/cloudoneconformity/knowledge-base/aws/RDS/)

Information on how you can keep secrets and how to manage them in Terraform. [Link](https://automateinfra.com/2021/03/24/how-to-create-secrets-in-aws-secrets-manager-using-terraform-in-amazon-account/)

 
