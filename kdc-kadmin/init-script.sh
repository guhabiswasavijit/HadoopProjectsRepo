#!/bin/bash
echo "==================================================================================="
echo "==== Kerberos KDC and Kadmin ======================================================"
echo "==================================================================================="
KADMIN_PRINCIPAL_FULL=$KADMIN_PRINCIPAL@$REALM

echo "REALM: $REALM"
echo "KADMIN_PRINCIPAL_FULL: $KADMIN_PRINCIPAL_FULL"
echo "KADMIN_PASSWORD: $KADMIN_PASSWORD"
echo ""

echo "==================================================================================="
echo "==== /etc/krb5.conf ==============================================================="
echo "==================================================================================="
KDC_KADMIN_SERVER=$(hostname -f)
tee /etc/krb5.conf <<EOF
[libdefaults]
	default_realm = $REALM

[realms]
	$REALM = {
		kdc_ports = 88,750
		kadmind_port = 749
		kdc = $KDC_KADMIN_SERVER
		admin_server = $KDC_KADMIN_SERVER
	}
EOF
echo ""

echo "==================================================================================="
echo "==== /etc/krb5kdc/kdc.conf ========================================================"
echo "==================================================================================="
tee /etc/krb5kdc/kdc.conf <<EOF
[realms]
	$REALM = {
		acl_file = /etc/krb5kdc/kadm5.acl
		max_renewable_life = 7d 0h 0m 0s
		supported_enctypes = $SUPPORTED_ENCRYPTION_TYPES
		default_principal_flags = +preauth
		auth_to_local = RULE:[2:$1]([nds]n)s/^.*$/hdfs/
		auth_to_local = RULE:[2:$1](HTTP)s/^.*$/hdfs/
		auth_to_local = DEFAULT
	}
EOF
echo ""

echo "==================================================================================="
echo "==== /etc/krb5kdc/kadm5.acl ======================================================="
echo "==================================================================================="
tee /etc/krb5kdc/kadm5.acl <<EOF
$KADMIN_PRINCIPAL_FULL *
nn/namenode@EXAMPLE.COM *
HTTP/namenode@EXAMPLE.COM * 
sn/namenode@EXAMPLE.COM * 
dn/datanode@EXAMPLE.COM * 
noPermissions@$REALM X
EOF
echo ""

echo "==================================================================================="
echo "==== Creating realm ==============================================================="
echo "==================================================================================="
MASTER_PASSWORD=$MASTER_PASSWORD_EXAMPLE_REALM
# This command also starts the krb5-kdc and krb5-admin-server services
krb5_newrealm <<EOF
$MASTER_PASSWORD
$MASTER_PASSWORD
EOF
echo ""

echo "==================================================================================="
echo "==== Create the principals in the acl ============================================="
echo "==================================================================================="
echo "Adding $KADMIN_PRINCIPAL principal"
kadmin.local -q "delete_principal -force $KADMIN_PRINCIPAL_FULL"
echo ""
kadmin.local -q "addprinc -pw $KADMIN_PASSWORD $KADMIN_PRINCIPAL_FULL"
kadmin.local -q "addprinc -pw $MASTER_PASSWORD nn/namenode@EXAMPLE.COM"
kadmin.local -q "addprinc -pw $MASTER_PASSWORD HTTP/namenode@EXAMPLE.COM"
kadmin.local -q "addprinc -pw $MASTER_PASSWORD sn/namenode@EXAMPLE.COM"
kadmin.local -q "addprinc -pw $MASTER_PASSWORD dn/datanode@EXAMPLE.COM"
kadmin.local -q "addprinc -pw $MASTER_PASSWORD HTTP/kms-server@EXAMPLE.COM"
kadmin.local -q "addprinc -pw $MASTER_PASSWORD kms/zookeeper-server@EXAMPLE.COM"
echo ""

echo "Adding noPermissions principal"
kadmin.local -q "delete_principal -force noPermissions@$REALM"
echo ""
kadmin.local -q "addprinc -pw $KADMIN_PASSWORD noPermissions@$REALM"
echo ""

echo "==================================================================================="
echo "==== Run the services ============================================================="
echo "==================================================================================="
# We want the container to keep running until we explicitly kill it.
# So the last command cannot immediately exit. See
#   https://docs.docker.com/engine/reference/run/#detached-vs-foreground
# for a better explanation.

krb5kdc
kadmind -nofork