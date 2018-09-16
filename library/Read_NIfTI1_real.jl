module Read_NIfTI1_real
 
    export load_nii_header
    export write_nii_header
#     export voxellocation!
#     export inversevoxellocation!
    export load_nii_data
    export load_niigz_header
    export load_niigz_data
    import GZip

# See https://nifti.nimh.nih.gov/pub/dist/src/niftilib/nifti1.h 
    function load_nii_header(filename::String)    
        headerinfo = Dict()
        fid = open(filename,"r")
        testvalue = read(fid,Int32,1);
        headerinfo["sizeof_hdr"] = testvalue
        testvalue = read(fid,UInt8,10);
        headerinfo["data_type"] = testvalue
        testvalue = read(fid,Int8,18);
        headerinfo["db_name"] = testvalue
        testvalue = read(fid,Int32,1);
        headerinfo["extents"] = testvalue
        testvalue = read(fid,Int16,1);
        headerinfo["session_error"] = testvalue
        testvalue = read(fid,Int8,1);
        headerinfo["regular"] = testvalue
        testvalue = read(fid,Int8,1);
        headerinfo["dim_info"] = testvalue
        testvalue = read(fid,Int16,8);
        headerinfo["dim"] = testvalue
        testvalue = read(fid,Float32,1);
        headerinfo["intent_p1"] = testvalue
        testvalue = read(fid,Float32,1);
        headerinfo["intent_p2"] = testvalue
        testvalue = read(fid,Float32,1);
        headerinfo["intent_p3"] = testvalue
        testvalue = read(fid,Int16,1);
        headerinfo["intent_code"] = testvalue
        testvalue = read(fid,Int16,1);
        headerinfo["datatype"] = testvalue
        testvalue = read(fid,Int16,1);
        headerinfo["bitpix"] = testvalue
        testvalue = read(fid,Int16,1);
        headerinfo["slice_start"] = testvalue
        testvalue = read(fid,Float32,8);
        headerinfo["pixdim"] = testvalue
        testvalue = read(fid,Float32,1);
        headerinfo["vox_offset"] = testvalue
        testvalue = read(fid,Float32,1);
        headerinfo["scl_slope"] = testvalue
        testvalue = read(fid,Float32,1);
        headerinfo["scl_inter"] = testvalue
        testvalue = read(fid,Int16,1);
        headerinfo["slice_end"] = testvalue
        testvalue = read(fid,Int8,1);
        headerinfo["slice_code"] = testvalue
        testvalue = read(fid,Int8,1);
        headerinfo["xyzt_units"] = testvalue
        testvalue = read(fid,Float32,1);
        headerinfo["cal_max"] = testvalue
        testvalue = read(fid,Float32,1);
        headerinfo["cal_min"] = testvalue
        testvalue = read(fid,Float32,1);
        headerinfo["slice_duration"] = testvalue
        testvalue = read(fid,Float32,1);
        headerinfo["toffset"] = testvalue
        testvalue = read(fid,Int32,1);
        headerinfo["glmax"] = testvalue
        testvalue = read(fid,Int32,1);
        headerinfo["glmin"] = testvalue
        testvalue = read(fid,Int8,80);
        headerinfo["descrip"] = testvalue
        testvalue = read(fid,Int8,24);
        headerinfo["aux_file"] = testvalue
        testvalue = read(fid,Int16,1);
        headerinfo["qform_code"] = testvalue
        testvalue = read(fid,Int16,1);
        headerinfo["sform_code"] = testvalue
        testvalue = read(fid,Float32,1);
        headerinfo["quatern_b"] = testvalue
        testvalue = read(fid,Float32,1);
        headerinfo["quatern_c"] = testvalue
        testvalue = read(fid,Float32,1);
        headerinfo["quatern_d"] = testvalue
        testvalue = read(fid,Float32,1);
        headerinfo["qoffset_x"] = testvalue
        testvalue = read(fid,Float32,1);
        headerinfo["qoffset_y"] = testvalue
        testvalue = read(fid,Float32,1);
        headerinfo["qoffset_z"] = testvalue
        testvalue = read(fid,Float32,4);
        headerinfo["srow_x"] = testvalue
        testvalue = read(fid,Float32,4);
        headerinfo["srow_y"] = testvalue
        testvalue = read(fid,Float32,4);
        headerinfo["srow_z"] = testvalue
        testvalue = read(fid,Int8,16);
        headerinfo["intent_name"] = testvalue
        testvalue = read(fid,Int8,4);
        headerinfo["magic"] = testvalue
        close(fid)
        headerinfo["qfac"] = headerinfo["pixdim"][1];
        headerinfo["filename"]= filename;
        return headerinfo;
    end

    function load_niigz_header(filename::String)    
        headerinfo = Dict()
        fid = GZip.open(filename,"r")
        testvalue = read(fid,Int32,1);
        headerinfo["sizeof_hdr"] = testvalue
        testvalue = read(fid,Int8,10);
        headerinfo["data_type"] = testvalue
        testvalue = read(fid,Int8,18);
        headerinfo["db_name"] = testvalue
        testvalue = read(fid,Int32,1);
        headerinfo["extents"] = testvalue
        testvalue = read(fid,Int16,1);
        headerinfo["session_error"] = testvalue
        testvalue = read(fid,Int8,1);
        headerinfo["regular"] = testvalue
        testvalue = read(fid,Int8,1);
        headerinfo["dim_info"] = testvalue
        testvalue = read(fid,Int16,8);
        headerinfo["dim"] = testvalue
        testvalue = read(fid,Float32,1);
        headerinfo["intent_p1"] = testvalue
        testvalue = read(fid,Float32,1);
        headerinfo["intent_p2"] = testvalue
        testvalue = read(fid,Float32,1);
        headerinfo["intent_p3"] = testvalue
        testvalue = read(fid,Int16,1);
        headerinfo["intent_code"] = testvalue
        testvalue = read(fid,Int16,1);
        headerinfo["datatype"] = testvalue
        testvalue = read(fid,Int16,1);
        headerinfo["bitpix"] = testvalue
        testvalue = read(fid,Int16,1);
        headerinfo["slice_start"] = testvalue
        testvalue = read(fid,Float32,8);
        headerinfo["pixdim"] = testvalue
        testvalue = read(fid,Float32,1);
        headerinfo["vox_offset"] = testvalue
        testvalue = read(fid,Float32,1);
        headerinfo["scl_slope"] = testvalue
        testvalue = read(fid,Float32,1);
        headerinfo["scl_inter"] = testvalue
        testvalue = read(fid,Int16,1);
        headerinfo["slice_end"] = testvalue
        testvalue = read(fid,Int8,1);
        headerinfo["slice_code"] = testvalue
        testvalue = read(fid,Int8,1);
        headerinfo["xyzt_units"] = testvalue
        testvalue = read(fid,Float32,1);
        headerinfo["cal_max"] = testvalue
        testvalue = read(fid,Float32,1);
        headerinfo["cal_min"] = testvalue
        testvalue = read(fid,Float32,1);
        headerinfo["slice_duration"] = testvalue
        testvalue = read(fid,Float32,1);
        headerinfo["toffset"] = testvalue
        testvalue = read(fid,Int32,1);
        headerinfo["glmax"] = testvalue
        testvalue = read(fid,Int32,1);
        headerinfo["glmin"] = testvalue
        testvalue = read(fid,Int8,80);
        headerinfo["descrip"] = testvalue
        testvalue = read(fid,Int8,24);
        headerinfo["aux_file"] = testvalue
        testvalue = read(fid,Int16,1);
        headerinfo["qform_code"] = testvalue
        testvalue = read(fid,Int16,1);
        headerinfo["sform_code"] = testvalue
        testvalue = read(fid,Float32,1);
        headerinfo["quatern_b"] = testvalue
        testvalue = read(fid,Float32,1);
        headerinfo["quatern_c"] = testvalue
        testvalue = read(fid,Float32,1);
        headerinfo["quatern_d"] = testvalue
        testvalue = read(fid,Float32,1);
        headerinfo["qoffset_x"] = testvalue
        testvalue = read(fid,Float32,1);
        headerinfo["qoffset_y"] = testvalue
        testvalue = read(fid,Float32,1);
        headerinfo["qoffset_z"] = testvalue
        testvalue = read(fid,Float32,4);
        headerinfo["srow_x"] = testvalue
        testvalue = read(fid,Float32,4);
        headerinfo["srow_y"] = testvalue
        testvalue = read(fid,Float32,4);
        headerinfo["srow_z"] = testvalue
        testvalue = read(fid,Int8,16);
        headerinfo["intent_name"] = testvalue
        testvalue = read(fid,Int8,4);
        headerinfo["magic"] = testvalue
        close(fid)
        headerinfo["qfac"] = headerinfo["pixdim"][1];
        headerinfo["filename"]= filename;
        return headerinfo;
    end

    function write_nii_header(filename::String, headerinfo)
        fid = open(filename,"w")
        write(fid,headerinfo["sizeof_hdr"]);
        write(fid,headerinfo["data_type"]);
        write(fid,headerinfo["db_name"]);
        write(fid,headerinfo["extents"]);
        write(fid,headerinfo["session_error"]);
        write(fid,headerinfo["regular"]);
        write(fid,headerinfo["dim_info"]);
        write(fid,headerinfo["dim"]);
        write(fid,headerinfo["intent_p1"]);
        write(fid,headerinfo["intent_p2"]);
        write(fid,headerinfo["intent_p3"]);
        write(fid,headerinfo["intent_code"]);
        write(fid,headerinfo["datatype"]);
        write(fid,headerinfo["bitpix"]);
        write(fid,headerinfo["slice_start"]);
        write(fid,headerinfo["pixdim"]);
        write(fid,headerinfo["vox_offset"]);
        write(fid,headerinfo["scl_slope"]);
        write(fid,headerinfo["scl_inter"]);
        write(fid,headerinfo["slice_end"]);
        write(fid,headerinfo["slice_code"]);
        write(fid,headerinfo["xyzt_units"]);
        write(fid,headerinfo["cal_max"]);
        write(fid,headerinfo["cal_min"]);
        write(fid,headerinfo["slice_duration"]);
        write(fid,headerinfo["toffset"]);
        write(fid,headerinfo["glmax"]);
        write(fid,headerinfo["glmin"]);
        write(fid,headerinfo["descrip"]);
        write(fid,headerinfo["aux_file"]);
        write(fid,headerinfo["qform_code"]);
        write(fid,headerinfo["sform_code"]);
        write(fid,headerinfo["quatern_b"]);
        write(fid,headerinfo["quatern_c"]);
        write(fid,headerinfo["quatern_d"]);
        write(fid,headerinfo["qoffset_x"]);
        write(fid,headerinfo["qoffset_y"]);
        write(fid,headerinfo["qoffset_z"]);
        write(fid,headerinfo["srow_x"]);
        write(fid,headerinfo["srow_y"]);
        write(fid,headerinfo["srow_z"]);
        write(fid,headerinfo["intent_name"]);
        write(fid,headerinfo["magic"]);
        write(fid,Int32(0));
        close(fid)
    end

