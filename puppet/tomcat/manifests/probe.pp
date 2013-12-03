# Class: tomcat::probe
#
#   This class models the google psi-probe
#   service in Puppet.
#
#   https://code.google.com/p/psi-probe/
#
#   This management strategy is to deploy the war file
#   into ${TOMCAT_HOME:=/usr/tomcat}/webapps
#
#   The Assyrian <assyrian.py@gmail.com>
#   2013-12-03
#
# Parameters:
#
# Actions:
#
#   Manages /usr/tomcat/webapps/probe.war
#
# Requires:
#
#   Service["tomcat"], File["/usr/tomcat"]
#   which are provided by provided by class { "tomcat": }
#
# Sample Usage:
#
#   include "tomcat::probe"
#
class tomcat::probe {
	$module = "tomcat"
	$class  = "${module}::probe"
  $prefix = "/etc/puppet/modules"
# JJM Look for files on the node filesystem first.
  $p1 = "${prefix}/${module}/files"
# JJM Look for files on the puppetmaster second.
  $p2 = "puppet:///modules/${module}"
# Our installer media.
  $probe_version = "2.3.3"
  $installer = "probe-${probe_version}.war"

  File { owner => "0", group => "0", mode  => "0644" }

	file {
		"/usr/tomcat/webapps/probe.war":
      source  => [ "${p1}/${installer}", "${p2}/${installer}" ],
      require => File["/usr/tomcat"],
      before  => Class["${module}::service"],
      notify  => Service["tomcat"];
	}
}
# JJM EOF
