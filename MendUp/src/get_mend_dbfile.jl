function get_mend_dbfile()
    # warks this way on Mac. on other OSes single quotes intead of double could be necessary
    # https://stackoverflow.com/questions/3987041/run-function-from-the-command-line
    pycmd = `python3 -c "import mendeleev, inspect; print(inspect.getsourcefile(mendeleev))"`
    mend_init_file = ""
    open(pycmd, "r", stdout) do io
        mend_init_file = readline(io)
    end
    
    mend_src, _ = splitdir(mend_init_file)
    mend_db = joinpath(mend_src, "elements.db")
    @assert ispath(mend_db)
    return mend_db
end
# get_mend_dbfile()
