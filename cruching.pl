use IMDB::Film;

require LWP::Protocol::https;

$userAgent = LWP::UserAgent->new(
    agent      => 'VCMgmtLib',
    keep_alive => 1,
    ssl_opts   => {
        SSL_ca_path     => '/etc/ssl/certs',
        verify_hostname => 0,
    }
);

eval {
    my $imdbObj = new IMDB::Film(crit => 'Master', year => "2021") || print "UNKNOWN ERROR\n";

    if ($imdbObj->status) {
        print "Title: " . $imdbObj->title() . "\n";
        print "Year: " . $imdbObj->year() . "\n";
        print "Kind: " . $imdbObj->kind() . "\n";
    }
    else {
        print "Something wrong: " . $imdbObj->error;
    }
};

if ($@) {
    # Opsssss! We got an exception!
    print "EXCEPTION: $@!";
}


