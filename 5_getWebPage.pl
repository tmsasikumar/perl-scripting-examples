use strict;
use warnings;

use 5.010;


use LWP::Simple;


sub getWebPage {


    my $url = 'http://www.google.com';
    
    my $downloadedPage = get $url;


    print $downloadedPage;
}


print 'the contents of the web page are : ';


getWebPage();