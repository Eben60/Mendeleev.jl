function make_data_through_python(data_loc, data_Mend, py_script; postprocess=nothing, copy2Mend = true)
    py_script = normpath(@__DIR__, py_script)
    pycmd = `python3 $py_script`
    result = run(pycmd)
    ! isnothing(postprocess) && postprocess()
    copy2Mend && cp(data_loc, data_Mend; force=true)
    return result
end

function make_ephil_data(; paths=paths)
    (; ephil_data_loc, ephil_data_Mend) = paths
    py_script = "list_electrophilicity.py"
    make_data_through_python(ephil_data_loc, ephil_data_Mend, py_script)
end

function make_lixue_data(; paths=paths)
    (; lixue_data_loc, lixue_data_Mend) = paths
    py_script = "list_lixue.py"
    make_data_through_python(lixue_data_loc, lixue_data_Mend, py_script; postprocess=LiXue.lixuepy2jul)
end