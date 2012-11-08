package OMV::PluginResourceLinkable::Callbacks;
# PluginResourceLinkable (C) 2012 Piroli YUKARINOMIYA (Open MagicVox.net)
# This program is distributed under the terms of the GNU Lesser General Public License, version 3.
# $Id$

use strict;
use warnings;
use MT;

sub instance { MT->component((__PACKAGE__ =~ /^(\w+::\w+)/g)[0]); }



### MT::App::CMS::template_source.cfg_plugin
sub template_source_cfg_plugin {
    my ($cb, $app, $tmpl) = @_;

    chomp (my $old = <<'MTMLHEREDOC');
<mt:var name="name" escape="html">
MTMLHEREDOC
    chomp (my $new = <<'MTMLHEREDOC');
<mt:if link><a href="<mt:var name="link" escape="html">"></mt:if><mt:var name="name" escape="html"><mt:if link></a></mt:if>
MTMLHEREDOC
    $$tmpl =~ s/$old/$new/;
}

### MT::App::CMS::template_param.cfg_plugin
sub template_param_cfg_plugin {
    my ($cb, $app, $param) = @_;

    my @new_plugin_loop;
    foreach (@{$param->{plugin_loop}}) {
        my ($p, $help_url);
        if (defined $_->{plugin_tags} && defined $_->{plugin_key}
                && defined ($p = MT->component ($_->{plugin_key}))
                && defined ($help_url = $p->{registry}->{tags}->{help_url})) {
            my @new_plugin_tags;
            foreach (@{$_->{plugin_tags}}) {
                (my $tag = lc $_->{name}) =~ s/^<\$?mt|\$?>$//g;
                ($_->{link} = $help_url) =~ s/%t/$tag/g;
                push @new_plugin_tags, $_;
            }
            $_->{plugin_tags} = \@new_plugin_tags if @new_plugin_tags;
        }
        push @new_plugin_loop, $_;
    }
    $param->{plugin_loop} = \@new_plugin_loop if @new_plugin_loop;
}

1;