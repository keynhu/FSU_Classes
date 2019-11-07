% This function plots the input vectors as side-by-side images.
% And predicted index is printed at top of each image.

% Input:
%   Image_mat: Image matrix (m x n) -- m = #Pixels, n = #Images
%   titles: Titles of each image
%   print_text: Texts of each image
%   fig_ind: Index given to the whole figure
% Output:
%   Plots of images, with texts printed on their top
function images_plot(Image_mat, titles, print_text, fig_ind)
    n = size(Image_mat, 2);
    figure(fig_ind); clf;
    set(gcf, 'position', [50, 50, 100 + n * 200, 400]);
    
    for j = 1:n
        subplot(1,n,j); 
        I = reshape(Image_mat(:,j),28,23);
        imagesc(I);
        colormap(gray);
        axis equal;   
        title(titles(j) + num2str(print_text(j)), 'fontsize', 15);
    end  
end
