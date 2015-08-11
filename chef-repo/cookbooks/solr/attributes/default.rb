#
# Cookbook Name:: solr
# Attributes:: default
#
# Copyright 2015, E Source Companies, LLC
#

default['solr']['download_url'] = 'https://googledrive.com/host/0B5KmyzksuKPHfkdiY3JjTmRUSzJBalpDU3RqSzk0RXhPb2J5T2hKUVA1WGdFbEtfbGxESTA/solr-5.2.1.tgz'
default['solr']['user'] = 'solr'
default['solr']['group'] = 'solr'
default['solr']['port'] = '8080'
default['solr']['datadir'] = '/esource/solr'
default['solr']['conf_files'] = [
    'solrcore.properties',
	'mapping-ISOLatin1Accent.txt',
	'protwords.txt',
    'stopwords.txt',
    'synonyms.txt',
    'elevate.xml',
	'schema.xml',
    'schema_extra_fields.xml',
    'schema_extra_types.xml',
    'solrconfig.xml',
    'solrconfig_extra.xml',
    'schema.xml',
	'solr.xml'
]
default['solr']['cores'] = [
	'drupal'
]