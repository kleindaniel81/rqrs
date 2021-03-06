{smcl}
{cmd:help rqrs}
{hline}

{title:Title}

{p 4 12 2}
{cmd:rqrs} {hline 2} Install required community-contributed packages


{title:Syntax}

{p 8 12 2}
{cmd:rqrs}
{it:command}
[ {it:pkgname} ]
[ {cmd:,} {it:options} ]


{p 4 8 2}
where {it:command} is the name of a community-contributed command 
and {it:pkgname} is the name of a package

{p 10 12 2}
{it:commmand} may be {it:fname}[{cmd:.}{it:ftype}]; see {helpb which}


{synoptset 24 tabbed}{...}
{marker opts}{...}
{synopthdr}
{synoptline}
{synopt:{opt fr:om(directory_or_url)}}directory or URL 
where package is found; also see {helpb net:net install}
{p_end}
{synopt:{opt all}}download ancillary files; same as 
for {helpb ssc:ssc install} and {helpb net:net install}
{p_end}
{synopt:{opt replace}}replace existing files; same as 
for {helpb ssc:ssc install} and {helpb net:net install}
{p_end}
{synopt:{opt force}}install package even if {it:command} 
is found along the {help sysdir:ado-path}; also see 
{helpb net:net install}
{p_end}
{synopt:{opt inst:all}}install required package without
asking permission
{p_end}
{synoptline}
{p2colreset}{...}


{title:Description}

{pstd}
{cmd:rqrs} checks whether a specified community-contributed command is 
found along the {help sysdir:ado-path} and, if it is not, downloads and 
installs the required package that contains the command. A package 
typically contains one or more ado-files and one or more corresponding 
help files. Packages are downloaded from the {help ssc:SSC} or, optionally, 
from another location indicated by a directory or URL.

{pstd}
Often, a command and a package share the same name and, if they do, you 
only need to specify the command name. If you specify 
{it:fname}{cmd:.}{it:ftype}, you must also specify a package name.


{title:Options}

{phang}
{opt from(directory_or_url)} specifies the directory or URL where the 
required package is found. Instead of a directory or URL, {opt from()} 
also accepts the following shortcuts

{p2colset 9 16 16 2}{...}
{p2col:{cmd:ssc}}download and install package from {help ssc:SSC}
(the default){p_end}
{p2col:{cmd:net}}download and install package from the location set 
by {helpb net:net from}{p_end}
{p2col:{cmd:sj}{it:#}{cmd:-}{it:#}}download and install package 
from  the Stata Journal (SJ) {it:vol}-{it:issue}{p_end}
{p2col:{cmd:stb}{it:#}}download and install package 
from  the Stata Technical Bulletin (STB) {it:issue}
{p2colreset}{...}

{phang}
{opt all} is seldom used. The option downloads any ancillary files 
associated with a package to the current directory ({ccl pwd}) or 
the directory set by {helpb net:net set other}. Note that this option 
is ignored if the required command is already installed and found 
along the {help sysdir:ado-path}.

{phang}
{opt replace} is seldom used. The option replaces existing files with 
downloaded files. Note that this option is ignored if the required
command is already installed and found along the {help sysdir:ado-path}.

{phang}
{opt force} is seldom used. The option downloads and installs the 
required package even if the required command is already installed and 
found along the {help sysdir:ado-path}. {opt force} implies {opt replace}.

{phang}
{opt install} installs the required package without asking
permission. Default is to ask whether the required package should be 
installed before downloading and installing it. Note that this option 
is ignored if the required command is already installed and found 
along the {help sysdir:ado-path}.


{marker remarks}{...}
{title:Remarks}

{pstd}
{cmd:rqrs} is intended for use in do-files that call community-contributed 
commands. A do-file that calls {cmd:findname} and {cmd:esttab} 
(from the {cmd:estout} package), both from {help ssc:SSC}, could read:

{col 10}{hline 4} begin do_file.do {hline}
{p 10 12 2}
{cmd:version {ccl stata_version}}
{p_end}

{p 10 12 2}
{cmd:rqrs findname}
{p_end}
{p 10 12 2}
{cmd:rqrs esttab estout}
{p_end}

{p 10 12 2}
{it:...}
{p_end}

{p 10 12 2}
{cmd:findname} {it:...}
{p_end}

{p 10 12 2}
{it:...}
{p_end}

{p 10 12 2}
{cmd:esttab} {it:...}
{p_end}

{p 10 12 2}
{it:...}
{p_end}

{col 10}{hline 4} end do_file.do {hline}

{pstd}
The do-file above automatically downloads and installs all required 
community-contributed commands -- except {cmd:rqrs}. Therefore, we 
add two lines of code that resemble the core of {cmd:rqrs} internal 
code.

{col 10}{hline 4} begin do_file2.do {hline}
{p 10 12 2}
{cmd:version {ccl stata_version}}
{p_end}

{p 10 12 2}
{helpb capture} {helpb quietly:noisily} {helpb which} {cmd:rqrs}
{bind: }{cmd:// <- new}
{p_end}
{p 10 12 2}
{helpb ifcmd:if} {cmd:( _rc )} {helpb ssc:ssc install} {cmd:rqrs // <- new}
{p_end}

{p 10 12 2}
{cmd:rqrs findname}
{p_end}
{p 10 12 2}
{cmd:rqrs esttab estout}
{p_end}

{p 10 12 2}
{it:...}
{p_end}

{col 10}{hline 4} end do_file2.do {hline}


{pstd}
Some packages, e.g., {cmd:moremata} (from SSC), do not include an(y) 
ado-file with the same name as the package. To check whether such packages 
are installed, specify the complete name of one the files that is included 
in the respective package. For example, if your do-file requires the 
{cmd:moremata} package from SSC, you might type

{phang2}
{cmd:. rqrs lmoremata.mlib moremata}
{p_end}

{pstd}
to check whether the compiled Mata library, {cmd:lmoremata.mlib} is 
installed. Note that you must also specify the package name {cmd:moremata}. 

		
{title:Examples}

{pstd}
See {help rqrs##remarks:Remarks} for a worked example.

{pstd}
If it is not found along the ado-path, install {cmd:findname} from SSC

{phang2}
{cmd:. rqrs findname}

{pstd}
Same as above; install without asking permission

{phang2}
{cmd:. rqrs findname , install}


{pstd}
If it is not found along the ado-path, install {cmd:findname}; this time 
install the latest update from the Stata Journal

{phang2}
{cmd:. rqrs findname dm0048_4 , from(sj20-2)}


{pstd}
If it is not found along the ado-path, install {cmd:esttab} from the 
{cmd:estout} package on SSC

{phang2}
{cmd:. rqrs esttab estout}


{title:Author}

{pstd}
Daniel Klein{break}
University of Kassel{break}
klein.daniel.81@gmail.com


{title:Also see}

{psee}
Online: {help ssc}, {help net}, {help adoupdate}, {help sysdir}{p_end}

{psee}
if installed: {help usepackage}, {help adolist}, {help copycode}
