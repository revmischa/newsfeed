#!/usr/bin/env perl

use Moose;
use Perlanet::Simple;

my $perlanet = Perlanet::Simple->new_with_config('config.yml');
$perlanet->run;


