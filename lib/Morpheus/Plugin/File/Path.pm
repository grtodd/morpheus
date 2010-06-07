package Morpheus::Plugin::File::Path;
use strict;

sub config_path {
    my $path = "./etc:/etc";
    $path = "$ENV{CONFIG_PATH}:$path" if $ENV{CONFIG_PATH};
    my @path = grep {$_} split /[:\s]+/, $path;
    s{/+$}{} for @path;
    return @path;
}

sub list ($$) {
    my ($class, $ns) = @_;
    return ("morpheus/plugin/file/options/path") if "morpheus/plugin/file/options/path/" =~ m{^\Q$ns/\E};
    return ();
}

sub morph ($$) {
    my ($class, $ns) = @_;
    if ($ns eq "morpheus/plugin/file/options/path") {
        our @config_path;
        @config_path = config_path() unless @config_path;
        return [@config_path];
    }
    return (undef);
}

1;