#     function voxellocation!(voxel_location_x::Array{Float32,3},voxel_location_y::Array{Float32,3},voxel_location_z::Array{Float32,3}, headerinfo)
#         # see https://nifti.nimh.nih.gov/nifti-1/documentation/nifti1fields/nifti1fields_pages/srow.html/document_view
#         srow_x1::Float32 = headerinfo["srow_x"][1];
#         srow_x2::Float32 = headerinfo["srow_x"][2];
#         srow_x3::Float32 = headerinfo["srow_x"][3];
#         srow_x4::Float32 = headerinfo["srow_x"][4];
#         srow_y1::Float32 = headerinfo["srow_y"][1];
#         srow_y2::Float32 = headerinfo["srow_y"][2];
#         srow_y3::Float32 = headerinfo["srow_y"][3];
#         srow_y4::Float32 = headerinfo["srow_y"][4];
#         srow_z1::Float32 = headerinfo["srow_z"][1];
#         srow_z2::Float32 = headerinfo["srow_z"][2];
#         srow_z3::Float32 = headerinfo["srow_z"][3];
#         srow_z4::Float32 = headerinfo["srow_z"][4];
#         zdim::Int32 = headerinfo["dim"][4];
#         ydim::Int32 = headerinfo["dim"][3];
#         xdim::Int32 = headerinfo["dim"][2];
#         tmp::Float32 = 0;
#         for cntz::Int32 = 1:zdim
#             for cnty::Int32 = 1:ydim
#                 for cntx::Int32 = 1:xdim
#                     fcntx::Float32 = Float32(cntx)-Float32(1.0);
#                     fcnty::Float32 = Float32(cnty)-Float32(1.0);
#                     fcntz::Float32 = Float32(cntz)-Float32(1.0);
#                     tmp = (srow_x1*fcntx)+(srow_x2*fcnty)+(srow_x3*fcntz)+ srow_x4;
#                     voxel_location_x[cntx,cnty,cntz]=tmp;
#                     tmp = (srow_y1*fcntx)+(srow_y2*fcnty)+(srow_y3*fcntz)+ srow_y4;
#                     voxel_location_y[cntx,cnty,cntz]=tmp;
#                     tmp = (srow_z1*fcntx)+(srow_z2*fcnty)+(srow_z3*fcntz)+ srow_z4;
#                     voxel_location_z[cntx,cnty,cntz]=tmp;
#                 end
#             end
#         end
#         nothing
#     end

