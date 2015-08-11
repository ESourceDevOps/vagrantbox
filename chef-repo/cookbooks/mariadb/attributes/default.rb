#
# Cookbook Name:: mariadb
# Attributes:: default
#
# Copyright 2015, E Source Companies, LLC
#

# The main mysql directory.
default['mysql']['maindir'] = '/esource/mysql'
default['mysql']['group'] = 'mysql'

# Directories required to run MariaDB.
default['mysql']['directories'] = [
	'/esource/mysql',
	'/esource/mysqltmp',
	'/esource/mysql/data',
	'/esource/mysql/binlogs',
	'/esource/mysql/admin',
	'/esource/mysql/innologs'
]

default['mysql']['extra_packages'] = [
  'MariaDB-devel',
  'postgresql-libs',
  'postgresql-devel'
]

# Client #
default['mysql']['client']['port'] = 3306
default['mysql']['client']['socket'] = '/var/lib/mysql/mysql.sock'

# General #
default['mysql']['user'] = 'mysql'
default['mysql']['default-storage-engine'] = 'InnoDB'
default['mysql']['socket'] = '/var/lib/mysql/mysql.sock'
default['mysql']['pid-file'] = '/var/lib/mysql/mysql.pid'
default['mysql']['bind-address'] = '0.0.0.0'
default['mysql']['sql-mode'] = 'NO_ENGINE_SUBSTITUTION,TRADITIONAL'

# MyISAM #
default['mysql']['key-buffer-size'] = '4K'
default['mysql']['myisam-recover'] = 'FORCE,BACKUP'

# SAFETY #
default['mysql']['max-allowed-packet'] = '16M'
default['mysql']['max-connect-errors'] = 1000000

# DATA STORAGE #
default['mysql']['datadir'] = '/esource/mysql/data'

# BINARY LOGGING #
default['mysql']['log-bin'] = '/esource/mysql/binlogs/mysql-bin'
default['mysql']['expire-logs-days'] = 14
default['mysql']['sync-binlog'] = 1
default['mysql']['binlog-format'] = 'MIXED'

# CACHES AND LIMITS #
default['mysql']['tmp-table-size'] = '32M'
default['mysql']['max-heap-table-size'] = '32M'
default['mysql']['query-cache-type'] = 0
default['mysql']['query-cache-size'] = 0
default['mysql']['max-connections'] = 500
default['mysql']['thread-cache-size'] = 286
default['mysql']['open-files-limit'] = 65535
default['mysql']['table-definition-cache'] = 4096
default['mysql']['table-open-cache'] = 10240

# INNODB #
default['mysql']['innodb-flush-method'] = 'O_DIRECT'
default['mysql']['innodb-log-files-in-group'] = 2
default['mysql']['innodb-log-group-home-dir'] = '/esource/mysql/innologs'
default['mysql']['innodb-log-file-size'] = '256M'
default['mysql']['innodb-flush-log-at-trx-commit'] = 1
default['mysql']['innodb-file-per-table'] = 1

#default['mysql']['innodb-buffer-pool-size'] = '2048M'
default['mysql']['innodb-buffer-pool-size'] = '512M'

# LOGGING #
default['mysql']['log-error'] = '/esource/mysql/admin/mysql-error.log'
default['mysql']['log-queries-not-using-indexes'] = 0
default['mysql']['slow-query-log'] = 1
default['mysql']['slow-query-log-file'] = '/esource/mysql/admin/mysql-slow.log'
default['mysql']['long-query-time'] = 1
