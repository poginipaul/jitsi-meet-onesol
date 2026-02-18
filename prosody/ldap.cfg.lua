-- LDAP authentication config
authentication = "ldap2"

ldap = {
    hostname = "srv-b1.onesolutions.net",
    bind_dn = "CN=administrator,OU=ServiceAccounts,DC=onesolutions,DC=net",
    bind_password = "YourServiceAccountPassword",
    user_base = "DC=onesolutions,DC=net",
    filter = "(sAMAccountName=%u)",
    use_tls = true,
    tls_verify = "none"
}
