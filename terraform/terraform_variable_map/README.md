# Overview

This snippet is intended to demonstrate the use of a "map" variable to lookup an AWS AMI ID by region.

# Running:

Run `terraform apply`

# Expected Outcome

Expected outcome is similar to the below:

```
cjohnson06:terraform_variable_map cjohnson$ terraform apply

Apply complete! Resources: 0 added, 0 changed, 0 destroyed.

Outputs:

ami_id = AMI id for region us-west-2 is ami-73a6e20b
```
