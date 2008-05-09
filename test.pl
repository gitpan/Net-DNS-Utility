# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test;
BEGIN { plan tests => 1 };
use Net::DNS::Utility;;
ok(1); # If we made it this far, we're ok.

#########################

# Insert your test code below, the Test module is use()ed here so read
# its man page ( perldoc Test ) for help writing this test script.

use Net::IPv6Address;
use Debug;

my $debug = new Debug();
$debug->debugFile("debug.log");
# $debug->debug(1);
$debug->detail(1);
$debug->timeStamp(1);
$debug->initialize();

my $prefix = "2001:abcd:1234:5678:90ef:0000:0000:ffff";
my $prefixlen = 64;
my $v6a = new Net::IPv6Address($prefix, $prefixlen);
$v6a->loadDebug($debug);
my $dnsUtil = new Net::DNS::Utility();

$dnsUtil->loadDebug($debug);
# my ($prefix, $length) = $dnsUtil->parse($prefixlen);
# $dnsUtil->parse($prefixlen);
my $ip6r = $dnsUtil->createIp6ReverseZone($v6a->prefix, $v6a->addressLength);
$dnsUtil->createBindNamedConf($ip6r, $v6a->prefix, $v6a->addressLength);
$dnsUtil->createBindNamedDb($ip6r, $v6a->prefix, $v6a->addressLength);
$debug->message($ip6r);
$debug->message($dnsUtil->createPtrData($v6a->interface));