#     function inversevoxellocation!(voxel_location_new::Array{Float32,2}, voxel_location::Array{Float32,2}, headerinfo)
#         # see https://nifti.nimh.nih.gov/nifti-1/documentation/nifti1fields/nifti1fields_pages/srow.html/document_view
#         srow_x1::Float32 = headerinfo["srow_x"][1];
#         srow_x2::Float32 = headerinfo["srow_x"][2];
#         srow_x3::Float32 = headerinfo["srow_x"][3];
#         srow_x4::Float32 = headerinfo["srow_x"][4];
#         srow_y1::Float32 = headerinfo["srow_y"][1];
#         srow_y2::Float32 = headerinfo["srow_y"][2];
#         srow_y3::Float32 = headerinfo["srow_y"][3];
#         srow_y4::Float32 = headerinfo["srow_y"][4];
#         srow_z1::Float32 = headerinfo["srow_z"][1];
#         srow_z2::Float32 = headerinfo["srow_z"][2];
#         srow_z3::Float32 = headerinfo["srow_z"][3];
#         srow_z4::Float32 = headerinfo["srow_z"][4];
#         tmp::Float32 = 0;
#         mat01 = hcat([srow_x1,srow_y1,srow_z1],[srow_x2,srow_y2,srow_z2],[srow_x3,srow_y3,srow_z3])
#         mat02 = inv(mat01)
#         srow_x1 = mat02[1,1]
#         srow_y1 = mat02[2,1]
#         srow_z1 = mat02[3,1]
#         srow_x2 = mat02[1,2]
#         srow_y2 = mat02[2,2]
#         srow_z2 = mat02[3,2]
#         srow_x3 = mat02[1,3]
#         srow_y3 = mat02[2,3]
#         srow_z3 = mat02[3,3]
#         length0 = size(voxel_location)[1]
#         for cnt::Int32 = 1:length0
#             fcntx::Float32 = voxel_location[cnt,1]-srow_x4;
#             fcnty::Float32 = voxel_location[cnt,2]-srow_y4;
#             fcntz::Float32 = voxel_location[cnt,3]-srow_z4;
#             tmp = (srow_x1*fcntx)+(srow_x2*fcnty)+(srow_x3*fcntz)+Float32(1.0)
#             voxel_location_new[cnt,1]=tmp;
#             tmp = (srow_y1*fcntx)+(srow_y2*fcnty)+(srow_y3*fcntz)+Float32(1.0)
#             voxel_location_new[cnt,2]=tmp;
#             tmp = (srow_z1*fcntx)+(srow_z2*fcnty)+(srow_z3*fcntz)+Float32(1.0)
#             voxel_location_new[cnt,3]=tmp;
#         end
#         nothing
#     end

    function load_nii_data(filename::String, headerinfo)
        zdim::Int = headerinfo["dim"][4];
        ydim::Int = headerinfo["dim"][3];
        xdim::Int = headerinfo["dim"][2];
        tdim::Int = headerinfo["dim"][5];
        ndim::Int = headerinfo["dim"][1];
        offset::Int = convert(Int,headerinfo["vox_offset"][1]);
        fid = open(filename,"r")
        seek(fid,offset)
        if headerinfo["datatype"][1]  == 2 
            data = read(fid,UInt8,xdim*ydim*zdim*tdim)
        elseif headerinfo["datatype"][1]  == 4
            data = read(fid,Int16,xdim*ydim*zdim*tdim)
        elseif headerinfo["datatype"][1]  == 8 
            data = read(fid,Int32,xdim*ydim*zdim*tdim)
        elseif headerinfo["datatype"][1]  == 16 
            data = read(fid,Float32,xdim*ydim*zdim*tdim)
        elseif headerinfo["datatype"][1]  == 64 
            data = read(fid,Float64,xdim*ydim*zdim*tdim)
        elseif headerinfo["datatype"][1]  == 256 
            data = read(fid,Int8,xdim*ydim*zdim*tdim)
        elseif headerinfo["datatype"][1]  == 512 
            data = read(fid,UInt16,xdim*ydim*zdim*tdim)
        elseif headerinfo["datatype"][1]  == 768 
            data = read(fid,UInt32,xdim*ydim*zdim*tdim)
        elseif headerinfo["datatype"][1]  == 1024 
            data = read(fid,Int64,xdim*ydim*zdim*tdim)
        elseif headerinfo["datatype"][1]  == 1280 
            data = read(fid,UInt64,xdim*ydim*zdim*tdim)
        else
            data = [];
            println("-- nii data were not loaded properly --")
        end
        close(fid);
        if ndim == 4
            data = reshape(data,xdim,ydim,zdim,tdim);
        elseif ndim == 3
            data = reshape(data,xdim,ydim,zdim);
        end
        return data;
    end

    function load_niigz_data(filename::String, headerinfo)
        zdim::Int = headerinfo["dim"][4];
        ydim::Int = headerinfo["dim"][3];
        xdim::Int = headerinfo["dim"][2];
        tdim::Int = headerinfo["dim"][5];
        ndim::Int = headerinfo["dim"][1];
        offset::Int = convert(Int,headerinfo["vox_offset"][1]);
        fid = GZip.open(filename,"r")
        seek(fid,offset)
        if headerinfo["datatype"][1]  == 2 
            data = read(fid,UInt8,xdim*ydim*zdim*tdim)
        elseif headerinfo["datatype"][1]  == 4
            data = read(fid,Int16,xdim*ydim*zdim*tdim)
        elseif headerinfo["datatype"][1]  == 8 
            data = read(fid,Int32,xdim*ydim*zdim*tdim)
        elseif headerinfo["datatype"][1]  == 16 
            data = read(fid,Float32,xdim*ydim*zdim*tdim)
        elseif headerinfo["datatype"][1]  == 64 
            data = read(fid,Float64,xdim*ydim*zdim*tdim)
        elseif headerinfo["datatype"][1]  == 256 
            data = read(fid,Int8,xdim*ydim*zdim*tdim)
        elseif headerinfo["datatype"][1]  == 512 
            data = read(fid,UInt16,xdim*ydim*zdim*tdim)
        elseif headerinfo["datatype"][1]  == 768 
            data = read(fid,UInt32,xdim*ydim*zdim*tdim)
        elseif headerinfo["datatype"][1]  == 1024 
            data = read(fid,Int64,xdim*ydim*zdim*tdim)
        elseif headerinfo["datatype"][1]  == 1280 
            data = read(fid,UInt64,xdim*ydim*zdim*tdim)
        else
            data = [];
            println("-- nii data were not loaded properly --")
        end
        close(fid);
        if ndim == 4
            data = reshape(data,xdim,ydim,zdim,tdim);
        elseif ndim == 3
            data = reshape(data,xdim,ydim,zdim);
        end
        return data;
    end

    # datatype:
    #define NIFTI_TYPE_UINT8           2 /! unsigned char. /
    #define NIFTI_TYPE_INT16           4 /! signed short. /
    #define NIFTI_TYPE_INT32           8 /! signed int. /
    #define NIFTI_TYPE_FLOAT32        16 /! 32 bit float. /
    #define NIFTI_TYPE_COMPLEX64      32 /! 64 bit complex = 2 32 bit floats. /
    #define NIFTI_TYPE_FLOAT64        64 /! 64 bit float = double. /
    #define NIFTI_TYPE_RGB24         128 /! 3 8 bit bytes. /
    #define NIFTI_TYPE_INT8          256 /! signed char. /
    #define NIFTI_TYPE_UINT16        512 /! unsigned short. /
    #define NIFTI_TYPE_UINT32        768 /! unsigned int. /
    #define NIFTI_TYPE_INT64        1024 /! signed long long. /
    #define NIFTI_TYPE_UINT64       1280 /! unsigned long long. /
    #define NIFTI_TYPE_FLOAT128     1536 /! 128 bit float = long double. /
    #define NIFTI_TYPE_COMPLEX128   1792 /! 128 bit complex = 2 64 bit floats. /
    #define NIFTI_TYPE_COMPLEX256   2048 /! 256 bit complex = 2 128 bit floats /


end




