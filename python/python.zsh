# add virtualenvwrapper into session
virtualenvwrapper='/usr/local/bin/virtualenvwrapper.sh'

if [ -f $virtualenvwrapper ] 
then
  source $virtualenvwrapper
  export WORKON_HOME=$HOME/.virtualenvs
fi

# Disable Bytecode (.pyc) Files
# ref: http://docs.python-guide.org/en/latest/writing/gotchas/#disabling-bytecode-pyc-files
export PYTHONDONTWRITEBYTECODE=1

alias pyserve='foreman start'
alias pyservedebug='foreman run python -m pdb manage.py runserver'

alias pyman='python manage.py'
alias fopyman='foreman run python manage.py'

# Sometimes we need the framework python
# http://matplotlib.org/faq/virtualenv_faq.html
function frameworkpython {
    if [[ ! -z "$VIRTUAL_ENV" ]]; then
        PYTHONHOME=$VIRTUAL_ENV /usr/local/bin/python "$@"
    else
        /usr/local/bin/python "$@"
    fi
}
