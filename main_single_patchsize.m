% matlab 2018b

%%%%%% define the parameters in the next 7 lines
magnitude_nii_file = "data/magnitude.nii";
phase_nii_file = "data/phase.nii";
partiallyUnwrapped_nii_file = "data/partiallyUnwrappedMap.nii";
criticalROI_nii_file = "data/criticalROI.nii";
ChooseThisSlice = 5; % process data in a chosen slice; e.g., slice #5 in this case
criticalROILabel = 1; % unwrap phase values inside a critical ROI labeled with an integer number; e.g., 1 in this case
output_nii_file = "data/output.nii";
%%%%%%





%%%%%% the main program starts here; no need to modify the code below (although you could use different value of patchsize)

addpath ./matlabfunction

data001 = niftiread(magnitude_nii_file);
data002 =  niftiread(phase_nii_file); 
imagedata_noise = data001 .* exp(complex(0,1)*data002);

imgsn = imagedata_noise(:,:,ChooseThisSlice);
ksn = ifftshift(ifft2(ifftshift(imgsn)));

datasize1 = size(imgsn,1);
datasize2 = size(imgsn,2);

pxmap = zeros(datasize1,datasize2);
pymap = zeros(datasize1,datasize2);

patchsize = 7;
patchsize = patchsize + (1 + ((-1).^patchsize))/2;
tic
ps1 = max((patchsize-1)/2,1);    
for cntx = 1:datasize1
    for cnty = 1:datasize2
        tmp1 = zeros(datasize1,datasize2);
        startingx = max(1,cntx-ps1);
        startingy = max(1,cnty-ps1);
        endingx = min(cntx+ps1,datasize1);
        endingy = min(cnty+ps1,datasize2);
        tmp1(startingx:endingx,startingy:endingy) = imgsn(startingx:endingx,startingy:endingy);
        tmp2 = ifftshift(ifft2(ifftshift(tmp1)));
        [px,py] = sidm(tmp2);
        pxmap(cntx,cnty)=px;
        pymap(cntx,cnty)=py;
    end
end            
toc
pxmap_radppixel = pxmap-(datasize1/2);
pymap_radppixel = pymap-(datasize2/2);
pxmap_radppixel = -pxmap_radppixel*2*pi/datasize1;
pymap_radppixel = -pymap_radppixel*2*pi/datasize2;

preludephasemap_all = niftiread(partiallyUnwrapped_nii_file);
preludephasemap = preludephasemap_all(:,:,ChooseThisSlice);

preludemask = (preludephasemap ~=0);
preludephasemap_cpe = closest_point_estimation(preludephasemap,preludemask);

criticalROI_all = niftiread(criticalROI_nii_file);
criticalROI = criticalROI_all(:,:,ChooseThisSlice);

[L2x,L2y] = find(criticalROI==criticalROILabel);

if ~isempty(L2x)
    roiStartX = min(L2x)-1;
    roiEndX = max(L2x)+1;
    roiStartY = min(L2y)-1;
    roiEndY = max(L2y)+1;
    xdim = roiEndX-roiStartX+1;
    ydim = roiEndY-roiStartY+1;

    boundaryConditionMap = preludephasemap_cpe(roiStartX:roiEndX,roiStartY:roiEndY);
    mask = ones(xdim,ydim)-double(criticalROI(roiStartX:roiEndX,roiStartY:roiEndY));
    absimgsn = abs(imgsn);
    snr_ref = absimgsn(roiStartX:roiEndX,roiStartY:roiEndY).*mask;
    Lmap = snr_ref ./max(snr_ref(:));
    Lmap(:,1)=2.;
    Lmap(:,end)=2.;
    Lmap(1,:)=2.;
    Lmap(end,:)=2.;
    Mgv = pxmap_radppixel(roiStartX:roiEndX,roiStartY:roiEndY);
    Mgh = pymap_radppixel(roiStartX:roiEndX,roiStartY:roiEndY);

    M_recovered = twoDimIntegration(mask,boundaryConditionMap,Lmap,Mgv,Mgh);

    newPhaseMap = preludephasemap_cpe*1;
    newPhaseMap(roiStartX:roiEndX,roiStartY:roiEndY)= M_recovered;
    newPhaseMapMask = newPhaseMap.*preludemask;
else
    newPhaseMap = preludephasemap;
    newPhaseMapMask = newPhaseMap.*preludemask;
end

info1 = niftiinfo(partiallyUnwrapped_nii_file);
info1.Datatype = 'single';
output_all = preludephasemap_all;
output_all(:,:,ChooseThisSlice) = newPhaseMapMask;
output_all = single(output_all);
niftiwrite(output_all,output_nii_file,info1)

figure(1);imagesc(flip(permute([preludephasemap;newPhaseMapMask],[2,1]),1));colormap(hot);axis equal off; 
% figure(2);imagesc(flip(permute([preludephasemap_cpe;newPhaseMap],[2,1]),1));colormap(gray);axis equal off; 



