# add virtualenvwrapper into session
virtualenvwrapper='/usr/local/bin/virtualenvwrapper.sh'

[ -f $virtualenvwrapper ] && source $virtualenvwrapper

alias pyserve='foreman start'
alias pyservedebug='foreman run python -m pdb manage.py runserver'

alias pyman='python manage.py'
