package WordList::MetaSyntactic;

# DATE
# VERSION

use strict 'subs', 'vars';

sub new {
    my $package = shift;
    die "Must be subclassed by WordList::MetaSyntactic::*, not '$package'"
        unless $package =~ /\AWordList::MetaSyntactic::(\w+)\z/;
    require Acme::MetaSyntactic;
    bless [Acme::MetaSyntactic->new($1)], $package;
}

sub each_word {
    my ($self, $code) = @_;

    for my $word (sort $self->[0]->name(0)) {
        $code->($word);
    }
}

sub pick {
    my ($self, $n) = @_;

    $n ||= 1;
    $self->[0]->name($n);
}

sub word_exists {
    my ($self, $word) = @_;

    for my $w ($self->[0]->name(0)) {
        return 1 if $word eq $w;
    }
    0;
}

sub all_words {
    my ($self) = @_;

    # A:M doesn't provide a method to get a sorted list, so we sort it ourselves
    sort $self->[0]->name(0);
}

1;
# ABSTRACT: Word lists from Acme::MetaSyntactic

=for Pod::Coverage ^(.+)$

=head1 SYNOPSIS

Use one of the C<WordList::MetaSyntactic::*> modules.


=head1 DESCRIPTION

B<EXPERIMENTAL, PROOF OF CONCEPT.>

Base class for C<WordList::MetaSyntactic::*> modules.
<WordList::MetaSyntactic::*> are wordlist modules that get their wordlist from
corresponding C<Acme::MetaSyntactic::*> modules.


=head1 METHODS

See L<WordList>.


=head1 SEE ALSO

L<WordList>

L<Acme::MetaSyntactic>
