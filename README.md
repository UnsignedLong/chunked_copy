copy.pl
=======

No magic - just a file-copy-script that can sleep a defined time between the chunks so the copy does not take down your server. Still works when you have no luck using nice/ionice :)

Example Usage
=============

ls *2013-02-1[1-5]* | xargs -n1 -I {} perl copy.pl {} /archive/{}
