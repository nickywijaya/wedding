[![Coverage Status](https://coveralls.io/repos/github/nickywijaya/wedding/badge.svg?branch=main)](https://coveralls.io/github/nickywijaya/wedding?branch=main)

## Description
A repository to host a simple wedding invitation

## Owner
Vincentius Nicky

## Contact and On-Call Information
| Name    | Role  | Slack Name          | Phone          | Email                             |
| ------- | ----- | ------------------- | -------------- | --------------------------------- |
| Nicky   | FS    | Vincentius Nicky    | 0858 3997 6117 | vincentius.nicky@bukalapak.com    |

## Onboarding and Development Guide
#### Prerequisites
1. [Ruby](https://rvm.io/rvm/install)
2. [Rails](https://rubyonrails.org/)
3. [MySQL](https://www.mysql.com/)

#### Setup
1. clone repository
```
git clone https://github.com/nickywijaya/wedding.git

OR

git clone git@github.com:nickywijaya/wedding.git (using ssh key)
```

2. copy env.sample
```
cat env.sample > .env
```

3. update env config to your preference

4. create gemset
```
gem install bundler
bundle install
```

5. init databases
```
rake db:create
rake db:migrate
rake db:seed
```

6. run application
```
rails s
```
