<<<<<<< HEAD
# AeroDecaptcher

AeroDecaptcher is a simple script that "solve" captcha in Aero network. It is written in Bash, but also needs Perl for tunneling via DNS queries. Script can be run on Linux and Windows via Cygwin. It does not need administrator permission. For solving Captcha it uses human-based service called https://2captcha.com

## Installation

First you need to install Perl for tunneling purposes. Needed modules and installation of them are provided here: https://www.vpnoverdns.com/download.html

Then you can run scrpit named `first_run.sh`, if output is similar to this:
```
$ ./first_run.sh
--2017-10-10 19:47:52--  https://www.vpnoverdns.com/vpnoverdns.pl
Translacja www.vpnoverdns.com (www.vpnoverdns.com)... 149.202.53.208
Łączenie się z www.vpnoverdns.com (www.vpnoverdns.com)|149.202.53.208|:443... połączono.
Żądanie HTTP wysłano, oczekiwanie na odpowiedź... 200 OK
Długość: 49156 (48K)
Zapis do: `vpnoverdns.pl'

vpnoverdns.pl       100%[===================>]  48,00K   124KB/s     w 0,4s

2017-10-10 19:47:53 (124 KB/s) - zapisano `vpnoverdns.pl' [49156/49156]

Net::DNS                 version: 1.12
LWP::UserAgent           version: 6.27
LWP::Protocol::https     version: 6.07
LWP::Protocol::connect available: true
2292: need to select only one parameter among -h, -i, -u, -L, -c, -w, -A, -X, -S and -r
```
you can rename file `aero.conf.default` to `aero.conf` and insert there API key for 2captcha.com service. API key could be obtained here: https://2captcha.com/auth/register

## Usage

```
./aero.sh
```

You can add this to cron service for example one minute `*/1 * * * * aero.sh` (correct localisation!), script automatically checks for connection and do the job if needed.


## WARINING
THIS SOFTWARE IS PROVIDED AS IS AND IT MAY BY NOT ALLOWED TO USE THAT, AUTHOR IS NOT RESPONSIBLE FOR ANY AFTER-EFFECTS! 

USE AT YOUR OWN RISK!

=======
# AeroDecaptcher

AeroDecaptcher is a simple script that "solve" captcha in Aero network. It is written in Bash, but also needs Perl for tunneling via DNS queries. Script can be run on Linux and Windows via Cygwin. It does not need administrator permission. For solving Captcha it uses human-based service called https://2captcha.com

## Installation

First you need to install Perl for tunneling purposes. Needed modules and installation of them are provided here: https://www.vpnoverdns.com/download.html

Then you can run scrpit named `first_run.sh`, if output is similar to this:
```
$ ./first_run.sh
--2017-10-10 19:47:52--  https://www.vpnoverdns.com/vpnoverdns.pl
Translacja www.vpnoverdns.com (www.vpnoverdns.com)... 149.202.53.208
Łączenie się z www.vpnoverdns.com (www.vpnoverdns.com)|149.202.53.208|:443... połączono.
Żądanie HTTP wysłano, oczekiwanie na odpowiedź... 200 OK
Długość: 49156 (48K)
Zapis do: `vpnoverdns.pl'

vpnoverdns.pl       100%[===================>]  48,00K   124KB/s     w 0,4s

2017-10-10 19:47:53 (124 KB/s) - zapisano `vpnoverdns.pl' [49156/49156]

Net::DNS                 version: 1.12
LWP::UserAgent           version: 6.27
LWP::Protocol::https     version: 6.07
LWP::Protocol::connect available: true
2292: need to select only one parameter among -h, -i, -u, -L, -c, -w, -A, -X, -S and -r
```
you can rename file `aero.conf.default` to `aero.conf` and insert there API key for 2captcha.com service. API key could be obtained here: https://2captcha.com/auth/register

## Usage

```
./aero.sh
```

You can add this to cron service for example one minute `*/1 * * * * aero.sh` (correct localisation!), script automatically checks for connection and do the job if needed.


## WARINING
THIS SOFTWARE IS PROVIDED AS IS AND IT MAY BY NOT ALLOWED TO USE THAT, AUTHOR IS NOT RESPONSIBLE FOR ANY AFTER-EFFECTS! 

USE AT YOUR OWN RISK!

>>>>>>> cc44649207a88f46b6dbac401bfe2c18ccfc6e34
