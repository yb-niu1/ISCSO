

% Utility function
% Shift an array in 2D
% Examples: 
% B = noncircshift(A,[0 1]) > Right    
% noncircshift(A,[0 -1]) > Left 
% noncircshift(A,[1 1]) > Right Down 

function [B,src_indices,dest_indices]=noncircshift(A,offsets)
    siz=size(A);
    N=length(siz);
    if length(offsets)<N
       offsets(N)=0; 
    end
    B=zeros(siz);
    indices=cell(3,N);
    for ii=1:N
          for ss=[1,3]
           idx=(1:siz(ii))+(ss-2)*offsets(ii);
            idx(idx<1)=[];
            idx(idx>siz(ii))=[];
           indices{ss,ii}=idx;
          end
    end
    src_indices=indices(1,:);
    dest_indices=indices(3,:);
    B(dest_indices{:})=A(src_indices{:});
end