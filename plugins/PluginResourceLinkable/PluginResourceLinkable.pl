package MT::Plugin::Admin::OMV::PluginResourceLinkable;
# PluginResourceLinkable (C) 2012 Piroli YUKARINOMIYA (Open MagicVox.net)
# This program is distributed under the terms of the GNU Lesser General Public License, version 3.
# $Id$

use strict;
use warnings;
use MT 4;

use vars qw( $VENDOR $MYNAME $FULLNAME $VERSION );
$FULLNAME = join '::',
        (($VENDOR, $MYNAME) = (split /::/, __PACKAGE__)[-2, -1]);
(my $revision = '$Rev$') =~ s/\D//g;
$VERSION = 'v0.10'. ($revision ? ".$revision" : '');

# http://www.sixapart.jp/movabletype/manual/object_reference/archives/mt_plugin.html
use base qw( MT::Plugin );
my $plugin = __PACKAGE__->new ({
    id => $FULLNAME,
    key => $FULLNAME,
    name => $MYNAME,
    version => $VERSION,
    author_name => 'Open MagicVox.net',
    author_link => 'http://www.magicvox.net/',
    plugin_link => 'http://www.magicvox.net/archive/2012/11081621/', # Blog
    doc_link => 'http://lab.magicvox.net/trac/mt-plugins/wiki/PluginResourceLinkable', # tracWiki
    description => <<'HTMLHEREDOC',
<__trans phrase="Make template tags which are listed in the plugin's resource linkable to its help page.">
HTMLHEREDOC
    l10n_class => "${FULLNAME}::L10N",
    registry => {
        callbacks => {
            'MT::App::CMS::template_source.cfg_plugin' => "${FULLNAME}::Callbacks::template_source_cfg_plugin",
            'MT::App::CMS::template_param.cfg_plugin' => "${FULLNAME}::Callbacks::template_param_cfg_plugin",
        },
    },
});
MT->add_plugin ($plugin);

sub instance { $plugin; }

1;