package Lingua::EN::Numbers::Easy;

#
# $Id: Easy.pm,v 1.2 1999/11/07 15:17:34 abigail Exp abigail $
#
# $Log: Easy.pm,v $
# Revision 1.2  1999/11/07 15:17:34  abigail
# Worked around a bug (0 -> 'zero') in Lingua::EN::Numbers.
#
# Revision 1.1  1999/11/07 14:59:14  abigail
# Initial revision
#
#

use strict;

use vars qw /$VERSION %N/;

($VERSION) = '$Revision: 1.2 $' =~ /([\d.]+)/;

sub import {
    my ($pkg, $tag, $hash) = @_;
    require Lingua::EN::Numbers;
    Lingua::EN::Numbers -> import ($tag || 'British');
    
    my $callpkg = caller;
    $hash = 'N' unless defined $hash;
    $hash =~ s/^%//;

    no strict 'refs';
    *{"${callpkg}::$hash"} = \%N;
}


sub TIEHASH {bless {0 => 'zero'} => __PACKAGE__}
sub FETCH {
    my $self  = shift;
    my $value = shift;
    return $self -> {$value} if exists $self -> {$value};
   (my $n = Lingua::EN::Numbers -> new) -> parse ($value) or return;
    $self -> {$value} = lc $n -> get_string;
}

sub STORE    {die}
sub EXISTS   {die}
sub DELETE   {die}
sub CLEAR    {die}
sub FIRSTKEY {die}
sub NEXTKEY  {die}

tie %N => __PACKAGE__;

__END__

=pod

=head1 NAME

Lingua::EN::Numbers::Easy  --  Hash access to Lingua::EN::Numbers objects.

=head1 SYNOPSIS

    use Lingua::EN::Numbers::Easy;

    print "$N{1} fish, $N{2} fish, blue fish, red fish";
                         # one fish, two fish, blue fish, red fish.

=head1 DESCRIPTION

C<Lingua::EN::Numbers> is a module that translates numbers to English 
words. Unfortunally, it has an object oriented interface, which makes
it hard to interpolate them in strings. C<Lingua::EN::Numbers::Easy>
translates numbers to words using a tied hash, which can be interpolated.

By default, C<Lingua::EN::Numbers::Easy> exports a hash C<%N> to the
importing package. Also, by default, C<Lingua::EN::Numbers::Easy> uses
the British mode of C<Lingua::EN::Numbers>. Both defaults can be changed
by optional arguments to the C<use Lingua::EN::Numbers::Easy;> statement.

The first argument determines the parsing mode of C<Lingua::EN::Numbers>.
Currently, C<Lingua::EN::Numbers> supports I<British> and I<American>.
The second argument determines the name of the hash in the importing
package.

    use Lingua::EN::Numbers::Easy qw /American %nums/;

would use I<American> parsing mode, and C<%nums> as the tied hash.

See also the C<Lingua::EN::Numbers> man page.

C<Lingua::EN::Numbers::Easy> caches results - numbers will only be
translated once.

Any other operation on the exported hash than fetches will throw an exception.

=head1 REVISION HISTORY

    $Log: Easy.pm,v $
    Revision 1.2  1999/11/07 15:17:34  abigail
    Worked around a bug (0 -> 'zero') in Lingua::EN::Numbers.

    Revision 1.1  1999/11/07 14:59:14  abigail
    Initial revision


=head1 AUTHOR

This package was written by Abigail, abigail@delanet.com.

=head1 COPYRIGHT and LICENSE

This package is copyright 1999 by Abigail.

Permission is hereby granted, free of charge, to any person obtaining a
copy of this software and associated documentation files (the "Software"),
to deal in the Software without restriction, including without limitation
the rights to use, copy, modify, merge, publish, distribute, sublicense,
and/or sell copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included
in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
THE OPEN GROUP BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT
OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

=cut
