default['firewalld']['internal']['services'] = []
default['firewalld']['internal']['ports'] = []
default['firewalld']['public']['services'] = [ 'http', 'https', 'ssh' ]
default['firewalld']['public']['ports'] = [ '8080', '3000', '3306' ]