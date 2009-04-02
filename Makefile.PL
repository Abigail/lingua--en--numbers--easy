use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME 	  => 'Lingua::EN::Numbers::Easy',
    VERSION_FROM  => 'lib/Lingua/EN/Numbers/Easy.pm', # finds $VERSION
    PREREQ_PM     => {
        'Lingua::EN::Numbers' => 1.01,
    },
    AUTHOR        => 'Abigail <lingua-en-numbers-easy@abigail.be>',
);
