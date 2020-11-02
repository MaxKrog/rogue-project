
# Rogue project
Welcome to this Rogue Project. It will be moved to a more private place soon.

All datatransformation (from raw to analysis & report-ready data) happening inside BigQuery is defined inside this project.


## Prerequisites:

- **Python 3.7.5 (other version above 3.6 most probably works)**
- Understanding of the terminal
- Understanding of virtual environments in Python
- Basic understanding of DBT.

If you're new to DBT, walk through this guide to get a basic understanding before jumping into this project:
https://docs.getdbt.com/tutorial/setting-up/

For an introduction to virtual environments and some opinions on how your local environment should be set up. Please see this post:
https://medium.com/@maxkrog/my-local-environment-setup-for-data-engineering-on-gcp-5611e78aa28

## Local setup:

There's three parts to setting up this project locally:
1. Cloning the repo to a local folder
2. Setting up your dbt profile in ~/.dbt/profiles.yml
3. Local project setup

More on these three setups below.

#### 1. Cloning the repo
The first part of setting up this project locally is to clone the repo.
Inside your terminal, navigate to a suitable parent folder and execute:

    git clone https://github.com/MaxKrog/rogue-project.git
    cd rogue-project #You are now inside the project folder

#### 2. DBT Profile
The second part of setting up this project locally is to provide your own dbt-profile to be used by the project. Your DBT profile should be put in ~/.dbt/profiles.yml

An example file named 'profiles.yml.example' exists in the root of this project.

To initialize it:
1. Copy the example profile to ~/.dbt/profiles.yml
2. Update the keyfile variable to point to a service account json key

For more information on setting up your DBT-profile, see this post:
https://docs.getdbt.com/dbt-cli/configure-your-profile/

#### 3. Local project setup
This assumes some knowledge about virtual environments (venv).
More info about venv can be found here: https://docs.python.org/3/tutorial/venv.html

If you've used a venv/DBT project before and just need a quickstart, these are the steps to follow from your terminal. Make sure your terminal is in the root folder of this project before executing the commands.

    python -m venv venv                 # Creates a folder 'venv'
    source venv/bin/activate            # Jumps inside the virtual environment

    pip install -r requirements.txt     # Installs relevant packages (dbt) to the virtualenvironment
    dbt deps 							#Fetches dbt dependencies defined in packages.yml

    ...do work...

    deactivate                          # Deactivates (takes you out of) the virtual environment

Note that when you've left (deactivated) the venv and want to enter it again, you do not need to install pip packages again. They are saved in the venv-folder.


## Working in the project

#### DBT - Referencing tables

There's two ways to reference another table within DBT.

    from {{ source('linkedin','account_history') }} # References a table defined in a "source.yml" file.

    from {{ ref('stg_linkedin__ad_analytics_by_creative') }} # References a table by SQL-file name inside the DBT project.


#### Fivetran - Linkedin Ads
Fivetran replicates the tables available via Linkedins API to tables in the dataset **ingestion_fivetran_linkedin_ads**

For an ERD of the tables replicated, see this link:
https://docs.google.com/presentation/d/1nwR5efra1p3S1uOwUgU9Wdx7WBKXE7onxNDffK0IpgM/edit#slide=id.g311502b468_5_443

Staging view are built from these relational tables in the "linkedin_source" models


#### Some useful DBT commands:
    dbt deps 	# Fetches dbt dependencies from dbt-hub to the folder dbt_modules
    dbt clean 	# Cleans folder defined as "clean-targets" in dbt_project.yml

    dbt run 	# Runs all models defined in /models
    dbt run --models=linkedin_source.stg_linkedin__account_history #Runs one specific model
    dbt run --models=linkedin_source #Runs models in "linkedin_source" folder

    dbt compile # Compiles transformations inside "analysis"-folder. Outputs are saved in ./target/compiled/valtech_connecting_the_dots/analysis




### DBT Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](http://slack.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
