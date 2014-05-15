include_recipe "subversion"
include_recipe "trac"
include_recipe "iptables"

iptables_rule "http"
iptables_rule "ssh"
