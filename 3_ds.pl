my @animals = ("camel", "llama", "owl");
my @numbers = (23, 42, 69);
my @mixed   = ("camel", 42, 1.23);
    
my @sorted    = sort @animals;
my @backwards = reverse @numbers;


print "@sorted", "\n";
print "@backwards"."\n";
foreach (@animals) {
    print "This element is $_\n";
}


my %fruit_map = (
    apple  => "red",
    banana => "yellow",
);

print ($fruit_map{"banana"}); 