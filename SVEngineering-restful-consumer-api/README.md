# RESTful Consumer API
## Description

RESTful API Built on a foundation of [NestJs](https://github.com/nestjs/nest) and [TypeOrm](https://typeorm.io/#/).

## Prerequisites
* [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
* [Vagrant](https://www.vagrantup.com/)

> Note: This repository requires passing Linter and Unit Tests before committing and pushing respectively. This is achieved with [Husky](https://www.npmjs.com/package/husky) integration with `package.json`

## Spinning up virtual environment

```bash
$ vagrant up
```
> Note: This takes *a while* and will produce some benign red-text messages.

```bash
$ vagrant ssh
```

> IMPORTANT: There is a `.env.example` file that will be copied to a local, untracked `.env` file when the VM spins up for the first time. *You must fill in your AWS credentials here* for the application to be able to connect to AWS services. This file is never tracked and is not used in deployed environments.

## Running the app
The application lives in `/var/www`, a mounted virtual drive to the local file system. The code within this repository is mounted in that directory at startup (see `vagrantfile` for volume definitions).

```bash
$ npm run start:dev
```
Endpoint URL: `http://192.168.xxx.xxx:3000{route}` (see `vagrantfile` for IP address)
Once the application is running it can be accessed with utilities like Postman or the Swagger documentation to simulate requests.

> NOTE: For easy access it's recommended to add an entry to the local `/etc/hosts` of the host machine that points to the `192.168.xxx.xxx` IP address of the VM at an address like `sportsvisio-api.local`

## Models (entities) and Migrations
This application uses [Migrations](https://typeorm.io/#/migrations) to manage the schema of the relational database. On each start the application will attempt to run any migrations in the `/migrations` folder, and seeds in the `/seeds` folder that have not already been run and registered in the `seeds` table. Every entity / model in the application has a `*.entity.ts` naming pattern. 

> IMPORTANT: You *cannot* just modify a `*.entity.ts` file and expect the database to update. See below for modification procedure.

### Modifying Models
Migrations are generated using the TypeOrm CLI via `package.json` script `npm run migrations:generate`, and a new migration file is created containing all necessary query modifications to match local entities. If a model needs to be updated, follow this procedure:

* Modify `.entity.ts` file as needed
* Run generation script: `npm run migrations:generate`
* Validate contents of new migration file in `/migrations`
* Validate local databse reflects desired changes

#### Undoing a migration
If a migration has been generated / run and additional changes are needed, you must *run the `npm run migrations:revert` script* to revert the latest run migration, then the generated migration file in `/migrations` needs to be deleted. Afterward the database will be back in the unchanged state and the process of modifying models / generating a migration can be started again.

> NOTE: Minimize migrations as much as possible

## Test

```bash
# unit tests
$ npm run test
```

## Documentation

The API is documented with [Swagger](https://swagger.io/) using TypeScript decorators in the code. 
To view the documentation and simulate API requests, *start the app in standalone mode* and once running visit the `/swagger` route.

`http://192.168.xxx.xxx:3000/swagger`
