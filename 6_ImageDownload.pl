use strict;
use warnings;

use 5.010;

# calling the module
use LWP::Simple;

# declaring the sub routine
sub getImage {
    
    say "Downloading ... ";

    my $statusCode = getstore
        ("https://scontent.fmaa2-1.fna.fbcdn.net/v/t31.18172-8/13765930_1308354132538231_331039516869285312_o.jpg?_nc_cat=105&ccb=1-3&_nc_sid=e3f864&_nc_ohc=pEXKG9sLyxQAX-3urtp&_nc_ht=scontent.fmaa2-1.fna&oh=38d5157fc4f38b6bda31a3849d14e8d3&oe=60E54FE2",
            "downloaded_image_tce.png");


    if ($statusCode == 200) {
        say "Image successfully downloaded.";
    }
    else {
        print $statusCode
        say "Image download failed.";
    }
}

# calling the sub routine
getImage();