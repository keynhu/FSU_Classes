% Show one image that is stored as a vector
% Input:
%   v: Image vectormatrix (n x 1) -- n = #Pixels
% Output:
%   Display the image

function image_vec_show(v)
    I = reshape(v,28,23);
    imagesc(I);
    colormap(gray)
    axis equal;
end