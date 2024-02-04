#!/bin/bash

# Arguments
DomainName=$1
RemoteRepo=$2

# Replace domain name in index.html
sed -i -E "s/%DOMAINNAME%/$DomainName/g" /home/vanrohan/dev/domain-page/index.html

# Build site
cd /home/vanrohan/dev/domain-page/
yarn build

# Replace domain name in index.html back to template name
sed -i -E "s/$DomainName/%DOMAINNAME%/g" /home/vanrohan/dev/domain-page/index.html

# Copy site to deployment repo
cp -r /home/vanrohan/dev/domain-page/dist/* /home/vanrohan/dev/urban-palm-tree/

# Commit and push changes
cd /home/vanrohan/dev/urban-palm-tree/
echo $DomainName > CNAME
git commit -a * -m "Deploying $DomainName"
git commit -a -m "domain fix"
git push --force $RemoteRepo