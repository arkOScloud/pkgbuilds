daemonize = true
pidfile = "/run/prosody/prosody.pid"
admins = { }

modules_enabled = {
		"roster";
		"saslauth";
		"tls";
		"dialback";
		"disco";
		"private";
		"vcard";
		"version";
		"uptime";
		"time";
		"ping";
		"pep";
		"register";
		"admin_adhoc";
		"posix";
};

allow_registration = false;

ssl = {
	options = {
    	"no_sslv2",
    	"no_sslv3",
    	"no_ticket",
    	"no_compression",
    	"cipher_server_preference"
	};
}

storage = "ldap"

log = {
	"*syslog";
}

Include "conf.d/*.cfg.lua"
