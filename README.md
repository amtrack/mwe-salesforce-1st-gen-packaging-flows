# mwe-salesforce-1st-gen-packaging-flows

> Minimal working example to demonstrate that flows are not automatically being added to a (managed/unmanaged) 1st generation package

## Dev, Build and Test

1. Create a Developer Edition
2. Login to the Developer Edition using `sfdx force:auth:web:login -a developer-edition-flow-test`

## Deploy the (un)managed package to create/update the package in the Developer Edition

```
fullName="unman_package47" ./release.sh src
sfdx force:mdapi:deploy -d src -w 120 -u developer-edition-flow-test
```

## Description of Files and Directories

1. Flow (Process Builder): This should be supported with API version 44.0
2. ApexPage: Just another Metadata Component for demonstration

## Issues

The `ApexPage` is being added to the Package as expected.
However the `Flow` is not being added automatically.
