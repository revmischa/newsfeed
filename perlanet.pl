#!/usr/bin/env perl

package MSIN;

use Moose;
use namespace::autoclean;

use Carp;
use YAML 'LoadFile';

extends 'Perlanet';
with qw(
  Perlanet::Trait::Cache
  Perlanet::Trait::OPML
  Perlanet::Trait::Scrubber
  Perlanet::Trait::Tidy
  Perlanet::Trait::YAMLConfig
  Perlanet::Trait::TemplateToolkit
  Perlanet::Trait::FeedFile
);

around '_build_ua' => sub {
  my $orig = shift;
  my $self = shift;
  my $ua = $self->$orig;
  $ua->agent($self->agent) if $self->agent;
  return $ua;
};

around clean_html => sub {
    my $orig = shift;
    my ($self, $html) = @_;

    # hack to remove a particularly nasty piece of blogspot HTML
    $html = $self->$orig($html);
    $html =~ s|<div align="justify"></div>||g;

    return $html;
};

my $perlanet = MSIN->new_with_config(
    configfile => 'config.yml'
);

$perlanet->run;
