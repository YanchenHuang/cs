function block_coefficients = ...
    compressedSenseImgL1(blocks, alpha, basis_oversampling)
% Sketch the image blocks in the image domain. Procedure:
%     1. Choose a random matrix to mix the DCT components.
%     2. Solve the L1-penalized least-squares problem.
% 
%     min_x ||Ax - m||_2^2 + alpha * ||x||_1
%     
%     where: m = sampled image,
%            x = representation,
%            A = mixing matrix,

    [M, N, B] = size(blocks); % blocks is a 3D array
    
    % Generate a mixing matrix.
    mixing = randn(round(M * N * basis_oversampling), M * N);
    
    % Iterate over all blocks. Store coefficients in a 2D array.
    block_coefficients = zeros(M * N, B);
    parfor i = 1:B
       block = blocks(:, :, i);
       coefficients = blockCompressedSenseL1(block, alpha, ...
                                             mixing, mixing);
       block_coefficients(:, i) = coefficients;
    end
end