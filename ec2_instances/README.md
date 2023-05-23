### Authentication 

For authentication with AWS, use the following command. 
```bash
$ aws configure
```
To update your AWS authentication on Linux, you can modify the `~/.aws/credentials` file if you're already logged in.

After this you can use this template to spin up ec2 instances. 

### Examples 
```bash
# create 3 instances 
$ terraform apply -auto-approve --var instance_count=3
```
If you want to get the `ssh` details then use 

```bash
$ terraform output
```

For other parameters you can look at `variables.tf` file.