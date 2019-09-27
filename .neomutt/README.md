# neomutt Setup

## create password file
echo 'set my_<password_var>="<password>"' | gpg -e --armor --user <key_id> --default-recipient-self > <filename>.gpg
