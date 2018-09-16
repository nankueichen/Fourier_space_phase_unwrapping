module NK_tools
    using PyPlot
    
    export qft
    export qift
    export rmsCombineDataCoils
    export imal

    function qft(inputdata)
        sz = size(inputdata)
        szarray = [i for i in sz]
        szl = length(szarray);
        if szl == 2
            outputdata = fftshift(fft(fftshift(inputdata)));
        end
        if szl >2
            outputdata = complex(inputdata)
            for cnt = 1:cumprod(szarray[3:end])[end]
                tmp1 = fftshift(fft(fftshift(inputdata[:,:,cnt])))
                outputdata[:,:,cnt]=tmp1;
            end
        end
        return outputdata
    end

    function qift(inputdata)
        sz = size(inputdata)
        szarray = [i for i in sz]
        szl = length(szarray);
        if szl == 2
            outputdata = ifftshift(ifft(ifftshift(inputdata)));
        end
        if szl >2
            outputdata = complex(inputdata)
            for cnt = 1:cumprod(szarray[3:end])[end]
                tmp1 = ifftshift(ifft(ifftshift(inputdata[:,:,cnt])))
                outputdata[:,:,cnt]=tmp1;
            end
        end
        return outputdata
    end

    function rmsCombineDataCoils(inputdata)
        szl = ndims(inputdata)
        if szl == 2
            outputdata = inputdata;
        end
        if szl > 2
            outputdata = sqrt.(mean(abs.(inputdata).^2,szl));
        end
        return outputdata
    end

    function imal(inputdata, displayHorizontalNumber, displayVerticalNumber)
        szl = ndims(inputdata)
        if (szl == 3) && (typeof(inputdata[1]) <: Real)
            sz1,sz2,sz3 = size(inputdata)
            if displayHorizontalNumber*displayVerticalNumber <= sz3
                inputdata2 = inputdata[:,:,1:displayHorizontalNumber*displayVerticalNumber]
            else   
                inputdata2 = zeros(typeof(inputdata[1]), sz1,sz2, displayHorizontalNumber*displayVerticalNumber)
                inputdata2[:,:,1:sz3] = inputdata
            end
            inputdata2 = reshape(inputdata2, (sz1,sz2*displayHorizontalNumber, displayVerticalNumber))
            showme = inputdata2[:,:,1]
            for count = 2:displayVerticalNumber
                showme = vcat(showme,inputdata2[:,:,count])
            end
            print(sizeof(showme))
            imshow(showme,cmap="gray",interpolation = "none")
        else
            error("Input data of imal function should be a 3D image of real values")

        end
    end



end
