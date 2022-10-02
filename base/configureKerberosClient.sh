#!/bin/bash
echo "==================================================================================="
echo "==== Kerberos Client =============================================================="
echo "==================================================================================="
KADMIN_PRINCIPAL_FULL=$KADMIN_PRINCIPAL@$REALM

echo "REALM: $REALM"
echo "KADMIN_PRINCIPAL_FULL: $KADMIN_PRINCIPAL_FULL"
echo "KADMIN_PASSWORD: $KADMIN_PASSWORD"
echo ""

function kadminCommand {
    kadmin -p $KADMIN_PRINCIPAL_FULL -w $KADMIN_PASSWORD -q "$1"
}
until kadminCommand "change_password -pw MITiys4K5 HTTP/namenode@EXAMPLE.COM"; do
  >&2 echo "KDC is unavailable - sleeping 1 sec"
  sleep 1
done
until kadminCommand "change_password -pw MITiys4K5 nn/namenode@EXAMPLE.COM"; do
  >&2 echo "KDC is unavailable - sleeping 1 sec"
  sleep 1
done
until kadminCommand "change_password -pw MITiys4K5 sn/namenode@EXAMPLE.COM"; do
  >&2 echo "KDC is unavailable - sleeping 1 sec"
  sleep 1
done
until kadminCommand "change_password -pw MITiys4K5 dn/datanode@EXAMPLE.COM"; do
  >&2 echo "KDC is unavailable - sleeping 1 sec"
  sleep 1
done
until kadminCommand "ktadd -k /etc/security/keytab/spnego.service.keytab HTTP/namenode@EXAMPLE.COM"; do
  >&2 echo "KDC is unavailable - sleeping 1 sec"
  sleep 1
done
until kadminCommand "ktadd -k /etc/security/keytab/nn.service.keytab -norandkey nn/namenode@EXAMPLE.COM"; do
  >&2 echo "KDC is unavailable - sleeping 1 sec"
  sleep 1
done
until kadminCommand "ktadd -k /etc/security/keytab/sn.service.keytab -norandkey sn/namenode@EXAMPLE.COM"; do
  >&2 echo "KDC is unavailable - sleeping 1 sec"
  sleep 1
done
until kadminCommand "ktadd -k /etc/security/keytab/dn.service.keytab -norandkey dn/datanode@EXAMPLE.COM"; do
  >&2 echo "KDC is unavailable - sleeping 1 sec"
  sleep 1
done
until kadminCommand "list_principals *@EXAMPLE.COM"; do
  >&2 echo "KDC is unavailable - sleeping 1 sec"
  sleep 1
done
echo 'MITiys4K5' | kinit -kt /etc/security/keytab/spnego.service.keytab HTTP/namenode@EXAMPLE.COM
echo 'MITiys4K5' | kinit -kt /etc/security/keytab/nn.service.keytab nn/namenode@EXAMPLE.COM
echo 'MITiys4K5' | kinit -kt /etc/security/keytab/sn.service.keytab sn/namenode@EXAMPLE.COM
echo 'MITiys4K5' | kinit -kt /etc/security/keytab/dn.service.keytab dn/datanode@EXAMPLE.COM

echo "KDC and Kadmin are operational"
echo ""
