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

allow_registration = false
c2s_require_encryption = false
allow_unencrypted_plain_auth = false
s2s_allow_encryption = true
s2s_secure_auth = false
storage = "ldap"

log = {
	"*syslog";
}

Include "conf.d/*.cfg.lua"
